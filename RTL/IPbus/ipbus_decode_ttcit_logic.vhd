-- Address decode logic for ipbus fabric
-- 
-- This file has been AUTOGENERATED from the address table - do not hand edit
-- 
-- We assume the synthesis tool is clever enough to recognise exclusive conditions
-- in the if statement.
-- 
-- Dave Newbold, February 2011

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

package ipbus_decode_ttcit_logic is

  constant IPBUS_SEL_WIDTH: positive := 5;
  subtype ipbus_sel_t is std_logic_vector(IPBUS_SEL_WIDTH - 1 downto 0);
  function ipbus_sel_ttcit_logic(addr : in std_logic_vector(31 downto 0)) return ipbus_sel_t;

-- START automatically  generated VHDL the Fri Dec 13 19:30:56 2019 
  constant N_SLV_CTRL: integer := 0;
  constant N_SLV_ICAP: integer := 1;
  constant N_SLV_RAM: integer := 2;
  constant N_SLV_REG: integer := 3;
  constant N_SLV_PRAM: integer := 4;
  constant N_SLV_I2CMAIN: integer := 5;
  constant N_SLV_BBERT: integer := 6;
  constant N_SLV_SPIADC: integer := 7;
  constant N_SLV_I2CPLL: integer := 8;
  constant N_SLV_SSM: integer := 9;
  constant N_SLV_SSMCTRL: integer := 10;
  constant N_SLV_TDG: integer := 11;
  constant N_SLV_TDGCTRL: integer := 12;
  constant N_SLV_FLASH_SPI_RAM_0: integer := 13;
  constant N_SLV_FLASH_SPI_RAM_1: integer := 14;
  constant N_SLV_CNTS: integer := 15;
  constant N_SLAVES: integer := 16;
-- END automatically generated VHDL

    
end ipbus_decode_ttcit_logic;

package body ipbus_decode_ttcit_logic is

  function ipbus_sel_ttcit_logic(addr : in std_logic_vector(31 downto 0)) return ipbus_sel_t is
    variable sel: ipbus_sel_t;
  begin

-- START automatically  generated VHDL the Fri Dec 13 19:30:56 2019 
    if    std_match(addr, "------------------00-000-000----") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_CTRL, IPBUS_SEL_WIDTH)); -- ctrl / base 0x00000000 / mask 0x00003770
    elsif std_match(addr, "------------------00-001-0000---") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_ICAP, IPBUS_SEL_WIDTH)); -- icap / base 0x00000100 / mask 0x00003778
    elsif std_match(addr, "------------------01-0----------") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_RAM, IPBUS_SEL_WIDTH)); -- ram / base 0x00001000 / mask 0x00003400
    elsif std_match(addr, "------------------01-100-0000---") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_REG, IPBUS_SEL_WIDTH)); -- reg / base 0x00001400 / mask 0x00003778
    elsif std_match(addr, "------------------10-000-0000---") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_PRAM, IPBUS_SEL_WIDTH)); -- pram / base 0x00002000 / mask 0x00003778
    elsif std_match(addr, "------------------10-000-0001---") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_I2CMAIN, IPBUS_SEL_WIDTH)); -- i2cmain / base 0x00002008 / mask 0x00003778
    elsif std_match(addr, "------------------10-000-0100---") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_BBERT, IPBUS_SEL_WIDTH)); -- bbert / base 0x00002020 / mask 0x00003778
    elsif std_match(addr, "------------------10-000-0101---") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_SPIADC, IPBUS_SEL_WIDTH)); -- spiadc / base 0x00002028 / mask 0x00003778
    elsif std_match(addr, "------------------10-000-0110---") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_I2CPLL, IPBUS_SEL_WIDTH)); -- i2cpll / base 0x00002030 / mask 0x00003778
    elsif std_match(addr, "------------------10-000-100----") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_SSM, IPBUS_SEL_WIDTH)); -- ssm / base 0x00002040 / mask 0x00003770
    elsif std_match(addr, "------------------10-000-1010---") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_SSMCTRL, IPBUS_SEL_WIDTH)); -- ssmctrl / base 0x00002050 / mask 0x00003778
    elsif std_match(addr, "------------------10-000-110----") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_TDG, IPBUS_SEL_WIDTH)); -- tdg / base 0x00002060 / mask 0x00003770
    elsif std_match(addr, "------------------10-000-1110---") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_TDGCTRL, IPBUS_SEL_WIDTH)); -- tdgctrl / base 0x00002070 / mask 0x00003778
    elsif std_match(addr, "------------------10-01---------") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_FLASH_SPI_RAM_0, IPBUS_SEL_WIDTH)); -- FLASH_SPI_Ram_0 / base 0x00002200 / mask 0x00003600
    elsif std_match(addr, "------------------10-10---------") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_FLASH_SPI_RAM_1, IPBUS_SEL_WIDTH)); -- FLASH_SPI_Ram_1 / base 0x00002400 / mask 0x00003600
    elsif std_match(addr, "------------------10-110-0------") then
      sel := ipbus_sel_t(to_unsigned(N_SLV_CNTS, IPBUS_SEL_WIDTH)); -- cnts / base 0x00002600 / mask 0x00003740
-- END automatically generated VHDL

    else
        sel := ipbus_sel_t(to_unsigned(N_SLAVES, IPBUS_SEL_WIDTH));
    end if;

    return sel;

  end function ipbus_sel_ttcit_logic;

end ipbus_decode_ttcit_logic;

