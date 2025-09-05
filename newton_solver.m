function x = newton_solver(fun,x0)
    % Pull out the function and its derivative from the input function array
    
    func = fun{1};
    dfdx = fun{2};
    
    % Set intial starting point for Newton's Method to initial value input parameter
    
    x_init = x0;
    
    while abs(func(x_init)) > (1e-14)
        % Add break condition for 0 denominator
        if dfdx(x_init) == 0
            break
        end
        % Run update step for Newton's Method
        x1 = x_init - (func(x_init)./dfdx(x_init));
        
        % Check if difference is sufficiently small to consider a root found
        
        if abs(x1 - x_init) < (1e-14)
            x = x1;
            return
        end

        % Update x input for Newton's Method
        x_init = x1;
    end
    
    % Return current x value if while loop ends, makes sure an x value is assigned and returned
    x = x1;
end