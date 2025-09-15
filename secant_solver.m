function [root, iterates] = secant_solver(fun, x0, x1, tol, max_iter)
    
    iterates = [x0, x1];
    
    for n = 1:max_iter
        f0 = fun(x0);
        f1 = fun(x1);
        
        % Secant formula
        x_next = x1 - f1*(x1-x0)/(f1-f0);
        
        iterates(end+1) = x_next;
        
        % converge?
        if abs(fun(x_next)) < tol
            root = x_next;
            return
        end
        
        % Update
        x0 = x1;
        x1 = x_next;
    end
    
    root = x_next;
end
