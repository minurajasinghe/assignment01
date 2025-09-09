function convergence_analysis(solver_flag, fun, x_guess0, guess_list1, guess_list2, filter_list)
    num_iter = 1000; %Number of times to run root finding for error plot

    % Define Abs Zero
    abs_zero = fzero(fun);

    % Define global Variables
    global guess_list;
    guess_list = [];



    % Bisection Method
    if (solver_flag == 1)
        
    % Newtons Method
    elseif (solver_flag == 2)

    % Secant Method
    elseif (solver_flag == 3)
        

    % Fzero
    elseif (solver_flag == 4)
        

    end

    x_current_list = [];
    x_next_list = [];
    id_list = [];

    for n = 1:num_iter
        x0 = x0_list(n);
        guess_list = [];
        
        root = newton_solver(fun,x0);
        
        newt_x_current_list = [newt_x_current_list, newton_guess_list(1:end-1)];
        newt_x_next_list = [newt_x_next_list, newton_guess_list(2:end)];
        newt_id_list = [newt_id_list,1:length(newton_guess_list)-1];
    end



    
end