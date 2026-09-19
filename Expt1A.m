clc;
clear;
close all;

pt = 10;
Gt = 2;
Gr = 5;
f = 1.8e9;
c = 3e8;
d = 100 : 50 : 10000;
ht = 30;
hr = 4;
hr_km = 0.004;

lambda = c / f;

% Free space
pr_n=pt*Gt*Gr*(lambda.^2);
pr_d=16*pi.^2*d.^2;

pr=pr_n./pr_d;
pr_db=10*log10(pr);

pL_dB = (10*log10(pt) + 10*log(Gt) + 10*log10(Gr)) - pr_db;
d0=500;
idx = find(d==d0);
disp(["Freespace pr at 500m : ", num2str(pr(idx)), 'W']);
disp(["Freespace pr at 500m : ", num2str(pr_db(idx)), 'W']);

disp(["Freespace pl at 500m : ", num2str(pL_dB(idx)), 'W']);

%2-Rey===++

pr2 = pt * Gt * Gr * (ht * hr ./ d.^2).^2;
pr2_db=10*log10(pr2);
pL2 = (10*log10(pt) + 10*log(Gt) + 10*log10(Gr)) - pr2_db;
d0=500;
idx = find(d==d0);
disp(["2 ray pr at 500m : ", num2str(pr2(idx)), 'W']);
disp(["2 ray pr at 500m : ", num2str(pr2_db(idx)), 'W']);

disp(["2 ray pl at 500m : ", num2str(pL2(idx)), 'W']);
%HATA
f_m=f/10^6
a_hr = (3.2*(log10(11.75*hr)).^2) - 4.97;
PL_large = 69.55 + 26.16*log10(f_m) - a_hr - 13.82*log10(ht) +  (44.9 - 6.55*log10(ht)) .* log10(d/1000);
Pt_dB = 10*log10(pt) ;
Pr3_db = Pt_dB + 10*log10(Gt) + 10*log10(Gr) - PL_large;
d0=500;


subplot(2,1,1)
plot(d, pr_db, 'LineWidth', 2);
hold on;
plot(d, pr2_db, 'LineWidth', 2);
hold on;
plot(d, Pr3_db, 'LineWidth', 2);
grid on;
xlabel('Distance (km)');
ylabel('Power recived (dB)');
title('Power recived vs Distance');
legend("Free Space","Ground Reflection","Hata Model");

subplot(2,1,2)
plot(d, pL_dB, 'LineWidth', 2);
hold on;
plot(d, pL2, 'LineWidth', 2);
hold on;
plot(d, PL_large, 'LineWidth', 2);
grid on;
xlabel('Distance (km)');
ylabel('Path Loss (dB)');
title('Path Loss vs Distance');
legend("Free Space","Ground Reflection","Hata Model");
