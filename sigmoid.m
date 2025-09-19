xvals = linspace(0,50,200);
[fvals, dfdxvals] = sigmoid_func(xvals);

rootywooty = newton_solver(@sigmoid_func,27);

% % plot sigmoid
% figure;
% hold on;
% plot(xvals,fvals, LineWidth=2)
% ylim([-8,8])
% hold off;

success_list = [];
fail_list = [];

for n = 1:length(xvals)
    x_guess = xvals(n);
    % root_attempt = newton_solver(@sigmoid_func,x_guess);
    % root_attempt = secant_solver(@sigmoid_func,x_guess-1,x_guess,1e-14, 100);
    % root_attempt = bisection_solver(@sigmoid_func,x_guess-51,x_guess+51);
    root_attempt = fzero(@sigmoid_func,x_guess);


    if abs(rootywooty - root_attempt) < .1
        success_list(end+1) = x_guess;
    else
        fail_list(end+1) = x_guess;
    end

   

    [f_success , ~] = sigmoid_func(success_list);
    [f_fail , ~] = sigmoid_func(fail_list);
    
end

figure; hold on;
plot(xvals, fvals, LineWidth=1.5, Color='k');
success = plot(success_list, f_success, 'g.',MarkerSize=10);
fail = plot(fail_list, f_fail, 'r.',MarkerSize=10);
title("fzero Method Success/Failures for Sigmoid");
legend([success,fail],'Success', 'Fail');



function [f_val,dfdx] = sigmoid_func(x)
    % global input_list;
    % input_list(:,end+1) = x;
    a = 27.3; b = 2; c = 8.3; d = -3;
    H = exp((x-a)/b);
    dH = H/b;
    L = 1+H;
    dL = dH;
    f_val = c*H./L+d;
    dfdx = c*(L.*dH-H.*dL)./(L.^2);
end