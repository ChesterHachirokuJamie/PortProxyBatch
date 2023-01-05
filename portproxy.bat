:loop
@echo off & color 9F
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit
cd /d "%~dp0"
cd %WINDIR%\System32
echo. ==========================
echo. 1 = Show Current PortProxy Config
echo. 2 = Add Portproxy Config, TCP only
echo. 3 = Delete Portproxy Config
echo. ===========================
set /p InitialChoice=Enter a Num, Press "Q" to exit:

if "%InitialChoice%"=="1" goto :1
if "%InitialChoice%"=="2" goto :2
if "%InitialChoice%"=="3" goto :3
if /i "%InitialChoice%"=="q" goto :EOF

color 84
cls
echo Wrong Input!
echo Please Retry!
ping -n 3 127.0>nul
cls
goto :loop

:1
netsh interface portproxy show all
echo Press ANY key to exit
pause
goto :EOF

:2
echo IP Protocol; Listen IP; Listen Port; Connect IP; Connect Port?
set /p v4ORv6=v4tov4, v4tov6, v6tov4, v6tov6:
set /p ListenIP=Enter an IP to listen:
set /p ListenPort=Enter a port to listen:
set /p ConnectIP=Enter an IP to connect:
set /p ConnectPort=Enter a port to connect:
netsh interface portproxy add "%v4ORv6%" listenaddress="%ListenIP%" listenport="%ListenPort%" connectaddress="%ConnectIP%" connectport="%ConnectPort%"
echo Results & netsh interface portproxy show all
CHOICE /C YN /M "Press Y to add more, N to quit"
if not errorlevel 2 if errorlevel 1 goto :2
goto :EOF


:3
netsh interface portproxy show all
echo Remove: IP Protocol; Listen IP; Listen Port; Connect IP; Connect Port?
set /p v4ORv6=v4tov4, v4tov6, v6tov4, v6tov6:
set /p ListenIP=Enter a Listened IP to remove:
set /p ListenPort=Enter a Listened port to remove:
set /p ConnectIP=Enter a connected IP to remove:
set /p ConnectPort=Enter a connected port to remove:
netsh interface portproxy delete "%v4ORv6%" listenaddress="%ListenIP%" listenport="%ListenPort%" connectaddress="%ConnectIP%" connectport="%ConnectPort%"
echo Results & netsh interface portproxy show all
CHOICE /C YN /M "Press Y to delete more, N to quit"
if not errorlevel 2 if errorlevel 1 goto :3
goto :EOF
