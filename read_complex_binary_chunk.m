function v = read_complex_binary_chunk(filename,samp_range)

f = fopen (filename, 'rb');
if (f < 0)
    v = 0;
else
    nsamp = samp_range(2)-samp_range(1);
    
    fseek(f,samp_range(1)*8,'bof');
    t = fread (f, [2, nsamp], 'float');
    fclose (f);
    
    v = t(1,:) + t(2,:)*1i;
    [r, c] = size (v);
    v = reshape (v, c, r);
end

end

