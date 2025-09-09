%EDIT THIS:
solver_flag = 1;
x_guess0 = 0.75;

%DO NOT EDIT THIS
fun = input_fun();
num_iter = 1000;
guesslist1 = linspace(-5,-1,num_iter);
guesslist2 = linspace(1,6,num_iter);

%Filter Parameters
filter_max = 1e-2;
filter_min = 1e-16;
filter_list = [filter_min, filter_max];

convergence_analysis(solver_flag, fun, x_guess0, guesslist1, guesslist2, filter_list)
