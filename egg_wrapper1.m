%wrapper function that calls egg_func
%and only returns the x coordinate of the
%point on the perimeter of the egg
%(single output)
function d__out = egg_wrapper1(s,d_what, x0,y0,theta,egg_params)
    [V, G] = egg_func(s,x0,y0,theta,egg_params);
    if d_what == 1 %vert
        %disp(G(1))
        d__out = G(1);
    elseif d_what == 2 %horz
        %disp(G(2))
        d__out = G(2);
    else
        disp('WRONG D_WHAT')
    end
end