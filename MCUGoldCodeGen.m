function structText = MCUGoldCodeGen(prnID)

seq = comm.GoldSequence('FirstPolynomial',[9 4 0],...
             'SecondPolynomial', [9 6 4 3 0],...
             'FirstInitialConditions', [1 0 1 0 1 0 1 0 1],...
             'SecondInitialConditions', [1 0 1 0 1 0 1 0 1],...
             'Index', prnID, 'SamplesPerFrame', 511);

% %Generate PN9 Sequence for CC1101 Radio
% seq = comm.PNSequence('Polynomial', [9 5 0],...
%                       'InitialConditions', [1 1 1 1 1 1 1 1 1],...
%                       'SamplesPerFrame', 511);
prn = [step(seq); 0];

%Reshape the prn vector into an 8x64 matrix
prn = reshape(prn,64,8)';

structText = sprintf('static unsigned char prn%d[64] = {',prnID);

for j = 1:8
    structText = strcat(structText, sprintf(...
        '\n  0b%u%u%u%u%u%u%u%u, 0b%u%u%u%u%u%u%u%u, 0b%u%u%u%u%u%u%u%u, 0b%u%u%u%u%u%u%u%u, 0b%u%u%u%u%u%u%u%u, 0b%u%u%u%u%u%u%u%u, 0b%u%u%u%u%u%u%u%u, 0b%u%u%u%u%u%u%u%u',...
        prn(j,:)));
    
    if j<8
        structText = strcat(structText, ',');
    else
        structText = strcat(structText, sprintf('\n};'));
    end
end



end

