clc;
clear all;
close all;

N = 1e5;

% Random bit generation
input = rand(1,N) > 0.5;

% BPSK mapping (0->-1, 1->+1)
input_bpsk = (2*input) - 1;

SNRdb = 0:15;
SNR = 10.^(SNRdb/10);

% Theoretical BER
BER_theory = 0.5*erfc(sqrt(SNR));

figure;
semilogy(SNRdb, BER_theory,'linewidth',3);
hold on;

% Simulation
for z = 1:length(SNR)

    noise = randn(1,N);
    y = input_bpsk + noise./sqrt(2*SNR(z));

    rec_op = y > 0;

    err(z) = sum(input ~= rec_op);
end

BER_sim = err./N;

% Avoid log(0)
BER_sim = max(BER_sim,1e-10);

semilogy(SNRdb, BER_sim,'linewidth',3);

title('BER vs SNR for AWGN channel using BPSK');
xlabel('SNR (dB)');
ylabel('Bit Error Rate');
legend('Theoretical','Simulated');
axis([0 15 1e-6 1]);
grid on;

% Example BER value
SNR = 10;
BER = 0.5*erfc(sqrt(SNR));
fprintf('\nBER = %f\n', BER);
