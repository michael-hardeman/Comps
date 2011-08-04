----------------------------------------------------------------------
--  Binary_Map - Package specification                              --
--  Copyright (C) 2005 Adalog                                       --
--  Author: J-P. Rosen                                              --
--                                                                  --
--  ADALOG   is   providing   training,   consultancy,   expertise, --
--  assistance and custom developments  in Ada and related software --
--  engineering techniques.  For more info about our services:      --
--  ADALOG                   Tel: +33 1 41 24 31 40                 --
--  19-21 rue du 8 mai 1945  Fax: +33 1 41 24 07 36                 --
--  94110 ARCUEIL            E-m: info@adalog.fr                    --
--  FRANCE                   URL: http://www.adalog.fr              --
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

generic
   type Key_Type   is private;
   type Value_Type is private;
   with function "<" (Left, Right : Key_Type) return Boolean is <>;
   with function ">" (Left, Right : Key_Type) return Boolean is <>;
package Binary_Map is
   type Map is private;     -- Object semantic

   Not_Present : exception;

   procedure Add        (To     : in out Map; Key : Key_Type; Value : Value_Type);
   procedure Delete     (From   : in out Map; Key : Key_Type);
   function  Fetch      (From   : in     Map; Key : Key_Type) return Value_Type;
   -- Raises Not_Present if Key not found

   function  Fetch      (From   : in     Map; Key : Key_Type; Default_Value : Value_Type)
                        return Value_Type;
   -- Returns Default_Value if Key not found

   function  Is_Present (Within : in     Map; Key : Key_Type) return Boolean;

   generic
      with procedure Action (Key : in Key_Type; Value : in out Value_Type);
   procedure Iterate (On : Map);

   -- Rebalance the binary map.
   procedure Balance (The_Map : in out Map);

   -- Clears all elements:
   procedure Clear (The_Map : in out Map);

private
   type Slots is (Before, After);
   type Two_Pool is array (Slots) of Map;
   type Node is
      record
         Key      : Key_Type;
         Value    : Value_Type;
         Children : Two_Pool;
      end record;
   type Map is access Node;
end Binary_Map;

