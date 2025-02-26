;//////////////////////////////////////////////////////////////////////////
;// Copyright (c) 2025 Nikolai Gurin negurin91@mail.ru under MIT license //
;//////////////////////////////////////////////////////////////////////////

;//////////////////////////////////////////////////////////////////////////
;// Alon (ALways ONline) utility keeps your computer online at all times //
;//////////////////////////////////////////////////////////////////////////

;//////////////////////////////////////////////////////////////////////////
;// Purpose: Emulate computer activity by moving the mouse on the screen //
;//////////////////////////////////////////////////////////////////////////

#Region
#AutoIt3Wrapper_Icon=alon.ico
#EndRegion
#include <WinAPIShPath.au3>
Local $x
Local $hr
Local $mn
Local $CmdLine = _WinAPI_CommandLineToArgv($CmdLineRaw)

; Set default parameters if command line is empty
Func defPar()
   $hr = 99
   $mn = 99
EndFunc

; Get command line parameters from execute file
Func getParExe()
   if $CmdLine[0] >= 2 Then
      $hr = $CmdLine[1]
      $mn = $CmdLine[2]
   Else
      defPar()
   EndIf
EndFunc

; Get command line parameters from script file
Func getParScr()
   if $CmdLine[0] >= 3 Then
      $hr = $CmdLine[2]
      $mn = $CmdLine[3]
   Else
      defPar()
   EndIf
EndFunc

; Read command line parameters
if @Compiled = 1 Then
   getParExe()
Else
   getParScr()
EndIf

; Move the mouse cursor instantly
Local $mPos = MouseGetPos()
Local $xPos = $mPos[0]
Local $yPos = $mPos[1]
If $xPos <> 1 Then
   $xPos = $xPos - 1
   $x = $xPos
   MouseMove($xPos, $yPos, 10)
EndIf

While 1
   Sleep(50)
   $x = $x + 1
   MouseMove($x, $yPos, 10)
   Local $P = MouseGetPos()
   If ($P[0] <> $x) Or ($P[1] <> $yPos) Then ExitLoop
   If $x = $xPos + 1 Then $x = $xPos
   If (@HOUR >= $hr) And (@MIN >= $mn) Then ExitLoop
WEnd
