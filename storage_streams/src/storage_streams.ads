----------------------------------------------------------------------
-- Package Storage_Streams (specification)                          --
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

with System;
with Ada.Streams;
with IO_Exceptions;
private with System.Storage_Elements;
package Storage_Streams is
   pragma Pure (Storage_Streams);
   use Ada.Streams;

   type Storage_Stream is new Ada.Streams.Root_Stream_Type with private;
   --  This stream reads and writes directly to memory, at the address
   --  set by  a call  to Set_Index. Status_Error  is raised  by Read,
   --  Write, and Index if called before any call to Set_Index.
   --
   --  After  a  call  to  Read  or  Write,  the  current  address  is
   --  incremented by the length of Item; therefore, consecutive calls
   --  to Read or Write access contiguous memory locations.
   --
   --  This package requires the size of components of a
   --  Stream_Element_Array to be System.Storage_Unit. Program_Error
   --  is raised at elaboration time if this is does not hold (very
   --  unlikely).

   overriding
   procedure Read (Stream : in out Storage_Stream;
                   Item   :    out Stream_Element_Array;
                   Last   :    out Stream_Element_Offset);

   overriding
   procedure Write (Stream : in out Storage_Stream;
                    Item   :        Stream_Element_Array);

   procedure Set_Index (Stream : in out Storage_Stream;
                        To     :        System.Address);

   function Index (Stream : Storage_Stream) return System.Address;

   Status_Error : exception renames IO_Exceptions.Status_Error;

private
   type Storage_Stream is new Ada.Streams.Root_Stream_Type with
      record
         Initialized   : Boolean := False;
         Current_Index : System.Storage_Elements.Integer_Address;
      end record;
end Storage_Streams;
