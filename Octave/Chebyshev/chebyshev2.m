% Compare Chebyshev Type I filter orders
pkg load signal

% Filter parameters
passband_ripple = 1; % dB
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
    [b, a] = cheby1(orders(i), passband_ripple, normalized_cutoff, 'low');
    [h, w] = freqz(b, a, freq_range, sampling_freq);

    semilogx(w, 20*log10(abs(h)), colors{i}, 'LineWidth', 2);
end

% Add reference lines
plot([cutoff_freq cutoff_freq], [-60 5], 'k--', 'LineWidth', 1);
plot([1 500], [-1 -1], 'k--', 'LineWidth', 1);

title('Chebyshev Type I Filter Order Comparison (250Hz Cutoff, 1dB Ripple)');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
legend('2nd Order', '3rd Order', '4th Order', '5th Order', 'Cutoff Freq', '-1dB Ripple Line');
grid on;
xlim([10 500]);
ylim([-60 5]);
