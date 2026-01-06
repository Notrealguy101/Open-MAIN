@echo off
REM -----------------------------
REM spust_vbs.bat
REM Spousti VBS soubor s elevaci (UAC) a zobrazi chyby pres cscript
REM -----------------------------

:: Kontrola administrátorských práv
net session >nul 2>&1
if %errorlevel% NEQ 0 (
    echo Neni spusten jako administrator. Restartuji s UAC...
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:: Cesta k VBS souboru ve stejne slozce jako tento .bat
set "VBS_PATH=%~dp0password2.vbs"

:: Kontrola existence souboru
if not exist "%VBS_PATH%" (
    echo Soubor nenalezen: %VBS_PATH%
    pause
    exit /b
)

:: Spusteni VBS v konzoli (zobrazi chyby a vypisy)
echo Spoustim VBS pres cscript: "%VBS_PATH%"
cscript //nologo "%VBS_PATH%"

:: Pokud chces otevrit VBS bez konzole (GUI) odkomentuj radek nize a zakomentuj predchozi cscript:
:: start "" "%VBS_PATH%"

echo.
echo Hotovo.
pause
