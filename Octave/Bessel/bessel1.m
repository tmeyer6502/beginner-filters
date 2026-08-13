% 4th-order Bessel filter at 250Hz cutoff
pkg load signal

% Filter parameters
order = 4;
cutoff_freq = 250; % Hz
sampling_freq = 1000; % Hz (must be > 2*cutoff)
nyquist_freq = sampling_freq / 2;
normalized_cutoff = cutoff_freq / nyquist_freq;

% Design digital Bessel filter
% Bessel filters are known for maximally flat group delay (linear phase).
[b, a] = besself(order, normalized_cutoff, 'low', 'z');

% Frequency response
[h, w] = freqz(b, a, 1024, sampling_freq);
[g, wg] = grpdelay(b, a, 1024, sampling_freq);

% Plot magnitude response
figure;
subplot(2,1,1);
semilogx(w, 20*log10(abs(h)));
title('4th-Order Bessel Filter - Magnitude Response');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
xlim([1 500]);
ylim([-60 5]);

% Plot group delay
subplot(2,1,2);
plot(wg, g);
title('Group Delay');
xlabel('Frequency (Hz)');
ylabel('Group Delay (samples)');
grid on;
xlim([1 500]);
