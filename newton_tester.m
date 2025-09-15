filter_list = [1e-15, 1e-2, 1e-14, 1e-2, 2];
convergence_analysis_v2(2,@test_function01,1,[1,1],[1,1],[1e-14,1e-14])

%%
% filter_list = [1e-15, 1e-2, 1e-14, 1e-2, 2];
% newton_solver(@test_function01,1)

%% Newton's Method Error
global guess_list
guess_list = [];

num_iter = 100;

x0_list = linspace(-5,5,num_iter);

newt_x_current_list = [];
newt_x_next_list =[];
newt_id_list = [];

for n = 1:num_iter
    x0 = x0_list(n);
    guess_list = [];

    newton_root = newton_solver(@test_function01,x0);
    newt_x_current_list = [newt_x_current_list, guess_list(1:end-1)];
    newt_x_next_list = [newt_x_next_list, guess_list(2:end)];
    newt_id_list = [newt_id_list,1:length(guess_list)-1];
end

newt_e_list0 = abs(newt_x_current_list - newton_root);
newt_e_list1 = abs(newt_x_next_list - newton_root);

figure;
loglog(newt_e_list0,newt_e_list1,'ro','markerfacecolor','r','markersize',3); hold on;

newt_x_regression = []; % e_n
newt_y_regression = []; % e_{n+1}
%iterate through the collected data
for n=1:length(newt_id_list)
    %if the error is not too big or too small
    %and it was enough iterations into the trial...
    if newt_e_list0(n)>1e-15 && newt_e_list0(n)<1e-2 && ...
    newt_e_list1(n)>1e-14 && newt_e_list1(n)<1e-2 && ...
    newt_id_list(n)>2
    %then add it to the set of points for regression
    newt_x_regression(end+1) = newt_e_list0(n);
    newt_y_regression(end+1) = newt_e_list1(n);
    end
end

loglog(newt_x_regression,newt_y_regression,'bo','MarkerFaceColor','b','MarkerSize',2);

% Get error regression fit coefficients
[newt_p,newt_k] = error_fit_coeffs(newt_x_regression,newt_y_regression);

%generate x data on a logarithmic range
newt_fit_line_x = 10.^[-16:.01:1];
%compute the corresponding y values
newt_fit_line_y = newt_k*newt_fit_line_x.^newt_p;
%plot on a loglog plot.
loglog(newt_fit_line_x,newt_fit_line_y,'k-','linewidth',1)

% Finite difference approximation to evaluate k
[dfdx,d2fdx2] = approximate_derivative(@test_function01,newton_root);
k = abs(.5*(d2fdx2/dfdx));