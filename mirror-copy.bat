@echo off

SET _SOURCE=%1
SET _DEST=%2

IF "%_SOURCE%" == "" (
	ECHO Please specify source directory. 
	ECHO Usage: mirror-copy.bat source destination. 
	ECHO Exiting with -1...
	EXIT /b -1
)
IF "%_DEST%" == "" (
	ECHO Please specify destination directory. 
	ECHO Usage: mirror-copy.bat source destination. 
	ECHO Exiting with -1...
	EXIT /b -1
)

SET _WHAT=/COPY:DAT /MIR 
:: /COPYALL :: COPY ALL file info
:: /COPY :: The default value for CopyFlags is DAT (data, attributes, and time stamps)
:: /MIR :: MIRror a directory tree - equivalent to /PURGE plus all subfolders (/E)
:: /IS : Include Same, overwrite files even if they are already the same.

SET _OPTIONS=/R:3 /W:5 /NFL /NDL /NP 
:: /R:n :: number of Retries
:: /W:n :: Wait time between retries (seconds)
:: /LOG+:file : Output status to LOG file (append to existing log).
:: /NFL :: No file logging
:: /NDL :: No dir logging
:: /NP :: No Progress - do not display % copied.

ECHO %date% %time% ---------- BEGIN ----------
ECHO Copying from %_SOURCE% to %_DEST% ...

IF EXIST "%_SOURCE%" (
	ROBOCOPY %_SOURCE% %_DEST% %_WHAT% %_OPTIONS%
	:: Any value greater than 7 indicates that there was at least one failure during the copy operation.
	IF %errorlevel% GTR 7 EXIT /b -1
) ELSE (
	ECHO Source directory not found. Copy nothing.
)

ECHO %date% %time% ---------- END ----------

:: EXIT /b %errorlevel%
:: return 0 to Tiger to indicates success since ROBOCOPY
EXIT /b 0
