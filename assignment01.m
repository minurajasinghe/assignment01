% Definition of the test function and its derivative
test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;

x_list = linspace(-15,40,100);
y_list = test_func01(x_list);

%% Plot Function

clf;
figure;
plot(x_list,y_list,'r')
hold on
plot([-15 40],[0,0], '--','Color','k')
ylim([-45,80])
xlim([-15, 40])

%%