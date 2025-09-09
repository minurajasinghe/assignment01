% Definition of the test function and its derivative
test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;

%Create Global Variables
global bisect_guess_list;
global newton_guess_list;
global secant_guess_list;
bisect_guess_list = [];
newton_guess_list = [];
secant_guess_list = [];

%% Plot Function


x_list = linspace(-15,40,100);
y_list = test_func01(x_list);

clf;
plot(x_list,y_list,'r')
hold on
plot([-15 40],[0,0], '--','Color','k')
ylim([-45,80])
xlim([-15, 40])
hold off;

%% Root solvers
x0 = 1;
x_left = -15;
x_right = 30;
x_1 = -15;
x_2 = 30;

fun = input_fun();

root_bisect = bisection_solver(fun{1},x_left,x_right);
root_newton = newton_solver(fun,x0);
root_secant = secant_solver(fun{1},x_1,x_2);

%% Newton's Method Error
num_iter = 1000;

x0_list = linspace(-5,5,num_iter);

newt_x_current_list = [];
newt_x_next_list =[];
newt_id_list = [];

for n = 1:num_iter
    x0 = x0_list(n);
    newton_guess_list = [];

    newton_root = newton_solver(fun,x0);
    
    newt_x_current_list = [newt_x_current_list, newton_guess_list(1:end-1)];
    newt_x_next_list = [newt_x_next_list, newton_guess_list(2:end)];
    newt_id_list = [newt_id_list,1:length(newton_guess_list)-1];
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
[dfdx,d2fdx2] = approximate_derivative(fun{1},newton_root);
k = abs(.5*(d2fdx2/dfdx));

%% Error


bisect_error_list = bisect_guess_list - root_bisect;
