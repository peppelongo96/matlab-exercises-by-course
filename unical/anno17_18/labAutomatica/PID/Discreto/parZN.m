function [kp, ti, td] = parZN(reg, K, tau, T)
    ti = []; td = [];
    if(reg == "P")
        kp = T/(K*tau);
    elseif(reg == "PI")
        kp = 0.9*T/(K*tau);
        ti = 3.3*tau;
    elseif(reg == "PD")
        kp = 12*T/(K*tau);
        td = 0.3*tau;
    else
        kp = 1.2*T/(K*tau);
        ti = 2*tau;
        td = 0.5*tau;
    end        
end

