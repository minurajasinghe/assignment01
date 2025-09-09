function convergence_analysis_v2(solver_flag, fun, x_guess0, guess_list1, guess_list2, filter_list)
    num_iter = 1000; %Number of times to run root finding for error plot

    % Define Abs Zero
    rootywooty = fzero(fun{1}, x_guess0);

    % Define global Variables
    global guess_list;
    guess_list = [];


    x_current_list = [];
    x_next_list = [];
    id_list = [];

    for n = 1:num_iter
        x0 = guess_list1(n);%+ rand();
        x1 = guess_list2(n);%+ rand();
        guess_list = [];
        
        % Bisection Method
        if (solver_flag == 1)
            root = bisection_solver(fun{1},x0, x1);
        % Newtons Method
        elseif (solver_flag == 2)
            root = newton_solver(fun,x0);
        % Secant Method
        elseif (solver_flag == 3)
            root = secant_solver(fun{1},x0, x1);
        % Fzero
        elseif (solver_flag == 4)
            root = fzero(fun{1},x0);
        else
            disp("solver_flag must be 1 - 4")
        end
        
        x_current_list = [x_current_list, guess_list(1:end-1)];
        x_next_list = [x_next_list, guess_list(2:end)];
        id_list = [id_list,1:length(guess_list)-1];
    end
    

    e_list0 = abs(x_current_list - rootywooty);
    e_list1 = abs(x_next_list - rootywooty);
    
    figure;
    loglog(e_list0, e_list1,'ro','markerfacecolor','r','markersize',3); 
    ylim([1e-20, 1e3]); 
    xlabel("Error (n)")
    ylabel("Error (n+1)")
    if (solver_flag == 1)
        title("Bisection Method")
    % Newtons Method
    elseif (solver_flag == 2)
        title("Newton Method")
    % Secant Method
    elseif (solver_flag == 3)
        title("Secant Method")
    % Fzero
    elseif (solver_flag == 4)
        title("fzero")
    else
        disp("solver_flag must be 1 - 4")
    end
    hold on;
    
    x_regression = []; % e_n
    y_regression = []; % e_{n+1}
    %iterate through the collected data
    for n=1:length(id_list)
        %if the error is not too big or too small
        %and it was enough iterations into the trial...
        if e_list0(n)>filter_list(1) && e_list0(n)<filter_list(2) && ...
        e_list1(n)>filter_list(1) && e_list1(n)<filter_list(2) && ...
        id_list(n)>2
        %then add it to the set of points for regression
        x_regression(end+1) = e_list0(n);
        y_regression(end+1) = e_list1(n);
        end
    end

    loglog(x_regression, y_regression,'bo','MarkerFaceColor','b','MarkerSize',2);
    
    % Get error regression fit coefficients
    [ex_p,ex_k] = error_fit_coeffs(x_regression, y_regression);
    
    %generate x data on a logarithmic range
    fit_line_x = 10.^[-16:.01:1];
    %compute the corresponding y values
    fit_line_y = ex_k*fit_line_x.^ex_p;
    %plot on a loglog plot.
    loglog(fit_line_x, fit_line_y,'k-','linewidth',1)
    

    % % Bisection Method
    % if (solver_flag == 1)
    %     k = 0.5;
    %     p = 1;
    % % Newtons Method
    % elseif (solver_flag == 2)
    % 
    % % Secant Method
    % elseif (solver_flag == 3)
    % 
    % % Fzero
    % elseif (solver_flag == 4)
    % 
    % else
    %     disp("solver_flag must be 1 - 4")
    % end
    % Finite difference approximation to evaluate k
    [dfdx,d2fdx2] = approximate_derivative(fun{1}, rootywooty);
    k = abs(.5*(d2fdx2/dfdx));



    
end