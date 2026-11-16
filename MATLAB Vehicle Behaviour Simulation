clc; clear; close all;

%% Simulation parameters
dt = 0.1; T = 20;
time = 0:dt:T;

%% Lead vehicle
v_lead = 20 + 5*sin(0.2*time);
x_lead = 50 + cumsum(v_lead*dt);

%% Host vehicle
x_host = 0;
v_host = 15;
d_safe = 20;
Kp = 0.5; Kd = 0.3;

x_host_arr = zeros(size(time));
v_host_arr = zeros(size(time));
a_host_arr = zeros(size(time));
d_arr = zeros(size(time));

%% Simulation loop
for i = 1:length(time)
    d = x_lead(i) - x_host;
    d_arr(i) = d;
    
    v_rel = v_lead(i) - v_host;
    a_host = Kp*(d - d_safe) + Kd*v_rel;
    
    v_host = v_host + a_host*dt;
    x_host = x_host + v_host*dt;
    
    x_host_arr(i) = x_host;
    v_host_arr(i) = v_host;
    a_host_arr(i) = a_host;
end

%% Plotting (speed first)
figure;
subplot(3,1,1);
plot(time, v_host_arr,'r','LineWidth',1.5); hold on;
plot(time, v_lead,'k--','LineWidth',1.5);
ylabel('Speed (m/s)'); legend('Host','Lead'); grid on;

subplot(3,1,2);
plot(time, d_arr,'b','LineWidth',1.5); ylabel('Distance to Lead (m)'); grid on;

subplot(3,1,3);
plot(time, a_host_arr,'g','LineWidth',1.5); ylabel('Acceleration (m/s^2)'); xlabel('Time (s)'); grid on;
