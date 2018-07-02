-------------------------------------------------------------------------------
-- File       : AxiStreamDmaV3Desc.vhd
-- Company    : SLAC National Accelerator Laboratory
-- Created    : 2018-06-29
-- Last update: 2018-07-02
-------------------------------------------------------------------------------
-- Description:
-- Descriptor manager for AXI DMA read and write engines.
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
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.NUMERIC_STD.all;

use work.StdRtlPkg.all;
use work.AxiPkg.all;
use work.AxiLitePkg.all;
use work.AxiDmaPkg.all;
use work.ArbiterPkg.all;

entity AxiStreamDmaV3Desc is
   generic (
      TPD_G             : time                  := 1 ns;             -- Propagation Delay
      CHAN_COUNT        : integer range 1 to 16 := 1;                -- Channel count
      AXIL_BASE_ADDR_G  : slv(31 downto 0)      := x"00000000";      -- Axi Lite Base Address
      AXI_READY_EN_G    : boolean               := false;            -- Axi ready signal
      AXI_CONFIG_G      : AxiConfigType         := AXI_CONFIG_INIT_C;
      DESC_AWIDTH_G     : integer range 4 to 12 := 12;               -- Descriptor Address width
      DESC_ARB_G        : boolean               := true;
      ACK_WAIT_BVALID_G : boolean               := true);            -- Wait ack valid




end AxiStreamDmaV3Desc;
