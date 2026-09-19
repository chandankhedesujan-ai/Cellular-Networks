clc;
clear all;
close all;
N = 1e5;
input = rand(1,N) > 0.5;
input_bpsk = 2*input - 1;
SNRdb = 0:30;
SNR = 10.^(SNRdb/10);
BER_awgn_th = 0.5 * erfc(sqrt(SNR));
for z = 1:length(SNR)
noise = randn(1,N);
y = input_bpsk + noise./sqrt(2*SNR(z));
rec = y > 0;
err_awgn(z) = sum(input ~= rec);
end
BER_awgn_sim = err_awgn / N;
BER_ray_th = 0.5 * (1 - sqrt(SNR./(SNR + 2)));
for z = 1:length(SNR)
h = (randn(1,N) + 1i*randn(1,N))/sqrt(2);
noise = (randn(1,N) + 1i*randn(1,N))/sqrt(2);
y = h .* input_bpsk + noise./sqrt(SNR(z));
y_eq = y ./ h;
rec = real(y_eq) > 0;
err_ray(z) = sum(input ~= rec);

end
BER_ray_sim = err_ray / N;
figure;
semilogy(SNRdb, BER_awgn_th, 'LineWidth', 3); hold on;
semilogy(SNRdb, BER_awgn_sim, 'LineWidth', 3);
semilogy(SNRdb, BER_ray_th, 'LineWidth', 3);
semilogy(SNRdb, BER_ray_sim, 'LineWidth', 3);
grid on;
xlim([0 30]);
ylim([1e-6 1]);
xlabel('SNR in dB');
ylabel('Bit Error Rate');
title('BER vs SNR for BPSK over AWGN and Rayleigh Channels');
legend('AWGN Theoretical','AWGN Simulated', ...
'Rayleigh Theoretical','Rayleigh Simulated');
