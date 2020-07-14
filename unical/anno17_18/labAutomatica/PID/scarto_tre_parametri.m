function media_q_err = scarto_tre_parametri(x)
    k = x(1); tau = x(2); Tt = x(3);
    
    load datisperimentali.mat;
    
    media_q_err = [];
    
    % scarti_quad = (Y - k*(1 - exp(-(T-tau)/Tt))).^2;
    % media_q_err = sum(scart_quad)/length(Y);
    
    for i = 1:length(Y)
        media_q_err = media_q_err + (Y(i) - k*(1 - exp(-(T(i)-tau)/Tt)))^2;
    end
    media_q_err = media_q_err/length(Y);