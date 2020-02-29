@echo off
7z.exe %4 -y %1 %2 >%3
exit %ERRORLEVEL%
