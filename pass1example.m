bb128 = read_complex_binary('pass1bb_20190320_032746_437240000_128000_fc.raw');
bb64 = decimate(bb128,2);
cor0 = SpriteCorrelator(bb64,GoldCodeGen(14),1);
cor1 = SpriteCorrelator(bb64,GoldCodeGen(15),1);
sig = SubtractCorrelations(cor0,cor1);
softbits = SoftBitDecimator(sig,1);
[msg, val] = SoftDecode(softbits);