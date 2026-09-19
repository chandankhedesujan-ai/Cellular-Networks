clc;
clear all;
close all;
c = 3e8;
generations = {'1G (800 MHz)', '2G (900 MHz)', '3G (2.1 GHz)', '4G (2.6 GHz)', '5G (28GHz)'};
frequencies = [800e6, 900e6, 2.1e9, 2.6e9, 28e9];
for i = 1:length(frequencies)
lambda(i) = c / frequencies(i);
d_min(i) = lambda(i) / 2;
end
d_min_cm = d_min * 100;
for i = 1:length(generations)
fprintf('%s %.2f GHz %.2f cm\n', ...
generations{i}, frequencies(i)/1e9, d_min_cm(i));
end
figure;
bar(d_min_cm);
grid on;
xlabel('Mobile Generation / Frequency Band');
ylabel('Minimum Antenna Spacing (cm)');
title('Minimum Antenna Spacing for Independent Fading Channel');
for i = 1:length(d_min_cm)
text(i, d_min_cm(i)+0.5, sprintf('%.2f cm', d_min_cm(i)));
end
