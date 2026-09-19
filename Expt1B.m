clc;
clear;
close all;

pt = 10;
Gt = 2;
Gr = 5;
ht = 30;
hr = 4;
d = 0.1 : 0.05 : 10;


f_m = [1800 ; 5800]; % frequncy in MHz
a_hr = (3.2*(log10(11.75*hr)).^2) - 4.97
PL_large = 69.55 + 26.16*log10(f_m) - a_hr - 13.82*log10(ht) +  (44.9 - 6.55*log10(ht)) .* log10(d);
Pt_dB = 10*log10(pt);
Pr_mat = Pt_dB + 10*log10(Gt) + 10*log10(Gr) - PL_large;

f = 200
a_hr = (8.29*(log10(1.54*hr)).^2) - 1.1;
PL_large = 69.55 + 26.16*log10(f) - a_hr - 13.82*log10(ht) +  (44.9 - 6.55*log10(ht)) .* log10(d);
Pt_dB = 10*log10(pt);
Pr_mat_1 = Pt_dB + 10*log10(Gt) + 10*log10(Gr) - PL_large;

f_1 = [200 ; 1800 ; 5800];
a_hr = (1.1*(log10(f_1)) - 0.7)*hr - (1.56*(log10(f_1)) - 0.8);
PL_large = 69.55 + 26.16*log10(f) - a_hr - 13.82*log10(ht) +  (44.9 - 6.55*log10(ht)) .* log10(d);
Pt_dB = 10*log10(pt);
Pr_mat_2 = Pt_dB + 10*log10(Gt) + 10*log10(Gr) - PL_large;

plot(d,Pr_mat,'LineWidth',2);
hold on;
plot(d,Pr_mat_1,'LineWidth',2);
hold on;
plot(d,Pr_mat_2,'LineWidth',2);
hold off;
ylabel("Received Power (dB)");
xlabel("Distance (km)");
title("Received Power(dB) vs Distance (km)");
legend("Large City (Frequency > 300)" , "Large City(Frequency <= 300)" , "Small-Medium City");
grid on;
