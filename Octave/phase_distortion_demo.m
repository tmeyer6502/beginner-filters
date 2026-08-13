% Phase Distortion Demo
% Shows how Bessel, Butterworth, and Chebyshev filters affect a square wave.
% A square wave is made of many sine harmonics. If the filter delays
% those harmonics by different amounts (non-flat group delay), the
% waveform shape changes. Bessel filters preserve the shape best.
pkg load signal

% Filter parameters
order = 4;
cutoff_freq = 250; % Hz
sampling_freq = 8000; % Hz
nyquist_freq = sampling_freq / 2;
normalized_cutoff = cutoff_freq / nyquist_freq;
passband_ripple = 1; % dB for Chebyshev Type I

% Generate a 50Hz square wave
t = 0:1/sampling_freq:0.04;
f0 = 50;
square_wave = sign(sin(2*pi*f0*t));

% Design filters
[b_butter, a_butter] = butter(order, normalized_cutoff, 'low');
[b_cheby, a_cheby] = cheby1(order, passband_ripple, normalized_cutoff, 'low');
[b_bessel, a_bessel] = besself(order, normalized_cutoff, 'low', 'z');

% Filter the square wave using one-pass filter() so phase matters
y_butter = filter(b_butter, a_butter, square_wave);
y_cheby = filter(b_cheby, a_cheby, square_wave);
y_bessel = filter(b_bessel, a_bessel, square_wave);

% Time-domain comparison
figure;

subplot(4,1,1);
plot(t, square_wave, 'k', 'LineWidth', 1.5);
title('Original Square Wave');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;
ylim([-1.5 1.5]);

subplot(4,1,2);
plot(t, square_wave, 'k--', 'LineWidth', 1); hold on;
plot(t, y_butter, 'b', 'LineWidth', 1.5);
title('Butterworth Filtered');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original', 'Butterworth');
grid on;
ylim([-1.5 1.5]);

subplot(4,1,3);
plot(t, square_wave, 'k--', 'LineWidth', 1); hold on;
plot(t, y_cheby, 'r', 'LineWidth', 1.5);
title('Chebyshev Type I Filtered');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original', 'Chebyshev');
grid on;
ylim([-1.5 1.5]);

subplot(4,1,4);
plot(t, square_wave, 'k--', 'LineWidth', 1); hold on;
plot(t, y_bessel, 'g', 'LineWidth', 1.5);
title('Bessel Filtered');
xlabel('Time (s)');
ylabel('Amplitude');
legend('Original', 'Bessel');
grid on;
ylim([-1.5 1.5]);

% Group delay comparison
figure;
freq_range = logspace(0, log10(nyquist_freq), 1024);
hold on;

[g_butter, w] = grpdelay(b_butter, a_butter, freq_range, sampling_freq);
[g_cheby, w] = grpdelay(b_cheby, a_cheby, freq_range, sampling_freq);
[g_bessel, w] = grpdelay(b_bessel, a_bessel, freq_range, sampling_freq);

plot(w, g_butter, 'b', 'LineWidth', 2);
plot(w, g_cheby, 'r', 'LineWidth', 2);
plot(w, g_bessel, 'g', 'LineWidth', 2);

plot([cutoff_freq cutoff_freq], [0 max([g_butter; g_cheby; g_bessel])], 'k--', 'LineWidth', 1);

title('Group Delay Comparison');
xlabel('Frequency (Hz)');
ylabel('Group Delay (samples)');
legend('Butterworth', 'Chebyshev Type I', 'Bessel', 'Cutoff Freq');
grid on;
xlim([10 500]);
