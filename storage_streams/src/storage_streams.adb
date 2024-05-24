----------------------------------------------------------------------
-- Package Storage_Streams (body)                                   --
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

package body Storage_Streams is
   use System.Storage_Elements;

   ----------
   -- Read --
   ----------

   overriding
   procedure Read (Stream : in out Storage_Stream;
                   Item   :    out Stream_Element_Array;
                   Last   :    out Stream_Element_Offset)
   is
      Source : Stream_Element_Array (1 .. Item'Length);
      for Source'Address use To_Address (Stream.Current_Index);
   begin
      if not Stream.Initialized then
         raise Status_Error;
      end if;

      Item := Source;
      Last := Item'Last;
      Stream.Current_Index := Stream.Current_Index + Item'Length;
   end Read;

   -----------
   -- Write --
   -----------

   overriding
   procedure Write (Stream : in out Storage_Stream;
                    Item   :        Stream_Element_Array)
   is
      Target : Stream_Element_Array (1 .. Item'Length);
      for Target'Address use To_Address (Stream.Current_Index);
   begin
      if not Stream.Initialized then
         raise Status_Error;
      end if;

      Target := Item;
      Stream.Current_Index := Stream.Current_Index + Item'Length;
   end Write;

   ---------------
   -- Set_Index --
   ---------------

   procedure Set_Index (Stream : in out Storage_Stream;
                        To     :        System.Address)
   is
   begin
      --  Sorry, cannot use aggregate here since Stream is of a limited type:
      Stream.Initialized   := True;
      Stream.Current_Index := To_Integer (To);
   end Set_Index;

   -----------
   -- Index --
   -----------

   function Index (Stream : Storage_Stream) return System.Address is
   begin
      if not Stream.Initialized then
         raise Status_Error;
      end if;

      return To_Address (Stream.Current_Index);
   end Index;

begin
   if Stream_Element_Array'Component_Size /= System.Storage_Unit then
      raise Program_Error;
   end if;
end Storage_Streams;
