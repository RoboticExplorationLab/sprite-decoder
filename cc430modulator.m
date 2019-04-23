function baseBand = cc430modulator(bits,sps)

% This function replicates the (kind of screwy) MSK modulation used in the
% Texas Instruments CC430. Effectively, the input bits are flipped vs.
% standard MSK.

%First turn the bits into differentially encoded offset square pulses

%Flip bits (CC430 quirk)
bits = -bits;

%Initialization and one bit period offset between I and Q
iChan = ones(sps,1);
qChan = bits(1)*ones(2*sps,1);

diffs = abs(diff(bits));

for k = 1:length(diffs)
    if mod(k,2) == 1 %odd - I channel
        if diffs(k) > 0 % bit transition
            iChan = [iChan; -1*iChan(end)*ones(2*sps,1)];
        else % no bit transition
            iChan = [iChan; iChan(end)*ones(2*sps,1)];
        end
    else %even - Q channel
        if diffs(k) > 0 % bit transition
            qChan = [qChan; -1*qChan(end)*ones(2*sps,1)];
        else % no bit transition
            qChan = [qChan; qChan(end)*ones(2*sps,1)];
        end
    end
end

%Now apply sinusoidal pulse shaping

for k = 1:length(iChan)
    iChan(k) = iChan(k)*cos(pi/2*(k-1)/sps);
end

for k = 1:length(qChan)
    qChan(k) = qChan(k)*sin(pi/2*(k-1)/sps);
end

baseBand = iChan(1:length(bits)*sps) + 1i*qChan(1:length(bits)*sps);

end

