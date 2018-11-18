function [ Ps_sim_16QAM,Ps_exact_16QAM,Ps_nearest_16QAM,Eb_No_db] = fun16qam( ~ )

clear;

step_Eb = 1.5;
M = 16;
d = 1;
constellation_point = [-3*d+j*3*d  -d+j*3*d  d+j*3*d  3*d+j*3*d...
                       -3*d+j*1*d  -d+j*1*d  d+j*1*d  3*d+j*1*d...
                       -3*d-j*1*d  -d-j*1*d  d-j*1*d  3*d-j*1*d...
                       -3*d-j*3*d  -d-j*3*d  d-j*3*d  3*d-j*3*d];
Es = mean(abs(constellation_point).^2);
Eb_No_db = [0:step_Eb:20];
N = 100000;

for L = 1 : length(Eb_No_db)
    number_of_symbol_error = 0;
    num_Eb_No_db = Eb_No_db(L);
    Eb_No_linear = 10^(num_Eb_No_db/10);
    sgma = sqrt(Es/(2*Eb_No_linear*log2(M)));
     N0 = 2*sgma^2;
for i =1:1:N
    transmitted_index = 1 + floor(rand * M);
    BB_signal = constellation_point(transmitted_index);
    
    received_signal = BB_signal +(randn*sgma +j*randn*sgma);
    
    for k=1:1:M
        distance_from_constellation_point(k) = abs(received_signal-constellation_point(k))^2;
    end
    
    [x,decision_index] = min(distance_from_constellation_point);
    
    if decision_index ~= transmitted_index
        number_of_symbol_error = number_of_symbol_error +1;
    end
end
Ps_sim_16QAM(L) = number_of_symbol_error/N;
Ps_exact_16QAM(L) = 1-(1- 2*(sqrt(M)-1)/sqrt(M)*qfunc(sqrt(3*Eb_No_linear*log2(M)/(M-1))))^2;
Ps_nearest_16QAM(L) = (4*(sqrt(M)-1)/sqrt(M))*qfunc(sqrt((3*Es/N0)/(M-1)));
end

end

