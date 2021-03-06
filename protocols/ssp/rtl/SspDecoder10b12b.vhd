-------------------------------------------------------------------------------
-- Company    : SLAC National Accelerator Laboratory
-------------------------------------------------------------------------------
-- Description: SimpleStreamingProtocol - A simple protocol layer for inserting
-- idle and framing control characters into a raw data stream. This module
-- ties the framing core to an RTL 10b12b encoder.
-------------------------------------------------------------------------------
-- This file is part of 'SLAC Firmware Standard Library'.
-- It is subject to the license terms in the LICENSE.txt file found in the
-- top-level directory of this distribution and at:
--    https://confluence.slac.stanford.edu/display/ppareg/LICENSE.html.
-- No part of 'SLAC Firmware Standard Library', including this file,
-- may be copied, modified, propagated, or distributed except according to
-- the terms contained in the LICENSE.txt file.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_ARITH.all;


library surf;
use surf.StdRtlPkg.all;
use surf.Code10b12bPkg.all;

entity SspDecoder10b12b is

   generic (
      TPD_G          : time    := 1 ns;
      RST_POLARITY_G : sl      := '0';
      RST_ASYNC_G    : boolean := true);

   port (
      clk       : in  sl;
      rst       : in  sl := RST_POLARITY_G;
      dataIn    : in  slv(11 downto 0);
      validIn   : in  sl := '1';
      dataOut   : out slv(9 downto 0);
      validOut  : out sl;
      sof       : out sl;
      eof       : out sl;
      eofe      : out sl;
      codeError : out sl;
      dispError : out sl);

end entity SspDecoder10b12b;

architecture rtl of SspDecoder10b12b is

   signal validDec     : sl;
   signal codeErrorInt : sl;
   signal framedData   : slv(9 downto 0);
   signal framedDataK  : slv(0 downto 0);

begin

   Decoder10b12b_1 : entity surf.Decoder10b12b
      generic map (
         TPD_G          => TPD_G,
         RST_POLARITY_G => RST_POLARITY_G,
         RST_ASYNC_G    => RST_ASYNC_G)
      port map (
         clk       => clk,
         clkEn     => '1',
         rst       => rst,
         validIn   => validIn,
         dataIn    => dataIn,
         dataOut   => framedData,
         dataKOut  => framedDataK(0),
         validOut  => validDec,
         codeError => codeErrorInt,
         dispError => dispError);

   codeError <= codeErrorInt;

   SspDeframer_1 : entity surf.SspDeframer
      generic map (
         TPD_G           => TPD_G,
         RST_POLARITY_G  => RST_POLARITY_G,
         RST_ASYNC_G     => RST_ASYNC_G,
         WORD_SIZE_G     => 10,
         K_SIZE_G        => 1,
         SSP_IDLE_CODE_G => K_28_3_C,
         SSP_IDLE_K_G    => "1",
         SSP_SOF_CODE_G  => K_28_10_C,
         SSP_SOF_K_G     => "1",
         SSP_EOF_CODE_G  => K_28_21_C,
         SSP_EOF_K_G     => "1")
      port map (
         clk      => clk,
         rst      => rst,
         validIn  => validDec,
         dataIn   => framedData,
         dataKIn  => framedDataK,
         dataOut  => dataOut,
         validOut => validOut,
         sof      => sof,
         eof      => eof,
         eofe     => eofe);



end architecture rtl;
