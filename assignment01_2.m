%EDIT THIS:
solver_flag = 2;
x_guess0 = 0.75;

%DO NOT EDIT THIS
fun = input_fun();
num_iter = 1000;
guesslist1 = linspace(-6,-2,num_iter);
guesslist2 = linspace(2,6,num_iter);

%Filter Parameters
filter_max = 1e-1;
filter_min = 1e-14;
filter_list = [filter_min, filter_max];

convergence_analysis(solver_flag, fun, x_guess0, guesslist1, guesslist2, filter_list)
