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
    hold on; axis equal; 
    axis([0,40,0,40])
    
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
    
    horz_ses = zeros(3, 6);
    % FORM OF ses:
    % [s1   s2   s3   s4   s5   s6]
    % [x1   x2   x3   x4   x5   x6]
    % [y1   y2   y3   y4   y5   y6]
    vert_ses = zeros(3, 6);
    for i = 1 : length(s_list)
        %[V_guess, G_guess] = egg_func(s_list(i), x0, y0, theta, egg_params);
        [topbottomroot, ~] = secant_solver(egg_wrapper2horz, s_list(i), s_list(i)+0.01, 0.001, 100);
        [leftrightroot, ~] = secant_solver(egg_wrapper2vert, s_list(i), s_list(i)+0.01, 0.001, 100);
        
        %fixing odditys
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

        horz_ses(1, i) = topbottomroot;
        [V_guess_tb, ~] = egg_func(topbottomroot, x0, y0, theta, egg_params);
        horz_ses(2, i) = V_guess_tb(1);
        horz_ses(3, i) = V_guess_tb(2);

        vert_ses(1, i) = leftrightroot;
        [V_guess_lr, ~] = egg_func(leftrightroot, x0, y0, theta, egg_params);
        vert_ses(2, i) = V_guess_lr(1);
        vert_ses(3, i) = V_guess_lr(2);
    end
    
%~~~~~~~~~~~~~~~Filter Through the points for our 2 TOP/BOTTOM points~~~~
    tolerance = 0.001;   % closeness threshold
    tbpoints = transpose(horz_ses);    
    tbunique_points = [];   
    for i = 1:size(tbpoints,1)
        p = tbpoints(i,:);
        is_duplicate = false;
        if p(1) == 2
            continue %secant failed, went to infinity
        end
        % Check against all saved unique points
        for j = 1:size(tbunique_points,1)
            if abs(p(1)-tbunique_points(j,1)) < tolerance && ...
               abs(p(2)-tbunique_points(j,2)) < tolerance && ...
               abs(p(3)-tbunique_points(j,3)) < tolerance
                is_duplicate = true;
                break;
            end
        end
        % If not a duplicate, save it
        if ~is_duplicate
            tbunique_points = [tbunique_points; p];
        end
    end
    top_bottom_points = transpose(tbunique_points);

    %~~~~~~~~~~~~~~~Filter Through the points for our 2 LEFT/RIGHT points~~~~
    lrpoints = transpose(vert_ses);    
    lrunique_points = [];   
    for i = 1:size(lrpoints,1)
        p = lrpoints(i,:);
        is_duplicate = false;
        if p(1) == 2
            continue %secant failed, went to infinity
        end
        % Check against all saved unique points
        for j = 1:size(lrunique_points,1)
            if abs(p(1)-lrunique_points(j,1)) < tolerance && ...
               abs(p(2)-lrunique_points(j,2)) < tolerance && ...
               abs(p(3)-lrunique_points(j,3)) < tolerance
                is_duplicate = true;
                break;
            end
        end
        % If not a duplicate, save it
        if ~is_duplicate
            lrunique_points = [lrunique_points; p];
        end
    end
    top_bottom_points = transpose(tbunique_points);
    left_right_points = transpose(lrunique_points);
    %%%Boundary BOX!!!
    x_min = min(left_right_points(2, :));
    x_max = max(left_right_points(2, :));

    y_min = min(top_bottom_points(3,:));
    y_max = max(top_bottom_points(3,:));
    

    %rectangle('Position',[x_min, y_min, x_max-x_min, y_max-y_min],'EdgeColor','b','LineWidth',1);
    
    
    x_range = [x_min, x_max];
    y_range = [y_min, y_max];
    
    
    %compute a single point along the egg (s=.8)
    
    
    
    
    
    %as well as the tangent vector at that point
    %[V_single, G_single] = egg_func(topbottomroot,x0,y0,theta,egg_params);
    
    
    
    %plot this single point on the egg
    %plot(V_single(1),V_single(2),'ro','markerfacecolor','r');
    
    
    
    %plot this tangent vector on the egg
    % vector_scaling = .1;
    % tan_vec_x = [V_single(1),V_single(1)+vector_scaling*G_single(1)];
    % tan_vec_y = [V_single(2),V_single(2)+vector_scaling*G_single(2)];
    % plot(tan_vec_x,tan_vec_y,'g')




end