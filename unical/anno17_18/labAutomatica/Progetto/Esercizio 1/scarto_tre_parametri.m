function media_q_err = scarto_tre_parametri(x)
    load datiMIO.mat;
    k = x(1); tau = x(2); Tt = x(3);
    
    media_q_err = 0;
    for i = 1:length(Y)
        media_q_err = media_q_err + ((Y(i) - k*(1 - exp(-(T(i)-tau)/Tt))).^2);
    end
    media_q_err = media_q_err/length(Y);