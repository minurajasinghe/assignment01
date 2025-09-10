function x = newton_solver(fun,x0,filter_list)

    % Initialize global variable
    global guess_list;
    
    % Initialize to be empty array
    guess_list = [];
    
    % Grab filter list values
    ytol = filter_list(1);
    dxtol = filter_list(2);

    % Set intial starting point for Newton's Method to initial value input parameter
    x_init = x0;

    % Evaluate function at current guess
    [f, dfdx] = fun(x_init);
    
    while abs(f) > ytol
        % Add previous guess to guess list
        guess_list(end+1,1) = x_init;

        % Add break condition for 0 denominator
        if dfdx == 0
            break
        end
        % Run update step for Newton's Method
        x1 = x_init - (f./dfdx);
        
        % Check if difference is sufficiently small to consider a root found
        
        if abs(x1 - x_init) < dxtol
            x = x1;
            return
        end

        % Update x input for Newton's Method
        x_init = x1;

        % Re-evaluate function and derivative
        [f, dfdx] = fun(x_init);
    end
    
    % Return current x value if while loop ends, makes sure an x value is assigned and returned
    x = x1;
end