function [kp, ti, td] = parZN(reg, kCr, TCr)
    ti = []; td = [];
    if(reg == "P")
        kp = 0.5*kCr;
    elseif(reg == "PI")
        kp = 0.45*kCr;
        ti = 0.85*TCr;
    else
        kp = 0.6*kCr;
        ti = 0.5*TCr;
        td = 0.12*TCr;
    end        
end

