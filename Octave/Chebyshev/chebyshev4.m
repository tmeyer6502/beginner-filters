% Compare Chebyshev Type II filter orders
pkg load signal

% Filter parameters
stopband_attenuation = 40; % dB
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
hold on;

% Calculate and plot each filter order
for i = 1:length(orders)
    [b, a] = cheby2(orders(i), stopband_attenuation, normalized_cutoff, 'low');
    [h, w] = freqz(b, a, freq_range, sampling_freq);

    semilogx(w, 20*log10(abs(h)), colors{i}, 'LineWidth', 2);
end

% Add reference lines
plot([cutoff_freq cutoff_freq], [-80 5], 'k--', 'LineWidth', 1);
plot([1 500], [-40 -40], 'k--', 'LineWidth', 1);

title('Chebyshev Type II Filter Order Comparison (250Hz Cutoff, 40dB Stopband Attenuation)');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
legend('2nd Order', '3rd Order', '4th Order', '5th Order', 'Cutoff Freq', '-40dB Stopband Line');
grid on;
xlim([10 500]);
ylim([-80 5]);
