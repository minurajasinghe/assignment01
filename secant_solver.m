function x = secant_solver(fun,x0, x1)
    x_n = x1 - fun(x1)*((x1 - x0)/(fun(x1)-fun(x0)));
    if (fun(x1) < 0.0000000001) && (fun(x1) > -0.00000000001)
        x = x1;
    else 
        x = secant_solver(fun,x1,x_n);
    end
end