function egg_video()
    %define location and filename where video will be stored
    %written a bit weird to make it fit when viewed in assignment
    mypath1 = 'C:\Users\clinehan\Downloads\';
    fname='egg_animation.avi';
    input_fname = [mypath1,fname];
    %create a videowriter, which will write frames to the animation file
    writerObj = VideoWriter(input_fname);
    %must call open before writing any frames
    open(writerObj);
    
    %initialize the current figure and save as object
    fig1 = figure(1);
    set(fig1, 'WindowState', 'maximized');
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
    
    xlabel('x')
    ylabel('y')

    title('Egg Animation')

    y_ground = 2;
    x_wall = 35;
    yline(y_ground, '--k', 'LineWidth', 1.5); 
    xline(x_wall, '--k', 'LineWidth', 1.5);

    [t_ground,t_wall] = collision_func(@egg_trajectory01, egg_params, y_ground, x_wall);
    t_stop = min(t_ground, t_wall);

    %iterate through time
    for t=0:.015:5
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
        %capture a frame (what is currently plotted)
        current_frame = getframe(fig1);
        %write the frame to the video
        writeVideo(writerObj,current_frame);
    end
    %make it stop for a second
    fps = writerObj.FrameRate;    
    n_hold = round(fps * 1);        % 1 second 

    % capture the last frame once
    last_frame = getframe(fig1);

    % write it multiple times to hold the image
    for i = 1:n_hold
        writeVideo(writerObj, last_frame);
    end
    %must call close after all frames are written
    close(writerObj);
end
