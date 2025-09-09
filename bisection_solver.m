function x = bisection_solver(fun,x_left,x_right)
    
    global guess_list;

    %Create bisection
    mid = (x_right + x_left)/2;
    
    %Check if bisection is within tolerance of 0
    if (fun(mid) < 0.00001) && (fun(mid) > -0.00001)
        x = mid;

    %If left and mid are new points (opposite signs)
    elseif (((fun(x_left))> 0)&&(fun(mid) < 0))||(((fun(x_left) < 0)&&(fun(mid) > 0)))
        %Call bisection_solver recursively
        guess_list(end+1) = x_right;
        x = bisection_solver(fun, x_left, mid);
    % If mid and right are new points (opposite signs)

    elseif (((fun(mid))> 0)&&(fun(x_right) < 0))||(((fun(mid) < 0)&&(fun(x_right) > 0)))
        %Call bisection_solver recursively
        guess_list(end+1) = x_left;
        x = bisection_solver(fun, mid, x_right);
    end
end