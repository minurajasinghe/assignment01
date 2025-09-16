function [f_val,dfdx] = test_function02(x)
    global guess_list;
    guess_list(:,end+1) = x;
    f_val = (x-37.879).^2;
    dfdx = 2*(x-37.879);
end