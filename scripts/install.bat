set ArduinoLibraryPath=%USERPROFILE%\Documents\Arduino\libraries

echo Input Arduino Library Path. Default: "%ArduinoLibraryPath%"
set /P "ArduinoLibraryPath="

set SimpitRefactoredArduinoTargetPath="%ArduinoLibraryPath%\SimpitRefactored-Arduino"
set KerbalSimpitRefactoredArduinoTargetPath="%ArduinoLibraryPath%\KerbalSimpitRefactored-Arduino"

CALL :NORMALIZEPATH "%~dp0\..\libraries\SimpitRefactored-Arduino"
SET SimpitRefactoredArduinoSourcePath="%RETVAL%"

CALL :NORMALIZEPATH "%~dp0\.."
SET KerbalSimpitRefactoredArduinoSourcePath="%RETVAL%"

if not exist %ArduinoLibraryPath% (
    echo Creating Arduino Library Directory at %ArduinoLibraryPath%
    mkdir %ArduinoLibraryPath%
)

if exist %SimpitRefactoredArduinoTargetPath% (
    echo Removing existing SimpitRefactoredArduino instace at %SimpitRefactoredArduinoTargetPath%
    rmdir %SimpitRefactoredArduinoTargetPath%
)

mklink /J %SimpitRefactoredArduinoTargetPath% %SimpitRefactoredArduinoSourcePath%

if exist %KerbalSimpitRefactoredArduinoTargetPath% (
    echo Removing existing SimpitRefactoredArduino instace at %KerbalSimpitRefactoredArduinoTargetPath%
    rmdir %KerbalSimpitRefactoredArduinoTargetPath%
)

mklink /J %KerbalSimpitRefactoredArduinoTargetPath% %KerbalSimpitRefactoredArduinoSourcePath%

GOTO :END
echo Warning: Running function code

:NORMALIZEPATH
  SET RETVAL=%~f1
  EXIT /B

:END
echo Done!
timeout /t 10