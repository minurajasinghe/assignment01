function x = bisection_solver(fun,x_left,x_right)
    mid = (x_right + x_left)/2;
    if (fun(mid) < 0.001) && (fun(mid) > -0.001)
        x = mid;
    elseif (((fun(x_left))> 0)&&(fun(mid) < 0))||(((fun(x_left) < 0)&&(fun(mid) > 0)))
        x = bisection_solver(fun, x_left, mid);
    elseif (((fun(mid))> 0)&&(fun(x_right) < 0))||(((fun(mid) < 0)&&(fun(x_right) > 0)))
        x = bisection_solver(fun, mid, x_right);
    end
end