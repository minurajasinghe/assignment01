%EDIT THIS:
solver_flag = 2;
x_guess0 = 0.75;

%DO NOT EDIT THIS
fun = @test_function01;
num_iter = 1000;
guesslist1 = linspace(-6,-2,num_iter);
guesslist2 = linspace(6,2,num_iter);

filter_list = [1e-15, 1e-2, 1e-14, 1e-2, 2];

convergence_analysis_v2(solver_flag,fun,x_guess0,guess_list1,guess_list2, filter_list)
