% 4th-order Butterworth filter at 250Hz cutoff
pkg load signal

% Filter parameters
order = 4;
cutoff_freq = 250; % Hz
sampling_freq = 1000; % Hz (must be > 2*cutoff)
nyquist_freq = sampling_freq / 2;
normalized_cutoff = cutoff_freq / nyquist_freq;

% Design Butterworth filter
[b, a] = butter(order, normalized_cutoff, 'low');

% Frequency response
[h, w] = freqz(b, a, 1024, sampling_freq);

% Plot magnitude response
figure;
subplot(2,1,1);
semilogx(w, 20*log10(abs(h)));
title('4th-Order Butterworth Filter - Magnitude Response');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
grid on;
xlim([1 500]);



% Plot phase response
subplot(2,1,2);
semilogx(w, angle(h)*180/pi);
title('Phase Response');
xlabel('Frequency (Hz)');
ylabel('Phase (degrees)');
grid on;
xlim([1 500]);
