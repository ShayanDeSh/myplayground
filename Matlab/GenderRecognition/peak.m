function peak_freq = peak(location)
    [power, f] = power_spectrum(location, false);
    [m, i] = max(power);
    peak_freq = f(i);
end

