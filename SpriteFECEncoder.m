function bits = SpriteFECEncoder(string)

%BlockCodeGen5;
%Generator matrix for a (16,8,5) code
%This was generated by the GAP package GUAVA
%using the function BestKnownLinearCode(16,8,GF(2))
G = [1 0 0 1 1 1 1 0 1 0 0 0 0 0 0 0;
     0 1 0 0 1 1 1 0 0 1 0 0 0 0 0 0;
     1 1 0 0 1 1 0 1 0 0 1 0 0 0 0 0;
     0 1 1 0 0 1 1 1 0 0 0 1 0 0 0 0;
     0 0 1 1 0 0 1 1 0 0 0 0 1 0 0 0;
     1 1 1 1 0 0 1 0 0 0 0 0 0 1 0 0;
     0 1 1 1 1 0 0 0 0 0 0 0 0 0 1 0;
     1 1 0 1 0 1 1 1 0 0 0 0 0 0 0 1];

G = gf(G,1);

bits = zeros(length(string), size(G,2)+14);

preamble = [1 1 1 0 0 1 0]; %7-bit Barker code
postamble = [1 0 1 1 0 0 0];

%Fill in preamble and postamble
bits(:,1:7) = repmat(preamble,size(bits,1),1);
bits(:,end-6:end) = repmat(postamble,size(bits,1),1);

for k = 1:length(string)
    message = dec2bin(string(k), 8)-'0';
    codeword = message*G;
    bits(k,8:end-7) = double(codeword.x);
end

end

