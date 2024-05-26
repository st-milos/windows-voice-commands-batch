@echo off
setlocal EnableDelayedExpansion

call .\wvc_config.bat

:: Speech to text

start /wait "" "ffmpeg" -f dshow -y -i audio="%wvc_recording_device%" -t %wvc_recording_seconds% wvc.m4a
start /wait "" "whisper" .\wvc.m4a --model %wvc_whisper_model% --language %wvc_whisper_language% --suppress_tokens=0,11,13,30 --output_format txt %wvc_whisper_options%
set /p wvc_command=< wvc.txt
echo %wvc_command%

:: Cleanup

if exist "wvc.txt" del "wvc.txt"
if exist "wvc.m4a" del "wvc.m4a"

:: Parse

for %%i in (%wvc_command%) do (
  set wvc_action=%%i
  goto parsed
)
:parsed
set "wvc_action=%wvc_action:.=%"
for /f "tokens=1,*" %%a in ("%wvc_command%") do set wvc_subject=%%b
echo %wvc_action%
echo %wvc_subject%

:: Call command script

call .\wvc_commands\%wvc_action%

:: Uncomment to debug: pause

