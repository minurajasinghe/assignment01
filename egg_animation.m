%Short example demonstrating how to create a MATLAB animation
%In this case, a square moving along an elliptical path
function egg_animation()
    
    
    hold on
    %Define the coordinates of the square vertices (in its own frame)
    egg_params = struct();
    egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;
    %plot the perimeter of the eg

    %V_list(1,:) is square coords x

    %set up the plotting axis
    hold on; 
    axis([0,80,0,80])
    %initialize the plot of the square
    square_plot = plot(0,0,'k');
    y_ground = 2;
    x_wall = 35;
    yline(y_ground, '--k', 'LineWidth', 1.5); 
    xline(x_wall, '--k', 'LineWidth', 1.5);

    [t_ground,t_wall] = collision_func(@egg_trajectory01, egg_params, y_ground, x_wall);
    t_stop = min(t_ground, t_wall) - 0.01;
    %iterate through time
    for t=0:.002:5
        if t > t_stop
            break
        end
        [x_func, y_func, theta] = egg_trajectory01(t);
        [V_list, ~] = egg_func(linspace(0,1,100),x_func,y_func,theta,egg_params);
        
        %compute positions of egg vertices (in world frame)
        x_plot = V_list(1,:);% +x_func;
        y_plot = V_list(2,:);%+y_func;
        %update the coordinates of the square plot
        set(square_plot,'xdata',x_plot,'ydata',y_plot);
        %update the actual plotting window
        drawnow;
    end
end