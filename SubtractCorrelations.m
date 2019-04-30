function sig = SubtractCorrelations(cor0,cor1)

sig = zeros(size(cor0));
for m = 1:length(cor0)
    if cor0(m) > cor1(m)
        sig(m) = -cor0(m);
    else
        sig(m) = cor1(m);
    end
end

end

