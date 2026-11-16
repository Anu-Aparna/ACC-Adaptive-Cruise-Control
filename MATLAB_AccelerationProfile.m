t = 0:0.1:80;

% Acceleration profiles
ego_acc = 0.6*sin(0.2*t) + 0.3*sin(0.05*t);
ego_acc(1:30) = ego_acc(1:30) + linspace(1.5, 0, 30);
ego_acc(250:270) = ego_acc(250:270) - 1;
ego_acc(550:570) = ego_acc(550:570) - 1;

lead_acc = 0.5*sin(0.2*t);

% Velocity profiles
set_speed = 30*ones(size(t));
ego_vel = 25 + cumtrapz(t, ego_acc)*0.5;
lead_vel = 26 + cumtrapz(t, lead_acc)*0.5;

% Distance profiles
safe_dist = 50 + 2*sin(0.15*t);
actual_dist = safe_dist + 5*sin(0.1*t);
actual_dist(1:50) = actual_dist(1:50) - 10;

% Plot
figure

subplot(3,1,1)
plot(t, ego_acc, 'r', 'LineWidth', 1.5)
hold on
plot(t, lead_acc, 'b', 'LineWidth', 1.5)
grid on
title('Acceleration')
ylabel('m/s^2')
legend('ego', 'lead')

subplot(3,1,2)
plot(t, ego_vel, 'r', 'LineWidth', 1.5)
hold on
plot(t, lead_vel, 'b', 'LineWidth', 1.5)
plot(t, set_speed, 'k--', 'LineWidth', 1.2)
grid on
title('Velocity')
ylabel('m/s')
legend('ego', 'lead', 'set')

subplot(3,1,3)
plot(t, actual_dist, 'r', 'LineWidth', 1.5)
hold on
plot(t, safe_dist, 'b', 'LineWidth', 1.5)
grid on
title('Distance between two cars')
ylabel('m')
xlabel('time (sec)')
legend('actual', 'safe')
