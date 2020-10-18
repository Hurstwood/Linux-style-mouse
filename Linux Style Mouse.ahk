


SetTitleMatchMode 2
#SingleInstance ignore
#NoTrayIcon



Alt & LButton::
{

   CoordMode, Mouse, Screen	; Switch to screen coordinates.
   MouseGetPos, MouseStartX, MouseStartY, MouseWin	;Get the current mouse position
   WinGetPos, OriginalPosX, OriginalPosY,,, ahk_id %MouseWin%	;Get the current window position
   WinGet, WinState, MinMax, ahk_id %MouseWin%		;Gets the maximize/minimize state of the window

   WinNewX := OriginalPosX	;Copies the original position, ready for move - X
   WinNewY := OriginalPosY	;Copies the original position, ready for move - Y


   if WinState = 0  	;Only move the window if it's not maximized
   {
      a = 0
      while a = 0
      { 
         GetKeyState, LButtonState, LButton, P	;Checks the physical state of the left mouse button.

         if LButtonState = U  ;Has the left mouse Button has been released?
         {  ;Yes. So turn off the constant calling of the sub-routine and quit the program.
            return
         }

         GetKeyState, EscapeState, Escape, P		;Checks the physical state of the Escape button.
         if EscapeState = D  	;Has the Escape button been pressed?
         { ;Yes. The user must want the move to be cancelled.
            WinMove, ahk_id %MouseWin%,, %OriginalPosX%, %OriginalPosY%	;Set the window back to the original position.
            return	;Quit the program
         }


         CoordMode, Mouse	; Switch to screen coordinates.
         MouseGetPos, MouseNewX, MouseNewY	;Get the new mouse position
   
         WinNewX := WinNewX + MouseNewX - MouseStartX		;Calculates the new window position - X
         WinNewY := WinNewY + MouseNewY - MouseStartY		;Calculates the new window position - Y


         SetWinDelay, -1   ;Sets the delay for every windowing command to zero.
         WinMove, ahk_id %MouseWin%,, WinNewX, WinNewY

         MouseStartX := MouseNewX     ;Updates the mouse position for the next run through - X
         MouseStartY := MouseNewY	;Updates the mouse position for the next run through - Y
      }
   }
   return
}