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


% x_list = linspace(-15,40,100);
% y_list = test_func01(x_list);

% clf;
% figure;
% plot(x_list,y_list,'r')
% hold on
% plot([-15 40],[0,0], '--','Color','k')
% ylim([-45,80])
% xlim([-15, 40])

%% Root solvers
x0 = 1;
x_left = -15;
x_right = 30;
x_1 = -15;
x_2 = 30;

fun = input_fun();

root_bisect = bisection_solver(fun{1},x_left,x_right);
[root_newton,x_n] = newton_solver(fun,x0);
root_secant = secant_solver(fun{1},x_1,x_2);



%% Error


bisect_error_list = bisect_guess_list - root_bisect;
