function [p,k] = error_fit_coeffs(x_regression,y_regression)
    global Y;
    global X1;
    global X2;

    Y = log(y_regression)';
    X1 = log(x_regression)';
    X2 = ones(length(X1),1);

    % Run regression
    coeff_vec = regress(Y,[X1,X2]);
    
    % Get coeffs from fit
    p = coeff_vec(1);
    k = exp(coeff_vec(2));
end