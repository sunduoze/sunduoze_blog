@echo off
xcopy %cd%\content\*.* %cd%\public\content\ /s /e /c /y
copy %cd%\CNAME %cd%\public\ 
copy %cd%\readme.md %cd%\public\ 
pause
