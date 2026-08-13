% 4th-order Chebyshev Type I filter at 250Hz cutoff with 1dB passband ripple
pkg load signal

% Filter parameters
order = 4;
passband_ripple = 1; % dB
cutoff_freq = 250; % Hz
sampling_freq = 1000; % Hz (must be > 2*cutoff)
nyquist_freq = sampling_freq / 2;
normalized_cutoff = cutoff_freq / nyquist_freq;

% Design Chebyshev Type I filter
% Type I allows ripple in the passband and has a maximally flat stopband.
[b, a] = cheby1(order, passband_ripple, normalized_cutoff, 'low');

% Frequency response
[h, w] = freqz(b, a, 1024, sampling_freq);

% Plot magnitude response
figure;
subplot(2,1,1);
semilogx(w, 20*log10(abs(h)));
title('4th-Order Chebyshev Type I Filter - Magnitude Response (1dB ripple)');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
xlim([1 500]);
ylim([-60 5]);

% Plot phase response
subplot(2,1,2);
semilogx(w, angle(h)*180/pi);
title('Phase Response');
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
grid on;
xlim([1 500]);
