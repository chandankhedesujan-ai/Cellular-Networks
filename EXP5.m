clc;
clear;
close all;

SNRdB = 0:60;
SNR = 10.^(SNRdB/10);
BER = zeros(5, length(SNR));

for L = 1:5
    BER(L,:) = nchoosek(2*L-1, L) .* (1/2)^L .* (1./SNR).^L;
end

figure;
semilogy(SNRdB, BER(1,:),'--','LineWidth',2); hold on;
semilogy(SNRdB, BER(2),'-.','LineWidth',2);
semilogy(SNRdB, BER(3,:),'.','LineWidth',2);
semilogy(SNRdB, BER(4,:),'-','LineWidth',2);
semilogy(SNRdB, BER(5,:),'--','LineWidth',2);

grid on;
xlabel('SNR (dB)');
ylabel('Bit Error Rate (BER)');
title('BER v/s SNR for multiantenna Rayleigh fading');
legend('L = 1','L = 2','L = 3','L = 4','L = 5','Location','southwest');

set(gca,'FontSize',5);
