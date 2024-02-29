@echo off
echo *** Finding DateStamp YYYYMMDD

REM *** 
REM *** Echo date to null.  If we can't find the date, error out and exit, else parse the date
REM ***

echo. | date | FIND "(mm" > NUL
If errorlevel 1,(call :Parsedate DD MM) Else,(call :Parsedate MM DD)
goto :ScriptDone

:Parsedate ----------------------------------------------------------

REM ***
REM *** parse the date, set date to "DateStamp", in the format YYYYMMDD
REM ***

For /F "tokens=1-4 delims=/.- " %%A in ('date /T') do if %%D!==! (set %1=%%A&set %2=%%B&set YYYY=%%C) else (set DOW=%%A&set %1=%%B&set %2=%%C&set YYYY=%%D)
(Set DateStamp=%YYYY%%MM%%DD%)

REM ***
REM *** Inform user and start copy process
REM ***

echo *** Datestamp:%DateStamp%
echo *** Making directory, if doesn't exist
mkdir k:\backup\%DateStamp%-webroot
echo *** Beginnning filecopy
copy c:\myfile.txt k:\backup\%DateStamp%_myfile.txt

:ScriptDone
