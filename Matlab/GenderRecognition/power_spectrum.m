function [power, f] = power_spectrum(location, plot_it)
    [s, fs] = audioread(location);
    fft_out = fft(s);
    power = abs(fft_out).^2;
    n = length(s);
    f = linspace(0,1000,fs/ 2 + 1);
    if (plot_it)
        figure
        plot(f, power(1:fs / 2 +1) / 10 ^ 6);
        xlabel('Frequency')
        ylabel('Power')
        title(location)
    end
end