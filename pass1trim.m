samp_range = [10.5*60*1.8e6, 13.5*60*1.8e6];
raw = read_complex_binary_chunk('kicksat2_20190320_032746_436935500_1800000_fc.raw', samp_range);
%write_complex_binary(raw, 'pass1trimmed_20190320_032746_436935500_1800000_fc.raw');

%Center frequency
Fc = 315e3/900e3;

%Prototype low-pass filter
[~,lpf] = lowpass(raw(1:18000),80e3,1800e3,'Steepness',0.97);

%Create bandpass filter by frequency shifting taps up to Fc
N = length(lpf.Coefficients)-1;
bpfcoeff = (lpf.Coefficients).*exp(1j*Fc*pi*(0:N));
bpf = dfilt.dffir(bpfcoeff);

%Actually bandpass the signal
bp = bpf.filter(raw);
%write_complex_binary(rawbp, 'pass1filt_20190320_032746_436935500_1800000_fc.raw');

%Mix with carrier
carrier = exp(1j*Fc*pi*(0:(length(bp)-1)))';
bb = bp.*carrier;

%Resample to 128ksps
%bb = lowpass(bb,80e3,1800e3,'Steepness',0.97);
bb180 = decimate(bb,10);
bb160 = resample(bb180,8,9);
bb128 = resample(bb160,4,5);











