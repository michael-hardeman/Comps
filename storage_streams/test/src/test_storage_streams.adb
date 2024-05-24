----------------------------------------------------------------------
-- Procedure T_SS (body)                                            --
-- (C) Copyright 2011 ADALOG                                        --
-- Author: J-P. Rosen                                               --
--                                                                  --
--  ADALOG   is   providing   training,   consultancy,   expertise, --
--  assistance and custom developments  in Ada and related software --
--  engineering techniques.  For more info about our services:      --
--  ADALOG                          Tel: +33 1 45 29 21 52          --
--  2 rue du Dr Lombard             Fax: +33 1 45 29 25 00          --
--  92441 ISSY-LES-MOULINEAUX CEDEX E-m: info@adalog.fr             --
--  FRANCE                          URL: http://www.adalog.fr       --
--                                                                  --
--  This  unit is  free software;  you can  redistribute  it and/or --
--  modify  it under  terms of  the GNU  General Public  License as --
--  published by the Free Software Foundation; either version 2, or --
--  (at your  option) any later version.  This  unit is distributed --
--  in the hope  that it will be useful,  but WITHOUT ANY WARRANTY; --
--  without even the implied warranty of MERCHANTABILITY or FITNESS --
--  FOR A  PARTICULAR PURPOSE.  See the GNU  General Public License --
--  for more details.   You should have received a  copy of the GNU --
--  General Public License distributed  with this program; see file --
--  COPYING.   If not, write  to the  Free Software  Foundation, 59 --
--  Temple Place - Suite 330, Boston, MA 02111-1307, USA.           --
--                                                                  --
--  As  a special  exception, if  other files  instantiate generics --
--  from  this unit,  or you  link this  unit with  other  files to --
--  produce an executable,  this unit does not by  itself cause the --
--  resulting executable  to be covered  by the GNU  General Public --
--  License.  This exception does  not however invalidate any other --
--  reasons why  the executable  file might be  covered by  the GNU --
--  Public License.                                                 --
----------------------------------------------------------------------

-- This is a test program for Storage_Streams

with Storage_Streams; use Storage_Streams;
with System.Storage_Elements; use System.Storage_Elements;
with Ada.Text_IO; use Ada.Text_IO;
procedure Test_Storage_Streams is  
   S      : aliased Storage_Stream;
   Buffer : Storage_Array (1..10) := (others => 0);
   
   function Is_Big_Endian return Boolean is
      type Int16 is range -2**15 .. 2**15-1;
      for Int16'Size use 16;
      Test : Int16 := 1;
   begin
      Set_Index (S, Buffer(1)'Address);
      Int16'Write (S'Access, Test);
      return Buffer(1) = 0;
   end Is_Big_Endian;
        
   I : Integer := 16#12345678#;
   
   package Int_IO  is new Integer_Io (Integer);         use Int_IO;
   package Elem_IO is new Modular_IO (Storage_Element); use Elem_IO;
begin
   Put ("This machine is ");
   if Is_Big_Endian then
      Put ("big");
   else
      Put ("little");
   end if;
   Put_Line (" endian");
   
   -- Original value of I
   Put ("Hex value of I: ");
   Put (I, Base => 16);
   New_Line;
   
   -- Stream it into Buffer (twice)
   Set_Index (S, Buffer(1)'Address);
   Integer'Write (S'Access, I);
   Integer'Write (S'Access, I);
   
   Put ("Hex value of Buffer (1..8):");
   for I in Storage_Offset range 1..8 loop
      Put (Buffer (I), Width => 7, Base => 16);
   end loop;
   New_Line;
   
   -- Read a different value
   I := 0;            -- Just to make sure that the value is actually read
   Set_Index (S, Buffer(2)'Address);
   Integer'Read (S'Access, I);
   
   Put ("Hex value of I (circular shift): ");
   Put (I, Base => 16);
   New_Line;
end Test_Storage_Streams;
