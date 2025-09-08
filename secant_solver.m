function x = secant_solver(fun,x0, x1)
    global secant_guess_list;

    x_n = x1 - fun(x1)*((x1 - x0)/(fun(x1)-fun(x0)));
    if (fun(x1) < 10^-14) && (fun(x1) > -10^-14)
        x = x1;
    else 
        secant_guess_list(end+1) = x1;
        x = secant_solver(fun,x1,x_n);
    end
end
