#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=Beta
#AutoIt3Wrapper_Icon=res\icon.ico
#AutoIt3Wrapper_Res_File_Add=res\beer.jpg
#AutoIt3Wrapper_Res_File_Add=orbis-pub-cmd.exe
#AutoIt3Wrapper_Res_File_Add=Unfself.exe
#AutoIt3Wrapper_Res_File_Add=gengp4.exe
#AutoIt3Wrapper_Res_File_Add=orbis-pub-gen.exe
#AutoIt3Wrapper_Res_File_Add=sfo.py
#AutoIt3Wrapper_Res_File_Add=elf.py
#AutoIt3Wrapper_Res_File_Add=ext\di.exe
#AutoIt3Wrapper_Res_File_Add=ext\libatrac9.dll
#AutoIt3Wrapper_Res_File_Add=ext\sc.exe
#AutoIt3Wrapper_Res_File_Add=ext\trp_compare_default.css
#AutoIt3Wrapper_Run_Tidy=y
#AutoIt3Wrapper_Run_Au3Stripper=n
#pragma compile(Icon, res\icon.ico)
#pragma compile(UPX, false)
#pragma compile(FileDescription, Pkg Downgrade Tool)
#pragma compile(ProductName, PkgDT)
#pragma compile(ProductVersion, 1.0)
#pragma compile(ProductVersion, 1.0)
#pragma compile(LegalCopyright, © Francesco Gerratana)
#pragma compile(CompanyName, Nextechnics)
#pragma compile(OriginalFilename, PkgDT.exe)
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

	PkgDT: Pkg Downgrade Tool

	AutoIt Version: 3.3.14.5
	Author: Francesco Gerratana
	Website: Nextechnics.com
	Licence: GPLv3 https://www.gnu.org/licenses/gpl-3.0.html

	Script Function:
	PS4 Backporting

	Legal info:

	This program was written for an educational use, does not include any external copyrighted files,
	do not ask me how to find them, does not intend to support piracy, it's free and without
	any guarantee. If you do not agree to these rules, please do not download it.

	If you want the project continues, then subscribe to my youtube channel or make a donation.

	http://www.nextechnics.com/

	Follow Me on my channel

	https://www.youtube.com/user/nextechnics
	https://it-it.facebook.com/nextechnics/
	https://twitter.com/nextechnics

	Donation

	https://www.paypal.com/donate/?token=VV5v1HqWQAX8oBSY-w-GIqU-Hsp0Q8tMFOYqpFJ5liUwvg06JdJzsnxd2INpgROAX8IWAG&country.x=IT&locale.x=IT

	You must have the following files:

	Inside ext folder

	-di.exe
	-libatrac9.dll
	-sc.exe
	-trp_compare_default.css

	Inside root folder

	-gengp4.exe
	-orbis-pub-cmd.exe
	-Unfself.exe
	-gengp4.exe
	-orbis-pub-gen.exe
	-sfo.py
	-elf.py


#ce ----------------------------------------------------------------------------
#include <Array.au3>
#include <File.au3>
#include <AutoItConstants.au3>
#include <MsgBoxConstants.au3>
#include <String.au3>
#include <GuiEdit.au3>
#include <Date.au3>
; ----------------------------------------------------------------------------#
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <WinAPI.au3>


Global $orbis = @ScriptDir & "\orbis-pub-cmd.exe", _ ;essential  tool
		$unfself = @ScriptDir & "\Unfself.exe", _ ;essential  tool ;$jsonp = @ScriptDir&"\dirstr.exe", _ essential  tool
		$gengp4 = @ScriptDir & "\gengp4.exe", _ ;essential  tool
		$orbis_pub_gen = @ScriptDir & "\orbis-pub-gen.exe", _ ;essential  tool
		$sfo_py = @ScriptDir & "\sfo.py", _ ;essential  tool
		$elf_py = @ScriptDir & "\elf.py", _ ;essential  tool
		$ext = @ScriptDir & "\ext", _ ;essential  tool
		$f_working = @ScriptDir & "\working", _ ;contain file modded
		$f_decrypt = @ScriptDir & "\boot_mod", _ ;put here decrypted file param and eboot
		$f_prxmod = @ScriptDir & "\prx_mod", _ ;put here prx decrypted
		$f_patch = @ScriptDir & "\patch", _ ;destination img created from output.gp4
		$f_unpack = @ScriptDir & "\unpack", _ ;Default target dir to extract pgk
		$f_Image0 = @ScriptDir & "\working\Image0", _ ;Ps4 target folder
		$f_Sc0 = @ScriptDir & "\working\Sc0", _ ;Ps4 target folder
		$f_sce_sys = @ScriptDir & "\working\Image0\sce_sys", _ ;Ps4 target folder
		$f_sce_module = @ScriptDir & "\working\Image0\sce_module", _ ;Ps4 target folder
		$f_localcachepink = @ScriptDir & "\working\Image0\localcachepink", _ ;Ps4 target folder
		$log_time = (StringRegExpReplace(_NowCalcDate(), "(\d\d\d\d)/(\d\d)/(\d\d)", "$3-$2-$1") & "_Time_" & StringReplace(_NowTime(5), ":", "-")), _
		$fl_log = @ScriptDir & "\log\" & $log_time & ".txt" ; Log file

DirCreate($ext)
DirCreate($f_unpack)
DirCreate($f_working)
DirCreate($f_decrypt)
DirCreate($f_prxmod)
DirCreate($f_patch)
DirCreate(@ScriptDir & "\log")
DirCreate(@ScriptDir & "\res")

;graphics resources

$ico = @ScriptDir & "\res\icon.ico"
$jpg = @ScriptDir & "\res\beer.jpg"

; Include all files inside your final PkgDT.exe | Change the path C:\Project\PS4\ with your current path ex: C:\Users\Sam\Desktop \PS4...
Local $bFileInstall = True
If $bFileInstall Then
	FileInstall("C:\Project\PS4\res\beer.jpg", $jpg)
	FileInstall("C:\Project\PS4\orbis-pub-cmd.exe", $orbis)
	FileInstall("C:\Project\PS4\Unfself.exe", $unfself)
	FileInstall("C:\Project\PS4\gengp4.exe", $gengp4)
	FileInstall("C:\Project\PS4\orbis-pub-gen.exe", $orbis_pub_gen)
	FileInstall("C:\Project\PS4\sfo.py", $sfo_py)
	FileInstall("C:\Project\PS4\elf.py", $elf_py)
	FileInstall("C:\Project\PS4\ext\di.exe", $ext & "\di.exe")
	FileInstall("C:\Project\PS4\ext\libatrac9.dll", $ext & "\libatrac9.dll")
	FileInstall("C:\Project\PS4\ext\sc.exe", $ext & "\sc.exe")
	FileInstall("C:\Project\PS4\ext\trp_compare_default.css", $ext & "\trp_compare_default.css")
EndIf

Global $cfg_ini = (@ScriptDir & "\cfg.ini")

If Not FileExists($cfg_ini) Then

	IniWrite(@ScriptDir & "\cfg.ini", "PATH", "scriptdir", @ScriptDir)

EndIf


#Region ### START Koda GUI section ### Form=
$Form1_1 = GUICreate("PkgDT | Ps4 Pkg Downgrade Tools | Gui | Nextechnics 2020", 801, 601, -1, -1)
GUISetIcon($ico, -1)
GUISetBkColor(0x646464)
$Button1 = GUICtrlCreateButton("Select file", 19, 78, 130, 30)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
$Button2 = GUICtrlCreateButton("Copy Boot Files", 19, 121, 130, 30)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$Button3 = GUICtrlCreateButton("Unfself Eboot", 19, 165, 130, 30)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
$Button4 = GUICtrlCreateButton("Search Prx", 19, 208, 130, 30)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
$Button5 = GUICtrlCreateButton("Unfself Prx", 19, 251, 130, 30)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
$Button6 = GUICtrlCreateButton("Donwgrade Prx", 19, 295, 130, 30)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
$Button7 = GUICtrlCreateButton("Copy Decrypted Prx", 19, 338, 130, 30)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
$Button8 = GUICtrlCreateButton("Generate .GP4", 19, 381, 130, 30)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
$Button9 = GUICtrlCreateButton("Create Pkg Patch", 19, 425, 130, 30)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetCursor(-1, 0)
$Button10 = GUICtrlCreateButton("GitHub", 19, 468, 130, 30)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$Label1 = GUICtrlCreateLabel("Log Console", 168, 24, 74, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
$Edit1 = GUICtrlCreateEdit("", 168, 50, 609, 485, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_WANTRETURN, $WS_VSCROLL))
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0x000000)
$Pic1 = GUICtrlCreatePic($jpg, 312, 544, 52, 52)
$Label2 = GUICtrlCreateLabel("Click and Buy me a beer !!!", 376, 560, 266, 29)
GUICtrlSetFont(-1, 15, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 0xFFFFFF)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

GUICtrlSetData($Edit1, @CRLF & "----------------------------------------------- Welcome " & @UserName & " -----------------------------------------------" & @CRLF & @CRLF, 1)


While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $Button1

			Selectfile()

		Case $Button2

			Copy_Boot_file()

		Case $Button3

			Unfself_Eboot()

		Case $Button4

			Find_Prx()

		Case $Button5

			Unfself_Prx()

		Case $Button6

			Donwgrade_Prx()

		Case $Button7

			Copy_Decrypted_Prx()

		Case $Button8

			ShellExecute($gengp4)

		Case $Button9

			Img_Create()

		Case $Button10

			ShellExecute("www.google.com/git")

		Case $Label2

			ShellExecute("www.google.com")

	EndSwitch
WEnd

; ----------------------------------------------------------------------------#

; Select File Pkg 1

Func Selectfile()

	Local $input_pkg = FileOpenDialog("Select your Pkg file", @ScriptDir, "PS4 (*.pkg)", $FD_FILEMUSTEXIST)

	If @error Then
		MsgBox($MB_SYSTEMMODAL, "Error", "No file(s) were selected.")
	Else
		$input_pkg = StringReplace($input_pkg, "|", @CRLF)
		ConsoleWrite("You chose this file: " & $input_pkg & @CRLF)
		GUICtrlSetData($Edit1, "You chose this file: " & $input_pkg & @CRLF, 1)
		GUICtrlSetData($Edit1, "Game Id: " & BinaryToString(Get_ID_GAME($input_pkg, 0x040, 36)) & @CRLF, 1)
		IniWrite($cfg_ini, "TITLE", "game_Id", BinaryToString(Get_ID_GAME($input_pkg, 0x040, 36)))
		$output_pkg = FileSelectFolder("Select uncompress Pkg destination", @ScriptDir)
		If @error Then
			MsgBox($MB_SYSTEMMODAL, "", "No folder was selected.")
		Else
			ConsoleWrite("You chose this folder: " & $output_pkg & @CRLF)
			GUICtrlSetData($Edit1, "You chose this folder: " & $output_pkg & @CRLF & @CRLF, 1)
			IniWrite($cfg_ini, "PATH", "input_pkg", $input_pkg)
			IniWrite($cfg_ini, "PATH", "output_pkg", $output_pkg)
			Extract_pkg($input_pkg, $output_pkg)
		EndIf
	EndIf

EndFunc   ;==>Selectfile


; Extract file pkg 2

Func Extract_pkg($in, $out)

	Local $runOrbis = Run($orbis & " img_extract --passcode 00000000000000000000000000000000 " & '"' & $in & '"' & ' ' & '"' & $out & '"', '', @SW_HIDE, $STDERR_MERGED + $STDIN_CHILD)
	ConsoleWrite($orbis & " img_extract --passcode 00000000000000000000000000000000 " & '"' & $in & '"' & ' ' & '"' & $out & '"' & @CRLF)
	Run_Output($runOrbis, "Extract Pkg")

EndFunc   ;==>Extract_pkg


; Move to Temp folder $f_decrypt() 3

Func Copy_Boot_file()

	Local $output_pkg = IniRead($cfg_ini, "PATH", "output_pkg", "")

	If FileExists($output_pkg & "\Image0\eboot.bin") And FileExists($output_pkg & "\Sc0\param.sfo") Then

		GUICtrlSetData($Edit1, "######### Start Copy Boot Files #########" & @CRLF, 1)

		FileCopy($output_pkg & "\Sc0\param.sfo", $f_decrypt & "\param.sfo", 1)
		FileCopy($output_pkg & "\Image0\eboot.bin", $f_decrypt & "\eboot.bin", 1)

		GUICtrlSetData($Edit1, @CRLF & @CRLF & "Copy File in : " & $f_decrypt & "\param.sfo", 1)
		GUICtrlSetData($Edit1, @CRLF & @CRLF & "Copy File in : " & $f_decrypt & "\eboot.bin" & @CRLF & @CRLF, 1)

		GUICtrlSetData($Edit1, "######### End Copy Boot Files #########" & @CRLF, 1)

	Else

		MsgBox(0, "Failed File not found", @error)

	EndIf

EndFunc   ;==>Copy_Boot_file


; Unfself_Eboot And restore in Working folder 4

Func Unfself_Eboot()

	Local $runUnfself = Run(@ComSpec & " /c " & $unfself & " < nul " & '"' & $f_decrypt & "\eboot.bin" & '"', '', @SW_HIDE, $STDERR_MERGED + $STDIN_CHILD)
	ConsoleWrite($unfself & " " & '"' & $f_decrypt & "\eboot.bin" & '"' & @CRLF)
	Run_Output($runUnfself, "Unself Eboot")


	FileDelete($f_decrypt & "\eboot.bin")


	FileMove($f_decrypt & "\eboot.bin-decrypted", $f_decrypt & "\eboot.old.bin", 1)
	FileMove($f_decrypt & "\param.sfo", $f_decrypt & "\param.old.sfo", 1)

	Local $runElf = Run(@ComSpec & " /c " & "python " & '"' & $elf_py & '"' & " --sdk-version 05.050.001 --verbose " & $f_decrypt & "\eboot.old.bin " & $f_decrypt & "\eboot.bin", '', @SW_HIDE, $STDERR_MERGED + $STDIN_CHILD)
	ConsoleWrite(@ComSpec & " /c " & "python " & '"' & $elf_py & '"' & " --sdk-version 05.050.001 --verbose " & $f_decrypt & "\eboot.old.bin " & $f_decrypt & "\eboot.bin" & @CRLF)
	Run_Output($runElf, "Run Elf Function")


	Local $runSfo = Run(@ComSpec & " /c " & "python " & '"' & $sfo_py & '"' & " --sdk-version 05.050.001 --system-version 05.050.000 --verbose " & '"' & $f_decrypt & "\param.old.sfo" & '"' & " " & '"' & $f_decrypt & "\param.sfo" & '"', '', @SW_HIDE, $STDERR_MERGED + $STDIN_CHILD)
	ConsoleWrite(@ComSpec & " /c " & "python " & '"' & $sfo_py & '"' & " --sdk-version 05.050.001 --system-version 05.050.000 --verbose " & '"' & $f_decrypt & "\param.old.sfo" & '"' & " " & '"' & $f_decrypt & "\param.sfo" & '"' & @CR)
	Run_Output($runSfo, "Run Sfo Function")


	DirCreate($f_working & "\Image0")
	FileMove($f_decrypt & "\eboot.bin", $f_working & "\Image0\eboot.bin", 1)
	FileDelete($f_decrypt & "\eboot.old.bin")

	DirCreate($f_working & "\Image0\sce_sys")
	FileMove($f_decrypt & "\param.sfo", $f_working & "\Image0\sce_sys\param.sfo", 1)
	FileDelete($f_decrypt & "\param.old.sfo")


	$f_sce_sys_in = IniRead($cfg_ini, "PATH", "output_pkg", "") & "\Image0\sce_sys"
	$f_Sc0_in = IniRead($cfg_ini, "PATH", "output_pkg", "") & "\Sc0"


	$xcopy = Run(@ComSpec & " /c " & "xcopy " & '"' & $f_sce_sys_in & '" "' & $f_sce_sys & "\" & '" /Y /H /E /C', '', @SW_HIDE, $STDERR_MERGED + $STDIN_CHILD)
	ConsoleWrite(@ComSpec & " /c " & "xcopy " & '"' & $f_sce_sys_in & '" "' & $f_sce_sys & "\" & '" /Y /H /E /C' & @CRLF)
	Run_Output($xcopy, "Copy sce_sys")

	$xcopy2 = Run(@ComSpec & " /c " & "xcopy " & '"' & $f_Sc0_in & '" "' & $f_sce_sys & "\" & '" /Y /H /E /C', '', @SW_HIDE, $STDERR_MERGED + $STDIN_CHILD)
	ConsoleWrite(@ComSpec & " /c " & "xcopy " & '"' & $f_Sc0_in & '" "' & $f_sce_sys & "\" & '" /Y /H /E /C' & @CRLF)
	Run_Output($xcopy2, "Copy Sc0")

EndFunc   ;==>Unfself_Eboot


; Find Prx() 5 Search all Prx files and rebuild the directory structure with prx included inside prxmod folder

Func Find_Prx()

	GUICtrlSetData($Edit1, "######### Start Search Prx Files #########" & @CRLF & @CRLF, 1)

	Local $prxpath = IniRead($cfg_ini, "PATH", "output_pkg", "")

	Local $sDrive = "", $sDir = "", $sFileName = "", $sExtension = ""

	Local $Arr_fprx = _FileListToArrayRec($prxpath, "*.prx", 1, 1, 0, 2)


	For $f = 1 To UBound($Arr_fprx) - 1

		$prxo = _PathSplit($Arr_fprx[$f], $sDrive, $sDir, $sFileName, $sExtension)

		$Dir = $f_prxmod & StringReplace($prxo[1] & $prxo[2], @ScriptDir, "")

		DirCreate($Dir)

		ConsoleWrite($f_prxmod & StringReplace($prxo[1] & $prxo[2], @ScriptDir, "") & @CRLF)

		If FileExists($Dir) And StringInStr(FileGetAttrib($Dir), "D") Then

			FileCopy($Arr_fprx[$f], $f_prxmod & StringReplace($Arr_fprx[$f], @ScriptDir, ""), 1)

			ConsoleWrite($Arr_fprx[$f] & "----" & @CRLF & "----TO----" & @CRLF & $f_prxmod & StringReplace($Arr_fprx[$f], @ScriptDir, "") & @CRLF & @CRLF)

			GUICtrlSetData($Edit1, $Arr_fprx[$f] & "----" & @CRLF & "----TO----" & @CRLF & $f_prxmod & StringReplace($Arr_fprx[$f], @ScriptDir, "") & @CRLF & @CRLF, 1)

		Else

			FileWrite(@ScriptDir & "\prx_copy_log.txt", "Err -- Folder " & $f_prxmod & $prxo[2] & " not exist")
			GUICtrlSetData($Edit1, "Err -- Folder " & $f_prxmod & $prxo[2] & " not exist" & @CRLF & @CRLF, 1)

		EndIf

	Next

	GUICtrlSetData($Edit1, "######### Start Search Prx Files #########" & @CRLF & @CRLF, 1)

	;RunWait(@ComSpec & " /C " & "python dirstr.py",'',@SW_SHOW,BitOR($STDERR_CHILD, $STDOUT_CHILD)) ; write ps4 folder structure.... next maybe

EndFunc   ;==>Find_Prx


; Unfself_Prx() 6

Func Unfself_Prx()

	Local $Arr_prx = _FileListToArrayRec($f_prxmod, "*.prx", 1, 1, 0, 2)

	For $x = 1 To UBound($Arr_prx) - 1

		Local $runUnfself = Run(@ComSpec & " /c " & $unfself & " <nul " & '"' & $Arr_prx[$x] & '"', '', @SW_HIDE, $STDERR_MERGED + $STDIN_CHILD)

		Run_Output($runUnfself, "Run Unfself Prx")

		ConsoleWrite(@ComSpec & " /c " & $unfself & " " & '"' & $Arr_prx[$x] & '"')

		If FileExists($Arr_prx[$x]) Then
			FileDelete($Arr_prx[$x])
		EndIf

	Next

EndFunc   ;==>Unfself_Prx


;Donwgrade_Prx()

Func Donwgrade_Prx()

	Local $Arr_dprx = _FileListToArrayRec($f_prxmod, "*.prx-decrypted", 1, 1, 0, 2)


	For $y = 1 To UBound($Arr_dprx) - 1

		Local $runElf = Run(@ComSpec & " /c " & "python " & '"' & $elf_py & '"' & " --sdk-version 05.050.001 --verbose " & '"' & $Arr_dprx[$y] & '"' & " " & '"' & StringReplace($Arr_dprx[$y], "-decrypted", "") & '"', '', @SW_HIDE, $STDERR_MERGED + $STDIN_CHILD)
		ConsoleWrite(@ComSpec & " /c " & "python " & '"' & $elf_py & '"' & " --sdk-version 05.050.001 --verbose " & '"' & $Arr_dprx[$y] & '"' & " " & '"' & StringReplace($Arr_dprx[$y], "-decrypted", "") & '"' & @CRLF)

		Run_Output($runElf, "Donwgrade Prx")

		If FileExists($Arr_dprx[$y]) Then
			FileDelete($Arr_dprx[$y])
		EndIf

	Next


EndFunc   ;==>Donwgrade_Prx


; Copy_Decrypted_Prx() 8

Func Copy_Decrypted_Prx()

	$dest_prx = StringReplace(IniRead($cfg_ini, "PATH", "output_pkg", ""), @ScriptDir, "")

	$xcopy = Run(@ComSpec & " /C xcopy " & '"' & $f_prxmod & $dest_prx & '" "' & '"' & $f_working & '"' & '" /Y /H /E /C', '', @SW_HIDE, $STDERR_MERGED + $STDIN_CHILD)
	ConsoleWrite(@ComSpec & " /C " & "xcopy " & '"' & $f_prxmod & $dest_prx & '" "' & $f_working & '" /Y /H /E /C' & @CRLF)

	Run_Output($xcopy, "Copy Prx Modded")

EndFunc   ;==>Copy_Decrypted_Prx


; Img_Create() 9 Build all .gp4 image present in the folder

Func Img_Create()

	$gp4 = _FileListToArray($f_working, "*.gp4", 1, 1)

	For $g = 1 To UBound($gp4) - 1

		Local $runOrbis = Run($orbis & " img_create --oformat pkg " & '"' & $gp4[$g] & '"' & ' ' & '"' & $f_patch & '"', '', @SW_HIDE, $STDOUT_CHILD)

		ConsoleWrite($orbis & " img_create --oformat pkg " & '"' & $gp4[$g] & '"' & ' ' & '"' & $f_patch & '"' & @CRLF)

		Run_Output($runOrbis, "ReBuild Pkg")

		ShellExecute($f_patch)

	Next

EndFunc   ;==>Img_Create


Func EraseAll()

	DirRemove($f_unpack, 1)
	DirRemove($f_working, 1)
	DirRemove($f_decrypt, 1)
	DirRemove($f_prxmod, 1)
	DirRemove($f_patch, 1)

EndFunc   ;==>EraseAll


Func Get_ID_GAME($PkgPath, $iOffset, $iLen = 1)

	Local $Id = ""
	Local $hFile = FileOpen($PkgPath, $FO_BINARY)
	FileSetPos($hFile, $iOffset, $FILE_BEGIN)
	$Id = FileRead($hFile, $iLen)
	FileClose($hFile)
	Return $Id

EndFunc   ;==>Get_ID_GAME


; Grab output from process
; Run_Output($job)

Func Run_Output($proc, $name_p)

	Dim $_StderrRead = '', $_StdoutRead = '', $_StdReadAll = ''

	GUICtrlSetData($Edit1, "######### " & $name_p & " Process Start... " & "#########" & @CRLF & @CRLF, 1)

	While ProcessExists($proc)

		$_StdoutRead = StderrRead($proc)

		If $_StdoutRead <> '' Then
			ConsoleWrite($_StdoutRead)
			GUICtrlSetData($Edit1, $_StdoutRead, 1)
			_GUICtrlEdit_SetLimitText($Edit1, 200000)
		EndIf

		$_StderrRead = StdoutRead($proc)

		If $_StderrRead <> '' Then
			ConsoleWrite($_StderrRead)
			GUICtrlSetData($Edit1, $_StderrRead, 1)
			_GUICtrlEdit_SetLimitText($Edit1, 200000)
		EndIf

		$_StdReadAll = $_StdReadAll & $_StderrRead & $_StdoutRead

	WEnd

	ProcessClose($proc)

	GUICtrlSetData($Edit1, @CRLF & @CRLF & "######### " & $name_p & " Process Complete " & "#########" & @CRLF & @CRLF, 1)

	FileWrite($fl_log, $_StdReadAll)

EndFunc   ;==>Run_Output
