ChipRate = 64e3;
SPS = 2;
SNR = 10^(-16/10);

prn0 = GoldCodeGen(2);
prn1 = GoldCodeGen(3);

message = 'A';

bits = SpriteFECEncoder(message);

BBtx = SpriteModulator(bits,prn0,prn1,SPS);

%Mix with jittery carrier + noise to generate IF
t = (0:(length(BBtx)-1))'/ChipRate/SPS;
f = 40e3*(rand()-.5)
phi = 2*pi*(rand() - .5) + (pi/100)*randn(size(t));
carrier = exp(1i*(2*pi*f*t + phi));
IF = BBtx.*carrier + sqrt(1/(2*SNR*SPS))*randn(size(t)) + 1i*sqrt(1/(2*SNR*SPS))*randn(size(t));

%Decimate back down to baseband
BBrx = decimate(IF,SPS);

corOut = SpriteCorrelator(BBrx,prn1,1) - SpriteCorrelator(BBrx,prn0,1);
softBits = SoftBitDecimator(corOut);

result = SoftDecode(softBits);