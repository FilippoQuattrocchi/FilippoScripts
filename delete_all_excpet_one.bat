#Delete all files from a folder and exclude a folder
SETLOCAL
SET "sourcedir=C:\Users\Filippo\Desktop\Cartella prova"
SET "keepfile=1.bat"
SET "keepdir=io_rimango"

FOR /d %%a IN ("%sourcedir%\*") DO IF /i NOT "%%~nxa"=="%keepdir%" RD /S /Q "%%a"
FOR %%a IN ("%sourcedir%\*") DO IF /i NOT "%%~nxa"=="%keepfile%" DEL "%%a"

GOTO :EOF