function softBits = SoftBitDecimator(corOut)

    Decimation = 512;

    softBits = zeros(floor((length(corOut)-256)/Decimation),1) + 0i;

    windows1 = reshape(corOut(1:(Decimation*length(softBits))), Decimation, length(softBits));
    windows2 = reshape(corOut(257:(256+(Decimation*length(softBits)))), Decimation, length(softBits));

    for k = 1:length(softBits)

        max1 = max(windows1(:,k));
        min1 = min(windows1(:,k));
        out1 = max1;
        if max1 < -min1
            out1 = min1;
        end

        max2 = max(windows2(:,k));
        min2 = min(windows2(:,k));
        out2 = max2;
        if max2 < -min2
            out2 = min2;
        end
        
        softBits(k) = out1 + 1i*out2;
    end

end