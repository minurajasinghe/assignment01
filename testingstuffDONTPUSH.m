clear;
egg_params = struct();
egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;
%specify the position and orientation of the egg
x0 = 8; y0 = 6; theta = pi/.76;



%but only takes s as an input (other inputs are fixed)
%(single input)
%compute_bounding_box(x0, y0, theta, egg_params);

t_vals = linspace(0, 40, 100);
x_vals = 7.*t_vals + 8;
y_vals = -6.*t_vals.^2 + 20.*t_vals + 6;
plot(x_vals, y_vals); hold on;

y_ground = 5;
x_wall = 32;

[t_ground,t_wall, x_corners, y_corners] = collision_func(@egg_trajectory01, egg_params, y_ground, x_wall);
plot(x_corners, y_corners, 'b', 'LineWidth', 2);
yline(y_ground, '--k', 'LineWidth', 1.5); 
xline(x_wall, '--k', 'LineWidth', 1.5);