%Function that computes the bounding box of an oval
%INPUTS:
%theta: rotation of the oval. theta is a number from 0 to 2*pi.
%x0: horizontal offset of the oval
%y0: vertical offset of the oval
%egg_params: a struct describing the hyperparameters of the oval
%OUTPUTS:
%x_range: the x limits of the bounding box in the form [x_min,x_max]
%y_range: the y limits of the bounding box in the form [y_min,y_max]
function [x_range,y_range] = compute_bounding_box(x0,y0,theta,egg_params)
    
    s_list = linspace(0, 5./6, 6);
    %specify the position and orientation of the egg
    %set up the axis
    hold on; axis equal; axis square
    axis([0,10,0,10])
    %plot the origin of the egg frame
    plot(x0,y0,'ro','markerfacecolor','r');
    %compute the perimeter of the egg
    [V_list, G_list] = egg_func(linspace(0,1,100),x0,y0,theta,egg_params);
    %plot the perimeter of the egg
    plot(V_list(1,:),V_list(2,:),'k');
    
    [find_V_list, find_G_list] = egg_func(s_list, x0, y0, theta, egg_params);

    %wrapper function that calls egg_wrapper1
    egg_wrapper2vert = @(s) egg_wrapper1(s, 1, x0,y0,theta,egg_params);
    egg_wrapper2horz = @(s) egg_wrapper1(s, 2, x0,y0,theta,egg_params);

    %egg_wrapper2vert(s) = gradient (we want 0) of s along egg vert =
    %output of 0
    %egg_wrapper2horz(s) = gradient (we want 0) of s along egg vert =
    %output of 0
    
    
    %Points where theres a vert or horz tangent
    horz_points = zeros(2,6); %dx/ds
    vert_points = []; %dy/ds
    horz_ses = zeros(1, 6);
    
    vert_ses = zeros(1, 6);
    for i = 1 : length(s_list)
        %[V_guess, G_guess] = egg_func(s_list(i), x0, y0, theta, egg_params);
        [topbottomroot, ~] = secant_solver(egg_wrapper2horz, s_list(i), s_list(i)+0.01, 0.001, 100);
        [leftrightroot, ~] = secant_solver(egg_wrapper2vert, s_list(i), s_list(i)+0.01, 0.001, 100);
        if abs(topbottomroot) > 2
            topbottomroot = 2; %secant didnt work, went off to infinity
        elseif topbottomroot > 1
            topbottomroot = topbottomroot - 1;
        elseif topbottomroot < 0
            topbottomroot = topbottomroot + 1;
        end
        if abs(leftrightroot) > 2
            leftrightroot = 2; %secant didnt work, went off to infinity
        elseif leftrightroot > 1
            leftrightroot = leftrightroot - 1;
        elseif leftrightroot < 0
            leftrightroot = leftrightroot + 1;
        end

        horz_ses(i) = topbottomroot;
        vert_ses(i) = leftrightroot;
    end

    disp(vert_ses)
    disp(horz_ses)
    
    [V_single, G_single] = egg_func(topbottomroot,x0,y0,theta,egg_params);
    
    
    
    %compute a single point along the egg (s=.8)
    
    
    
    
    
    %as well as the tangent vector at that point
    [V_single, G_single] = egg_func(topbottomroot,x0,y0,theta,egg_params);
    
    
    
    %plot this single point on the egg
    plot(V_single(1),V_single(2),'ro','markerfacecolor','r');
    
    
    
    %plot this tangent vector on the egg
    vector_scaling = .1;
    tan_vec_x = [V_single(1),V_single(1)+vector_scaling*G_single(1)];
    tan_vec_y = [V_single(2),V_single(2)+vector_scaling*G_single(2)];
    plot(tan_vec_x,tan_vec_y,'g')




end