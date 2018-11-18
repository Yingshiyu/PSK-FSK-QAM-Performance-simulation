function [ Ps_exact_fsk,P_nearest_fsk,P_sim_fsk ] = funfsk( ~ )

clear;

step_Eb = 1;
Eb_No_db = [-5:step_Eb:15];
Es = 1;
N = 10000;

for M = [2 4 8 16]
    for L = 1 : length(Eb_No_db)
        
        num_Eb_No_db = Eb_No_db(L);
        Eb_No_linear = 10^(num_Eb_No_db/10);
        Es_No_linear = Eb_No_linear*log2(M);
        sgma = sqrt(Es/(2*Eb_No_linear*log2(M)));
        N0 = 2*sgma^2;
        number_of_symbol_error = 0; 
        
        for i = 1 : 1 : N
            BB_signal = zeros(1,M); 
            transmitted_index = 1 + floor(rand*M);
            BB_signal(transmitted_index) = 1;
            for n = 1 : 1 : M
                noise(1,n) = randn*sgma;
            end
            received_signal = BB_signal + noise;
            [x, decision_index] = max(received_signal);
            if decision_index ~= transmitted_index
                number_of_symbol_error = number_of_symbol_error + 1;
            end
        end
            fun = @(y) ((1-qfunc(y)).^(M-1)).*exp(-(y-sqrt(2.*Es./N0)).^2./2);
            Ps_exact_fsk(L) = 1 - 1./sqrt(2*pi).*integral(fun, -inf, inf);
            P_nearest_fsk(L) = (M-1)*qfunc(sqrt(Es_No_linear));
            P_sim_fsk(L) = number_of_symbol_error / N;
    end
end
end

