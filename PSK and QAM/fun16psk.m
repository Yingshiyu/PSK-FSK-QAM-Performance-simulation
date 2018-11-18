function [ Ps_sim_16PSK,Ps_exact_16PSK,Ps_nearest_16PSK,Eb_No_db ] = fun16psk( ~ )

step_Eb = 1.5;
M = 16;
d = 1;
Eb_No_db = [0:step_Eb:20];
N = 100000;
constellation_point=zeros([1,M]);
for i=1:M
    constellation_point(i)=cos(pi*(i-1)/8+pi/16)+j*sin(pi*(i-1)/8+pi/16);
end
Es = mean(abs(constellation_point).^2);

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
fun = @(v,theta) v./(pi.*N0).*exp(-(v.^2-2.*sqrt(Es).*v.*cos(theta)+Es)./N0);
Ps_sim_16PSK(L) = number_of_symbol_error/N;
Ps_nearest_16PSK(L) = 2*qfunc(sqrt(2*(Es/N0))*sin(pi/16));
Ps_exact_16PSK(L) = 1-integral2(fun,0,inf,-pi/M,pi/M);
end
end

