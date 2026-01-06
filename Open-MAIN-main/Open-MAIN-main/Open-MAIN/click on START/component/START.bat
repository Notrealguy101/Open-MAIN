@echo off

:menu
cls
echo Zvolte co chcete ODSTRANIT!
echo.
echo 1 = Boot Menu
echo 2 = Hlavni Disk (C:/)
echo 3 = Zpet
echo.

choice /c 123 /n /m "Vyberte 1, 2 nebo 3: "

if errorlevel 3 goto exit_script
if errorlevel 2 goto run2
if errorlevel 1 goto run1

:run1
rem Spusti delete-boot menu.bat ze stejne slozky jako tento soubor
pushd "%~dp0"
call "delete-boot menu.bat"
popd
goto menu

:run2
rem Spusti delete C.bat ze stejne slozky jako tento soubor
pushd "%~dp0"
call "delete C.bat"
popd
goto menu

:exit_script
exit /b 0
