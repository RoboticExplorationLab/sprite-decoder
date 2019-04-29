function [softbits] = PRNSearch(bb)


for k = 0:2:510
    cor0 = SpriteCorrelator(bb,GoldCodeGen(k),1);
    cor1 = SpriteCorrelator(bb,GoldCodeGen(k+1),1);
    
    sig = zeros(size(cor0));
    for m = 1:length(cor0)
        if cor0(m) > cor1(m)
            sig(m) = -cor0(m);
        else
            sig(m) = cor1(m);
        end
    end
    
    softbits = SoftBitDecimator(sig,1);
end


end

