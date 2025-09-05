function x = newton_solver(fun,x0)

    func = fun{1};
    dfdx = fun{2};
    
    x_init = x0;
    
    while abs(func(x_init)) > (1e-14)
        x1 = x_init - (func(x_init)./dfdx(x_init));
        if abs(x1 - x_init) < (1e-14)
            x = x1;
            return
        end
        x_init = x1;
    end
    x = x_init;
end