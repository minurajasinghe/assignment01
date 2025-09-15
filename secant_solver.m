function x = secant_solver(fun,x0, x1)
%Takes function, and two initial guesses

    %global guess_list;
    %creates global variable to be able to call variable withing other
    %functions

    x_n = x1 - fun(x1)*((x1 - x0)/(fun(x1)-fun(x0)));
    %Secant root finding formula

    if (fun(x1) < 10^-14) && (fun(x1) > -10^-14)
        x = x1;
        %States that if a guess creates an output ("y" value) within the bounds of 10^14 to -10^14
        %then it is close enough to 0 to be a root
    else 
        %guess_list(end+1) = x1;
        x = secant_solver(fun,x1,x_n);
        % If the first "if" statement is not applicable, then the newly
        % guess values is apended to the vector of guesses and the function
        % is run again with the last guess and the newest guess
    end
end
