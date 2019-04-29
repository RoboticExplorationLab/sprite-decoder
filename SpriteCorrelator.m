function maxCor = SpriteCorrelator(baseband,prn,sps)

if size(baseband, 2) > size(baseband, 1)
    baseband = baseband.';
end

bbTemplate = cc430modulator(2*prn-1,sps);
bbTemplate = bbTemplate/norm(bbTemplate); %normalize

steps = length(baseband)-length(bbTemplate);

maxCor = 0;
if steps == 0
    pw = conj(bbTemplate).*(baseband)/norm(baseband);
    ft = fft(pw);
    maxCor = max(abs(ft));
else
maxCor = zeros(steps,1);
for k = 1:steps
    chunk = baseband(k:k+length(bbTemplate)-1);
    pw = conj(bbTemplate).*chunk/norm(chunk);
    ft = fft(pw);
    maxCor(k) = max(abs(ft));
end

end
end
