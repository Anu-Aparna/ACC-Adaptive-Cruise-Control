clc; clear;

figure; hold on; grid on;
axis equal;
xlim([-100 100])
ylim([0 200])

xlabel('Lateral Distance (m)')
ylabel('Longitudinal Distance (m)')

%% Road boundaries
y = linspace(0,200,200);
plot(-3*ones(size(y)), y, 'k', 'LineWidth', 1)
plot( 3*ones(size(y)), y, 'k', 'LineWidth', 1)

%% Vision sensor coverage (blue)
theta_v = linspace(-40,40,100)*pi/180;
r_v = 150;

xv = [0 r_v*sin(theta_v) 0];
yv = [0 r_v*cos(theta_v) 0];

fill(xv, yv, 'b', 'FaceAlpha', 0.15, 'EdgeColor', 'b')

%% Radar sensor coverage (red)
theta_r = linspace(-20,20,100)*pi/180;
r_r = 180;

xr = [0 r_r*sin(theta_r) 0];
yr = [0 r_r*cos(theta_r) 0];

fill(xr, yr, 'r', 'FaceAlpha', 0.15, 'EdgeColor', 'r')

%% Ego vehicle
plot(0, 0, 'ks', 'MarkerFaceColor', 'k', 'MarkerSize', 8)

%% Vision detections (blue dots)
vision_targets = [...
   -5 40;
    4 85;
   -8 130];

scatter(vision_targets(:,1), vision_targets(:,2), ...
        50, 'b', 'filled')

%% Radar detections (red dots)
radar_targets = [...
    2 45;
   -4 90;
    6 165];

scatter(radar_targets(:,1), radar_targets(:,2), ...
        50, 'r', 'filled')

%% Tracks (yellow squares)
tracks = [...
    -3 42;
     1 88];

scatter(tracks(:,1), tracks(:,2), ...
        70, 's', 'MarkerEdgeColor','k', ...
        'MarkerFaceColor','y')

%% Legend
legend({'Road Boundaries','Vision Coverage','Radar Coverage', ...
        'Ego Vehicle','Vision Detections','Radar Detections','Tracks'}, ...
        'Location','northoutside','Orientation','horizontal')
