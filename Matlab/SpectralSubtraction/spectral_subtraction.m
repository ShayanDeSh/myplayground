[s, fs] = audioread('Test.wav');
plot(s);
s = awgn(s,10,'measured');
figure
plot(s)
number_of_samples = 0.03 * fs;
overlap = 1 / 6;
offset = number_of_samples * overlap;
n = length(s);
result = zeros(n, 1);
noise_est = 0;
sound(s, fs);
pause(4)
sample_noise = 40;
ftn = 512;
for i=1:offset:sample_noise * offset
    fi = i + number_of_samples - 1;
    if fi > n
        frame = s(i:end);
    else
        frame = s(i:fi);
    end
    windowed_frame = frame .* hamming(length(frame));
    complex_spec = fft(windowed_frame,ftn);        % use a 512 point fft
    mag_spec = abs(complex_spec);
    noise_est = noise_est + mag_spec;
end
for i=370:offset:sample_noise * offset
    fi = i + number_of_samples - 1;
    if fi > n
        frame = s(i:end);
    else
        frame = s(i:fi);
    end
    windowed_frame = frame .* hamming(length(frame));
    complex_spec = fft(windowed_frame,ftn);        % use a 512 point fft
    mag_spec = abs(complex_spec);
    noise_est = noise_est + mag_spec;
end
noise_est = noise_est / (2 * sample_noise);
for i=1:offset:n
    fi = i + number_of_samples - 1;
    if fi > n
        frame = s(i:end);
    else
        frame = s(i:fi);
    end
    windowed_frame = frame .* hamming(length(frame));
    complex_spec = fft(windowed_frame,ftn);        % use a 512 point fft
    mag_spec = abs(complex_spec);
    phase_spec = angle(complex_spec);
    clean_spec = mag_spec - 3 * noise_est;
    clean_spec(clean_spec < 0) = 0;
    enh_spec = clean_spec.*exp(1j*phase_spec);
    enh_spec = real(ifft(enh_spec, length(frame)));
    length(enh_spec);
    length(result(i:i+length(frame) - 1));
    result(i:i+length(frame) - 1) = result(i:i+length(frame) - 1) + enh_spec(:);
end
figure 
plot(result);
sound(result, fs);
