%% 
%EDIT THIS:
clear;
solver_flag = 4;
x_guess0 = .75;

%DO NOT EDIT THIS
fun = @test_function01;
num_iter = 1000;
guesslist1 = linspace(-6,-2,num_iter);
guesslist2 = linspace(6,2,num_iter);
% guesslist1 = linspace(32,-35,num_iter);
% guesslist2 = linspace(40,43,num_iter);
filter_list = [1e-15, 1e-2, 1e-14, 1e-2, 2];

convergence_analysis_v2(solver_flag,fun,x_guess0,guesslist1,guesslist2, filter_list)
