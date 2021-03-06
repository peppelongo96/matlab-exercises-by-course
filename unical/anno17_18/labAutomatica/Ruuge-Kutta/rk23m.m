function [t,x] = rk23m(f, tval, x0, h)
    tcorr = tval(1) + h;
    xcorr = x0;
    x = x0;
    t = tval(1);
    i = 0;
    while(tval(1) + i*h < tval(2))
       k1 = feval(f,tcorr,xcorr);
       k2 = feval(f,tcorr+(h/2),xcorr+(h/2)*k1);
       k3 = feval(f,tcorr+(h/2),xcorr+(h/2)*k2);
       k4 = feval(f,tcorr+h,xcorr+k3);
       t = [t tval(1)+i*h];
       x = [x; xcorr + (h/6)*(k1 + 2*k2 + 2*k3 + k4)];

       i = i + 1; xcorr = x(end,:); tcorr = t(end);
    end
end