function [baseband, power] = SpriteModulator(bits,prn0,prn1,sps)

%Convert from 1,0 to +1,-1
bits = 2*bits-1;
prn0 = 2*prn0-1;
prn1 = 2*prn1-1;

chips = zeros(size(bits,1),size(bits,2)*length(prn0));
for k = 1:size(bits,1)
    for j = 1:size(bits,2)
        if bits(k,j) > 0
            chips(k,(length(prn0)*(j-1)+1):length(prn0)*(j)) = prn1;
        else
            chips(k,(length(prn0)*(j-1)+1):length(prn0)*(j)) = prn0;
        end
    end
end

baseband = delay(500);
for k = 1:size(chips,1)
    baseband = [baseband; cc430modulator(chips(k,:),sps)];
    baseband = [baseband; delay(500 + 1000*rand())];
end

    function blanks = delay(milliseconds)
        blanks = zeros(ceil(64*milliseconds*sps),1);
    end

end

