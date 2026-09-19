clc;
clear all;
close all;
d = 8;
fc = 2e3; %in MHZ
hte = 40;
hre = 2;
sigma = 6;
R = 0.95;
T = 293;
B = 30e3;
F = 5;
Gr = 5;
Gt = 12;
BER = 10^(-4);
Lc = 3;

SNR = (2*((1-2*BER)^2))/(1-((1-2*BER)^2));
fprintf("\nSNR : %d" , SNR);

SNR_db = 10*log10(SNR);
fprintf("\nSNR in db : %d",SNR_db);
Q_inverse = 1.65;

M_db = sigma*Q_inverse;

fprintf("\nM in DB : %d" , M_db);

N = 1.38*(10^(-23))*B*T*3.1662;
fprintf("\nN : %d" , N);

N_db = 10*log10(N);
fprintf("\nN in DB : %d" , N_db);

N_I_db = N_db + 3;
fprintf("\nN+I in DB : %d",N_I_db);

a_hre = 3.2*((log10(11.75*hre))^2)-4.97;
fprintf("\na(hre) for large city : %d",a_hre);

L_50_db = 69.55+26.16*log10(fc)-a_hre-13.82*log10(hte)+((44.9-
6.55*log10(hte))*log10(d));
fprintf("\n L_50 in DB : %d",L_50_db);

Pt_db = SNR_db-Gt+L_50_db+M_db-Gr+Lc+N_I_db;
fprintf("\n Pt in DB : %d",Pt_db);
