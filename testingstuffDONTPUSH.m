egg_params = struct();
egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;
%specify the position and orientation of the egg
x0 = 5; y0 = 5; theta = pi/3;



%but only takes s as an input (other inputs are fixed)
%(single input)
compute_bounding_box(x0, y0, theta, egg_params)