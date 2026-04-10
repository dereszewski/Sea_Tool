@echo off
setlocal EnableDelayedExpansion

title Sea_Tool
color 0F

:: Enable ANSI virtual terminal for color text
reg add HKCU\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

:MAIN_MENU
cls
echo.
echo  ============================================================
echo.
powershell -Command "Write-Host '   ____               _____           _               ' -ForegroundColor Cyan"
powershell -Command "Write-Host '  / ___|  ___  __ _  |_   _|__   ___ | |              ' -ForegroundColor Cyan"
powershell -Command "Write-Host '  \___ \ / _ \/ _` |   | |/ _ \ / _ \| |              ' -ForegroundColor Cyan"
powershell -Command "Write-Host '   ___) |  __/ (_| |   | | (_) | (_) | |              ' -ForegroundColor Cyan"
powershell -Command "Write-Host '  |____/ \___|\__,_|___|_|\___/ \___/|_|              ' -ForegroundColor Cyan"
powershell -Command "Write-Host '                  |_____|                              ' -ForegroundColor Cyan"
echo.
echo  ============================================================
echo              Sea_Tool  v1.0  ^|  Windows Utility
echo  ============================================================
echo.
echo    [1]  System Information
echo    [2]  Network Tools
echo    [3]  Disk Utilities
echo    [4]  Process Manager
echo    [5]  Windows Activation Check
echo    [6]  Repair Tools
echo    [7]  Privacy ^& Cleanup
echo    [0]  Exit
echo.
echo  ============================================================
echo.
set "CHOICE="
set /p "CHOICE=   ^> Select an option: "

if "%CHOICE%"=="1" goto SYSINFO
if "%CHOICE%"=="2" goto NETWORK
if "%CHOICE%"=="3" goto DISK
if "%CHOICE%"=="4" goto PROCS
if "%CHOICE%"=="5" goto ACTCHECK
if "%CHOICE%"=="6" goto REPAIR
if "%CHOICE%"=="7" goto PRIVACY
if "%CHOICE%"=="0" goto EXIT_TOOL
goto MAIN_MENU

:: ============================================================
::  [1] SYSTEM INFORMATION
:: ============================================================
:SYSINFO
cls
echo.
echo  ============================================================
echo    Sea_Tool  ^>  System Information
echo  ============================================================
echo.
echo  Gathering info, please wait...
echo.
echo  ---- [ OS ] -------------------------------------------------
for /f "tokens=2 delims==" %%i in ('wmic os get Caption /value 2^>nul') do echo    OS        : %%i
for /f "tokens=2 delims==" %%i in ('wmic os get Version /value 2^>nul') do echo    Version   : %%i
for /f "tokens=2 delims==" %%i in ('wmic os get BuildNumber /value 2^>nul') do echo    Build     : %%i
for /f "tokens=2 delims==" %%i in ('wmic os get OSArchitecture /value 2^>nul') do echo    Arch      : %%i
for /f "tokens=2 delims==" %%i in ('wmic os get LastBootUpTime /value 2^>nul') do echo    Last Boot : %%i
echo.
echo  ---- [ Hardware ] -------------------------------------------
for /f "tokens=2 delims==" %%i in ('wmic cpu get Name /value 2^>nul') do echo    CPU       : %%i
for /f "tokens=2 delims==" %%i in ('wmic cpu get NumberOfCores /value 2^>nul') do echo    Cores     : %%i
for /f "tokens=2 delims==" %%i in ('wmic cpu get MaxClockSpeed /value 2^>nul') do echo    Speed     : %%i MHz
for /f "tokens=2 delims==" %%i in ('wmic os get TotalVisibleMemorySize /value 2^>nul') do set /a RAMMB=%%i/1024 & echo    RAM Total : !RAMMB! MB
for /f "tokens=2 delims==" %%i in ('wmic os get FreePhysicalMemory /value 2^>nul') do set /a FREEMB=%%i/1024 & echo    RAM Free  : !FREEMB! MB
for /f "tokens=2 delims==" %%i in ('wmic path Win32_VideoController get Name /value 2^>nul') do echo    GPU       : %%i
echo.
echo  ---- [ Identity ] -------------------------------------------
for /f "tokens=2 delims==" %%i in ('wmic computersystem get Name /value 2^>nul') do echo    Hostname  : %%i
for /f "tokens=2 delims==" %%i in ('wmic computersystem get UserName /value 2^>nul') do echo    User      : %%i
for /f "tokens=2 delims==" %%i in ('wmic bios get SerialNumber /value 2^>nul') do echo    Serial    : %%i
echo.
echo  ============================================================
echo.
pause
goto MAIN_MENU

:: ============================================================
::  [2] NETWORK TOOLS
:: ============================================================
:NETWORK
cls
echo.
echo  ============================================================
echo    Sea_Tool  ^>  Network Tools
echo  ============================================================
echo.
echo    [1]  Show IP Configuration
echo    [2]  Ping Test  (google.com)
echo    [3]  Traceroute (google.com)
echo    [4]  Flush DNS Cache
echo    [5]  Show Active Connections
echo    [6]  Show Wi-Fi Profiles
echo    [7]  Show Wi-Fi Password (current network)
echo    [8]  Speed Test (via PowerShell)
echo    [B]  Back
echo.
echo  ============================================================
echo.
set "NCHOICE="
set /p "NCHOICE=   ^> Select: "

if /i "%NCHOICE%"=="B" goto MAIN_MENU
if "%NCHOICE%"=="1" (cls & echo. & ipconfig /all & echo. & pause & goto NETWORK)
if "%NCHOICE%"=="2" (cls & echo. & ping google.com -n 4 & echo. & pause & goto NETWORK)
if "%NCHOICE%"=="3" (cls & echo. & tracert google.com & echo. & pause & goto NETWORK)
if "%NCHOICE%"=="4" (cls & echo. & ipconfig /flushdns & echo. & pause & goto NETWORK)
if "%NCHOICE%"=="5" (cls & echo. & netstat -ano & echo. & pause & goto NETWORK)
if "%NCHOICE%"=="6" (cls & echo. & netsh wlan show profiles & echo. & pause & goto NETWORK)
if "%NCHOICE%"=="7" (
    cls & echo.
    set /p "WNAME=   Enter Wi-Fi profile name: "
    netsh wlan show profile name="!WNAME!" key=clear
    echo. & pause & goto NETWORK
)
if "%NCHOICE%"=="8" (
    cls & echo. & echo  Running speed test via PowerShell... & echo.
    powershell -Command "& { $url='http://speedtest.tele2.net/1MB.zip'; $start=[datetime]::Now; Invoke-WebRequest -Uri $url -OutFile $env:TEMP\st_tmp.bin -UseBasicParsing; $end=[datetime]::Now; $secs=($end-$start).TotalSeconds; $mbps=[math]::Round(8/$secs,2); Remove-Item $env:TEMP\st_tmp.bin -Force; Write-Host ('  Download speed ~' + $mbps + ' Mbps (1MB test file)') }"
    echo. & pause & goto NETWORK
)
goto NETWORK

:: ============================================================
::  [3] DISK UTILITIES
:: ============================================================
:DISK
cls
echo.
echo  ============================================================
echo    Sea_Tool  ^>  Disk Utilities
echo  ============================================================
echo.
echo    [1]  Show Disk Space (all drives)
echo    [2]  List All Drives
echo    [3]  Run CHKDSK on C: (read-only)
echo    [4]  Disk Cleanup (C:)
echo    [5]  Open Disk Management
echo    [B]  Back
echo.
echo  ============================================================
echo.
set "DCHOICE="
set /p "DCHOICE=   ^> Select: "

if /i "%DCHOICE%"=="B" goto MAIN_MENU
if "%DCHOICE%"=="1" (cls & echo. & wmic logicaldisk get DeviceID,VolumeName,Size,FreeSpace,FileSystem & echo. & pause & goto DISK)
if "%DCHOICE%"=="2" (cls & echo. & wmic logicaldisk get DeviceID,VolumeName,DriveType & echo. & pause & goto DISK)
if "%DCHOICE%"=="3" (cls & echo. & chkdsk C: & echo. & pause & goto DISK)
if "%DCHOICE%"=="4" (cls & echo. & cleanmgr /d C: & goto DISK)
if "%DCHOICE%"=="5" (start diskmgmt.msc & goto DISK)
goto DISK

:: ============================================================
::  [4] PROCESS MANAGER
:: ============================================================
:PROCS
cls
echo.
echo  ============================================================
echo    Sea_Tool  ^>  Process Manager
echo  ============================================================
echo.
echo    [1]  List All Running Processes
echo    [2]  Kill Process by Name
echo    [3]  Kill Process by PID
echo    [4]  List Services (running)
echo    [5]  Open Task Manager
echo    [B]  Back
echo.
echo  ============================================================
echo.
set "PCHOICE="
set /p "PCHOICE=   ^> Select: "

if /i "%PCHOICE%"=="B" goto MAIN_MENU
if "%PCHOICE%"=="1" (cls & echo. & tasklist & echo. & pause & goto PROCS)
if "%PCHOICE%"=="2" (
    cls & echo.
    set /p "PNAME=   Enter process name (e.g. notepad.exe): "
    taskkill /f /im "!PNAME!" & echo. & pause & goto PROCS
)
if "%PCHOICE%"=="3" (
    cls & echo.
    set /p "PPID=   Enter PID: "
    taskkill /f /pid !PPID! & echo. & pause & goto PROCS
)
if "%PCHOICE%"=="4" (cls & echo. & sc query type= all state= running & echo. & pause & goto PROCS)
if "%PCHOICE%"=="5" (start taskmgr & goto PROCS)
goto PROCS

:: ============================================================
::  [5] WINDOWS ACTIVATION CHECK
:: ============================================================
:ACTCHECK
cls
echo.
echo  ============================================================
echo    Sea_Tool  ^>  Windows Activation Check
echo  ============================================================
echo.
echo  [*] Checking activation status...
echo.
cscript //nologo "%SystemRoot%\system32\slmgr.vbs" /xpr
echo.
echo  [*] License summary:
echo.
cscript //nologo "%SystemRoot%\system32\slmgr.vbs" /dli
echo.
echo  ============================================================
echo.
pause
goto MAIN_MENU

:: ============================================================
::  [6] REPAIR TOOLS
:: ============================================================
:REPAIR
cls
echo.
echo  ============================================================
echo    Sea_Tool  ^>  Repair Tools
echo  ============================================================
echo.
echo    [1]  SFC - System File Checker
echo    [2]  DISM - Restore Health
echo    [3]  Reset Network Stack (Winsock)
echo    [4]  Reset IP / Release + Renew DHCP
echo    [5]  Reset Windows Update Components
echo    [B]  Back
echo.
echo  ============================================================
echo  [!] Run as Administrator for best results.
echo  ============================================================
echo.
set "RCHOICE="
set /p "RCHOICE=   ^> Select: "

if /i "%RCHOICE%"=="B" goto MAIN_MENU
if "%RCHOICE%"=="1" (cls & echo. & sfc /scannow & echo. & pause & goto REPAIR)
if "%RCHOICE%"=="2" (cls & echo. & DISM /Online /Cleanup-Image /RestoreHealth & echo. & pause & goto REPAIR)
if "%RCHOICE%"=="3" (
    cls & echo. & netsh winsock reset & netsh int ip reset
    echo. & echo  Done. Reboot recommended. & echo. & pause & goto REPAIR
)
if "%RCHOICE%"=="4" (cls & echo. & ipconfig /release & ipconfig /renew & echo. & pause & goto REPAIR)
if "%RCHOICE%"=="5" (
    cls & echo. & echo  Resetting Windows Update components... & echo.
    net stop wuauserv >nul 2>&1
    net stop cryptSvc >nul 2>&1
    net stop bits >nul 2>&1
    net stop msiserver >nul 2>&1
    ren "%SystemRoot%\SoftwareDistribution" SoftwareDistribution.old >nul 2>&1
    ren "%SystemRoot%\System32\catroot2" catroot2.old >nul 2>&1
    net start wuauserv >nul 2>&1
    net start cryptSvc >nul 2>&1
    net start bits >nul 2>&1
    net start msiserver >nul 2>&1
    echo  [OK] Windows Update components reset. & echo. & pause & goto REPAIR
)
goto REPAIR

:: ============================================================
::  [7] PRIVACY & CLEANUP
:: ============================================================
:PRIVACY
cls
echo.
echo  ============================================================
echo    Sea_Tool  ^>  Privacy ^& Cleanup
echo  ============================================================
echo.
echo    [1]  Clear Temp Files
echo    [2]  Clear Windows Temp Files
echo    [3]  Clear Prefetch Files
echo    [4]  Clear DNS Cache
echo    [5]  Clear Recent Files List
echo    [6]  Clear Event Logs
echo    [B]  Back
echo.
echo  ============================================================
echo  [!] Run as Administrator for best results.
echo  ============================================================
echo.
set "PVCHOICE="
set /p "PVCHOICE=   ^> Select: "

if /i "%PVCHOICE%"=="B" goto MAIN_MENU
if "%PVCHOICE%"=="1" (cls & echo. & del /f /s /q "%TEMP%\*" >nul 2>&1 & echo  [OK] Temp cleared. & echo. & pause & goto PRIVACY)
if "%PVCHOICE%"=="2" (cls & echo. & del /f /s /q "%SystemRoot%\Temp\*" >nul 2>&1 & echo  [OK] Windows Temp cleared. & echo. & pause & goto PRIVACY)
if "%PVCHOICE%"=="3" (cls & echo. & del /f /s /q "%SystemRoot%\Prefetch\*" >nul 2>&1 & echo  [OK] Prefetch cleared. & echo. & pause & goto PRIVACY)
if "%PVCHOICE%"=="4" (cls & echo. & ipconfig /flushdns & echo. & pause & goto PRIVACY)
if "%PVCHOICE%"=="5" (cls & echo. & del /f /q "%APPDATA%\Microsoft\Windows\Recent\*" >nul 2>&1 & echo  [OK] Recent files cleared. & echo. & pause & goto PRIVACY)
if "%PVCHOICE%"=="6" (
    cls & echo. & echo  Clearing all Event Logs... & echo.
    for /f "tokens=*" %%i in ('wevtutil el') do (wevtutil cl "%%i" >nul 2>&1)
    echo  [OK] Event logs cleared. & echo. & pause & goto PRIVACY
)
goto PRIVACY

:: ============================================================
::  [0] EXIT
:: ============================================================
:EXIT_TOOL
cls
echo.
echo  ============================================================
echo    Thanks for using Sea_Tool. Goodbye!
echo  ============================================================
echo.
timeout /t 2 /nobreak >nul
exit
