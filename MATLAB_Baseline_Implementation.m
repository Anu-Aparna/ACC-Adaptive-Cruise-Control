%% Adaptive Cruise Control (ACC) Simulation
% Strict baseline implementation

clear; clc;

%% Simulation Parameters
dt = 0.01;          % Time step (s)
T  = 30;            % Total simulation time (s)
t  = 0:dt:T;

%% Vehicle Parameters
v0_ego   = 20;      % Initial ego speed (m/s)
v0_lead  = 22;      % Initial lead speed (m/s)
d0       = 30;      % Initial distance (m)

%% ACC Parameters
h  = 1.5;           % Time headway (s)
d_min = 5;          % Minimum gap (m)
Kp = 0.6;           % Proportional gain
Kd = 0.4;           % Derivative gain

%% Limits
a_max = 2;          % Max acceleration (m/s^2)
b_max = -3;         % Max braking (m/s^2)

%% Initialize States
v_ego  = v0_ego;
v_lead = v0_lead;
d      = d0;

%% Data Storage
Vego = zeros(size(t));
Vlead = zeros(size(t));
Dist = zeros(size(t));
Acc  = zeros(size(t));

%% Simulation Loop
for k = 1:length(t)

    % Desired spacing
    d_des = d_min + h * v_ego;
    
    % Spacing error
    e = d - d_des;
    
    % Relative speed
    dv = v_lead - v_ego;
    
    % ACC control law
    a_cmd = Kp*e + Kd*dv;
    
    % Apply acceleration limits
    a_cmd = min(max(a_cmd, b_max), a_max);
    
    % Update ego vehicle
    v_ego = v_ego + a_cmd*dt;
    v_ego = max(v_ego,0);
    
    % Lead vehicle behavior (lead slows down after 10s)
    if t(k) > 10
        v_lead = 18; % lead brakes slightly
    end
    
    % Update distance
    d = d + (v_lead - v_ego)*dt;
    
    % Store data
    Vego(k)  = v_ego;
    Vlead(k)= v_lead;
    Dist(k) = d;
    Acc(k)  = a_cmd;
end

%% Plots

figure;
plot(t,Dist,'LineWidth',1.5);
xlabel('Time (s)');
ylabel('Distance (m)');
title('Inter-Vehicle Distance');
grid on;

figure;
plot(t,Vego,'b','LineWidth',1.5); hold on;
plot(t,Vlead,'r--','LineWidth',1.5);
xlabel('Time (s)');
ylabel('Speed (m/s)');
legend('Ego','Lead');
title('Vehicle Speeds');
grid on;

figure;
plot(t,Acc,'k','LineWidth',1.5);
xlabel('Time (s)');
ylabel('Acceleration (m/s^2)');
title('Ego Acceleration Command');
grid on;
