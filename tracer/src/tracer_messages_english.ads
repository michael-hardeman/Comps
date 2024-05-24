----------------------------------------------------------------------
-- Package TRACER_MESSAGES_ENGLISH (specification, no body)          --
-- (C) Copyright 1997, 2001 ADALOG                                  --
-- Author: J-P. Rosen                                               --
--                                                                  --
-- ADALOG is providing training, consultancy and expertise in Ada   --
-- and related software engineering techniques. For more info about --
-- our services:                                                    --
-- ADALOG                                                           --
-- 19-21 rue du 8 mai 1945                                          --
-- 94110 ARCUEIL            E-m: info@adalog.fr                     --
-- FRANCE                   URL: https://www.adalog.fr/             --
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
package Tracer_Messages_English is
   pragma Style_Checks (Off);
   --  All characters used for responses and all messages printed by Tracer are
   --  defined here, so if you want to customize it to another language, you
   --  only need to make a new version of this package, and modify the package
   --  Tracer_Messages to make it a renaming of it.

   --
   --  Characters used for responses
   --
   Yes_Char        : constant Wide_Character := 'Y'; -- "Yes" response
   No_Char         : constant Wide_Character := 'N'; -- "No" response

   -- Following characters must be different
   Status_Char     : constant Wide_Character := '?'; -- Status
   All_Char        : constant Wide_Character := 'A'; -- All (General)
   Blocking_Char   : constant Wide_Character := 'B'; -- toggle Block
   Console_Char    : constant Wide_Character := 'C'; -- Console
   Delay_Char      : constant Wide_Character := 'D'; -- Timer Delay
   Exclude_Char    : constant Wide_Character := 'E'; -- Exclude
   File_Char       : constant Wide_Character := 'F'; -- File
   Go_Char         : constant Wide_Character := 'G'; -- Go (=0)
   Help_Char       : constant Wide_Character := 'H'; -- Help
   Ignore_Char     : constant Wide_Character := 'I'; -- silent (Ignore)
   Mark_Char       : constant Wide_Character := 'M'; -- toggle mark state of task
   None_Char       : constant Wide_Character := 'N'; -- No output
   Only_Char       : constant Wide_Character := 'O'; -- Only marked tasks
   Quit_Char       : constant Wide_Character := 'Q'; -- Quit
   Step_Char       : constant Wide_Character := 'S'; -- Step (=1)
   Watch_Char      : constant Wide_Character := 'W'; -- call Watch procedure

   --
   --  General messages
   --
   Tracer_Message          : constant Wide_String := "**Trace** ";
   Task_Separator          : constant Wide_String := "--------------------";
   Main_Task_Message       : constant Wide_String := "Main-task ID = ";
   Initial_Message         : constant Wide_String := "V2.3. Initialization";
   Start_Message           : constant Wide_String := "Starting main program";
   Trace_Message           : constant Wide_String := "Trace Mode: Enter=Normal, " &
                                                ''' & Step_Char   & "'=Step, " &
                                                ''' & Ignore_Char & "'=Ignore Trace";
   Pause_Message           : constant Wide_String := "Pause";
   Quit_Message            : constant Wide_String := "Really quit ? ";
   Lost_Message            : constant Wide_String := "No more memory, some messages lost";
   Mismatched_Message      : constant Wide_String := "!!! Start/Stop Mismatched";
   Overwrite_Message       : constant Wide_String := ": file exists, overwrite ?";
   Multi_Task_Message      : constant Wide_String := "Entering multi-task mode, main task id = ";
   Watch_Exception_Message : constant Wide_String := "User watch procedure raised ";
   Timer_Exception_Message : constant Wide_String := "Timer procedure raised ";
   Timer_Message           : constant Wide_String := "Timer elapsed";
   End_Inifile_Message     : constant Wide_String := "End of ""Ini"" file, switching back to console";
   Syntax_Message          : constant Wide_String := "Illegal syntax in command : ";
   Bug_Message             : constant Wide_String := "Tracer internal error in ";
   Bug_Mess_Message        : constant Wide_String := "Exception message : ";
   Bug_Info_Message        : constant Wide_String := "Exception information : ";
   Command_Message         : constant Wide_String := "Command? ('" & Help_Char & "' for help) :";

   --
   --  Help and status messages
   --
   Help_Message : constant Wide_String :=  -- '\' is replaced by LF
      "Possible answers are :\" &
      "<Enter>"     &       "    : Resume execution with previous 'Go' value\" &
      Status_Char   & "          : Print current status\"                 &
      All_Char      & "          : trace All tasks (default)\"            &
      Blocking_Char & "          : toggle Blocking mode\"                 &
      Console_Char  & "          : trace to Console (default)\"           &
      Delay_Char    & "[Value]   : set Delay for timer\"                  &
      "             (0 or nothing = disable timer)\"       &
      Exclude_Char  & "          : trace Except marked tasks\"            &
      File_Char     & "          : trace to File\"                        &
      Go_Char       & "[<Number>]: Go, pause after <Number> messages\"    &
      "             (0 or nothing = don't pause)\"         &
      Help_Char     & "          : this Help\"                            &
      Ignore_Char   & "          : Ignore all calls to Tracer\"           &
      Mark_Char     & "          : Mark current task\"                    &
      None_Char     & "          : trace to None (no messages printed)\"  &
      Only_Char     & "          : trace Only marked tasks\"              &
      Quit_Char     & "          : Quit, stop execution\"                 &
      Step_Char     & "          : Step, pause after next message (=G1)\" &
      Watch_Char    & "          : call user Watch procedure";

   Message_Message    : constant Wide_String := "Pause message : ";
   Seltask_Message    : constant Wide_String := "Selected task : ";
   Reg_Message        : constant Wide_String := "Marked";
   Unreg_Message      : constant Wide_String := "Not marked";
   Completed_Message  : constant Wide_String := "Completed";
   Terminated_Message : constant Wide_String := "Terminated";
   Unmarkable_Message : constant Wide_String := "No selected task";
   General_Message    : constant Wide_String := "Tracing all tasks";
   Included_Message   : constant Wide_String := "Tracing only marked tasks";
   Excepted_Message   : constant Wide_String := "Tracing all but marked tasks";
   Console_Message    : constant Wide_String := "Trace output to console";
   File_Message       : constant Wide_String := "Trace output to file";
   None_Message       : constant Wide_String := "Trace output disabled";
   Go_Message         : constant Wide_String := "No pause";
   Step_Message       : constant Wide_String := "Pausing after each message";
   N_Message_1        : constant Wide_String := "Pausing after";
   N_Message_2        : constant Wide_String := " messages";
   Remaining_Message  : constant Wide_String := "Remaining time for timer: ";
   Infinite_Message   : constant Wide_String := "Infinite";
   Seconds_Message    : constant Wide_String := " seconds.";
   Aborting_Message   : constant Wide_String := "General abort in progress";
   Queued_Message     : constant Wide_String := "Number of queued messages:";
   Blocking_Message   : constant Wide_String := "Trace calls are ";
   Block_Yes_Message  : constant Wide_String := "blocking";
   Block_No_Message   : constant Wide_String := "not blocking";

   --  Syntax error messages
   Synt_Bad_Int : constant Wide_String := "Illegal integer value";
   Synt_Bad_Dur : constant Wide_String := "Illegal duration value";
   Synt_Bad_Com : constant Wide_String := "Not a tracer command - type " &
                                     ''' & Help_Char & "'' for help";

   --  Default file names
   Trace_File_Name   : constant String := "trace";
   Initial_File_Name : constant String := "trace.ini";

   --  Tracer.Timing messages
   Timer_Name               : constant Wide_String := "Timer";
   Timer_Not_Called_Message : constant Wide_String := " not called";
   Timer_Running_Message    : constant Wide_String := " currently running";
   Total_Message            : constant Wide_String := " Total:";
   Nb_Calls_Message         : constant Wide_String := ", Nb. calls:";
   Average_Message          : constant Wide_String := ", Average:";
   Seconds                  : constant Wide_String := "s.";
   No_Timer_Message         : constant Wide_String := "No timer called";
   Last_Timer_Message       : constant Wide_String := "Final timers report:";
end Tracer_Messages_English;
