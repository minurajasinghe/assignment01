function [f_val,dfdx] = test_function01(x)
    % Hardcode function and it's derivative into a cell array with anonymous function
    global guess_list;
    guess_list(:,end+1) = x;
    f_val = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
    dfdx = 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
end