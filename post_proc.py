#!/usr/bin/env python2
# -*- coding: utf-8 -*-
##################################################
# GNU Radio Python Flow Graph
# Title: Top Block
# GNU Radio version: 3.7.13.4
##################################################

from gnuradio import blocks
from gnuradio import eng_notation
from gnuradio import filter
from gnuradio import gr
from gnuradio.eng_option import eng_option
from gnuradio.filter import firdes
from optparse import OptionParser
import pmt
import sprite


class top_block(gr.top_block):

    def __init__(self, n=42):
        gr.top_block.__init__(self, "Top Block")

        ##################################################
        # Parameters
        ##################################################
        self.n = n

        ##################################################
        # Variables
        ##################################################
        self.zero_col = zero_col = n
        self.samp_rate_0 = samp_rate_0 = 192000
        self.one_col = one_col = n+1
        self.chip_rate = chip_rate = 64000

        ##################################################
        # Blocks
        ##################################################
        self.sprite_soft_decoder_c_0 = sprite.soft_decoder_c(0.85)
        self.sprite_single_correlator_cf_1 = sprite.single_correlator_cf(zero_col)
        self.sprite_single_correlator_cf_0 = sprite.single_correlator_cf(one_col)
        self.sprite_peak_decimator_ff_1 = sprite.peak_decimator_ff(512)
        self.sprite_peak_decimator_ff_0 = sprite.peak_decimator_ff(512)
        self.rational_resampler_xxx_0 = filter.rational_resampler_ccc(
                interpolation=2,
                decimation=3,
                taps=None,
                fractional_bw=None,
        )
        self.blocks_sub_xx_0 = blocks.sub_ff(1)
        self.blocks_float_to_complex_0 = blocks.float_to_complex(1)
        self.blocks_file_source_0 = blocks.file_source(gr.sizeof_gr_complex*1, '/home/christopher/RExLab/Sprite Telemetry/kicksat2_20190319_201219_437505000_48000_fc.raw', False)
        self.blocks_file_source_0.set_begin_tag(pmt.PMT_NIL)
        self.blocks_delay_0 = blocks.delay(gr.sizeof_float*1, 256)



        ##################################################
        # Connections
        ##################################################
        self.connect((self.blocks_delay_0, 0), (self.sprite_peak_decimator_ff_1, 0))
        self.connect((self.blocks_file_source_0, 0), (self.rational_resampler_xxx_0, 0))
        self.connect((self.blocks_float_to_complex_0, 0), (self.sprite_soft_decoder_c_0, 0))
        self.connect((self.blocks_sub_xx_0, 0), (self.blocks_delay_0, 0))
        self.connect((self.blocks_sub_xx_0, 0), (self.sprite_peak_decimator_ff_0, 0))
        self.connect((self.rational_resampler_xxx_0, 0), (self.sprite_single_correlator_cf_0, 0))
        self.connect((self.rational_resampler_xxx_0, 0), (self.sprite_single_correlator_cf_1, 0))
        self.connect((self.sprite_peak_decimator_ff_0, 0), (self.blocks_float_to_complex_0, 0))
        self.connect((self.sprite_peak_decimator_ff_1, 0), (self.blocks_float_to_complex_0, 1))
        self.connect((self.sprite_single_correlator_cf_0, 0), (self.blocks_sub_xx_0, 0))
        self.connect((self.sprite_single_correlator_cf_1, 0), (self.blocks_sub_xx_0, 1))

    def get_n(self):
        return self.n

    def set_n(self, n):
        self.n = n
        self.set_zero_col(self.n)
        self.set_one_col(self.n+1)

    def get_zero_col(self):
        return self.zero_col

    def set_zero_col(self, zero_col):
        self.zero_col = zero_col

    def get_samp_rate_0(self):
        return self.samp_rate_0

    def set_samp_rate_0(self, samp_rate_0):
        self.samp_rate_0 = samp_rate_0

    def get_one_col(self):
        return self.one_col

    def set_one_col(self, one_col):
        self.one_col = one_col

    def get_chip_rate(self):
        return self.chip_rate

    def set_chip_rate(self, chip_rate):
        self.chip_rate = chip_rate


def argument_parser():
    parser = OptionParser(usage="%prog: [options]", option_class=eng_option)
    parser.add_option(
        "-n", "--n", dest="n", type="intx", default=42,
        help="Set n [default=%default]")
    return parser


def main(top_block_cls=top_block, options=None):
    if options is None:
        options, _ = argument_parser().parse_args()

    tb = top_block_cls(n=options.n)
    tb.start()
    tb.wait()


if __name__ == '__main__':
    main()
