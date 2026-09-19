clc;
close all;
clear;

% Parameters
c = 6;              % number of channels
bits = 54;          % bits per channel
n = c * bits;       % total bits

% Generate data (-1, +1)
data = 2*randi([0 1], 1, n) - 1;

% Serial to parallel
s = reshape(data, c, bits);

% Expand bits (each bit repeated twice)
exdata = zeros(c, bits*2);
for ch = 1:c
    temp = [];
    for i = 1:bits
        temp = [temp s(ch,i) s(ch,i)];
    end
    exdata(ch,:) = temp;
end

% Time axis
ts = 0.1;
tp = 1:ts:1 + (bits*2-1)*ts;

% Carrier generation
carriers = zeros(c, length(tp));
for ch = 1:c
    carriers(ch,:) = cos(2*pi*ch*tp);
end

% BPSK modulation
bpsk_sig = exdata .* carriers;

% IFFT (OFDM-like step)
ifft_sig = ifft(bpsk_sig, [], 2);

% Serialize
transmit = reshape(ifft_sig, 1, []);

% Add noise
snr = 10;
noise = (randn(size(transmit)) + 1j*randn(size(transmit))) / sqrt(2*snr);
rxdata = transmit + noise;

% Parallel conversion
myrec = reshape(rxdata, c, []);

% FFT
rx_fft = fft(myrec, [], 2);

% Demodulation
dec = zeros(c, bits);

for ch = 1:c
    uncarry = rx_fft(ch,:) .* carriers(ch,:);

    idx = 1;
    for i = 1:2:length(uncarry)-1
        val = trapz(real(uncarry(i:i+1)));
        dec(ch, idx) = val;
        idx = idx + 1;
    end
end

% Parallel to serial
fin_rec_parallel = reshape(dec, 1, []);

% Decision
demod = sign(fin_rec_parallel);

% BER calculation
error = sum(data ~= demod);
ber = error / n;

% Plot
figure;
stem(data); hold on;
stem(demod, 'r');
legend('Original', 'Demodulated');
title(['BER = ' num2str(ber)]);


