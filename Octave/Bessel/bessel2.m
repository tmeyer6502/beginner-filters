% Compare Bessel filter orders
pkg load signal

% Filter parameters
cutoff_freq = 250; % Hz
sampling_freq = 1000; % Hz
nyquist_freq = sampling_freq / 2;
normalized_cutoff = cutoff_freq / nyquist_freq;

% Frequency range for analysis
freq_range = logspace(0, log10(nyquist_freq), 1024);

% Colors for different orders
colors = {'b', 'r', 'g', 'm'};
orders = [2, 3, 4, 5];

figure;

% Magnitude response comparison
subplot(2,1,1);
hold on;
for i = 1:length(orders)
    [b, a] = besself(orders(i), normalized_cutoff, 'low', 'z');
    [h, w] = freqz(b, a, freq_range, sampling_freq);
    semilogx(w, 20*log10(abs(h)), colors{i}, 'LineWidth', 2);
end
plot([cutoff_freq cutoff_freq], [-60 5], 'k--', 'LineWidth', 1);
plot([1 500], [-3 -3], 'k--', 'LineWidth', 1);
title('Bessel Filter Order Comparison - Magnitude Response');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
legend('2nd Order', '3rd Order', '4th Order', '5th Order', 'Cutoff Freq', '-3dB Line');
grid on;
xlim([10 500]);
ylim([-60 5]);

% Group delay comparison
subplot(2,1,2);
hold on;
for i = 1:length(orders)
    [b, a] = besself(orders(i), normalized_cutoff, 'low', 'z');
    [g, w] = grpdelay(b, a, freq_range, sampling_freq);
    plot(w, g, colors{i}, 'LineWidth', 2);
end
title('Group Delay');
xlabel('Frequency (Hz)');
ylabel('Group Delay (samples)');
grid on;
xlim([10 500]);
