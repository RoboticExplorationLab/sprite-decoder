function [resultString, vals] = SoftDecode(complexSoftBits)

preamble = [1 1 1 -1 -1 1 -1]; %7-bit Barker code
postamble = [1 -1 1 1 -1 -1 -1];

BlockCodeGen5;

C = C/sqrt(16);

template = [preamble zeros(1,16) postamble];
template = template/norm(template);

threshold = .85;
resultString = [];
vals = [];

k = 1;
while k <= (length(complexSoftBits)-length(template))

    window = complexSoftBits(k:(k+length(template)-1));
    cor = template*window;
    cor1 = real(cor)/norm(real((template'~=0).*window));
    cor2 = imag(cor)/norm(imag((template'~=0).*window));
    if cor1 > threshold && cor1 >= cor2   
        codeword = real(window(8:23));
        cor = C*codeword/norm(codeword);
        [val, index] = max(cor);
        if(val > threshold)
            resultString = [resultString, char(index-1)];
            vals = [vals, val];
            k=k+29;
        end
    elseif cor2 > threshold && cor2 > cor1
        codeword = imag(window(8:23));
        cor = C*codeword/norm(codeword);
        [val, index] = max(cor);
        if(val > threshold)
            resultString = [resultString, char(index-1)];
            vals = [vals, val];
            k=k+29;
        end
    end
    
    %If the correlation value is low, mark as an erasure
    %if (val < .75)
    %    index = double('_')+1;
    %end

    %Debug version
    %resultString = [resultString, '<', num2str(val,'%1.2f'), '>', char(index-1)];
    
    k = k+1;
end

end