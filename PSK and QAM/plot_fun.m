
%16QAM
[Ps_sim_16QAM,Ps_exact_16QAM,Ps_nearest_16QAM,Eb_No_db_16QAM] = fun16qam();
semilogy(Eb_No_db_16QAM,Ps_sim_16QAM,'bo')
hold on
semilogy(Eb_No_db_16QAM,Ps_exact_16QAM,'b-')
hold on
semilogy(Eb_No_db_16QAM,Ps_nearest_16QAM,'b^')
hold on

%4QAM
[Ps_sim_4QAM,Ps_exact_4QAM,Ps_nearest_4QAM,Eb_No_db_4QAM] = fun4qam();
semilogy(Eb_No_db_4QAM,Ps_sim_4QAM,'ro')
hold on
semilogy(Eb_No_db_4QAM,Ps_exact_4QAM,'r-')
hold on
semilogy(Eb_No_db_4QAM,Ps_nearest_4QAM,'r^')
hold on

%16PSK
[Ps_sim_16PSK,Ps_exact_16PSK,Ps_nearest_16PSK,Eb_No_db_16PSK] = fun16qpsk();
semilogy(Eb_No_db_16PSK,Ps_sim_16PSK,'ko')
hold on
semilogy(Eb_No_db_16PSK,Ps_exact_16PSK,'k-')
hold on
semilogy(Eb_No_db_16PSK,Ps_nearest_16PSK,'k^')
hold on

xlabel('{E_b}/{N_o}(dB)')
ylabel('Probability of Symbol Error Ps(log scale)')
set(gca,'YLim',[0.00000001 1]);
legend('16QAM-Sim','16QAM-exact','16QAM-Appro','4QAM/QPSK-Sim','4QAM/QPSK-exact','4QAM/QPSK-Appro','16PSK-Sim','16PSK-exact','16PSK-Appro')