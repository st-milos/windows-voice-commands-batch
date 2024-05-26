set "wvc_subject=%wvc_subject:.=%"
:: Remove a article
set wvc_subject=%wvc_subject:a = % 
echo "%wvc_subject%"
for %%i in (%wvc_subject%) do (
  set wvc_program_name=%%i
  goto programparsed
)
:programparsed

set "firstChar=!wvc_program_name:~0,1!"
set "restoftext=!wvc_program_name:~1!"
set "firstLower=!firstChar:A=a!"
set "wvc_program_name=!firstLower!!restoftext!"

set "wvc_program_args="
for /f "tokens=1,*" %%a in ("%wvc_subject%") do set wvc_program_args=%%b
echo -- !wvc_program_name!
if "!wvc_program_name!" == "notepad" (
  start "" notepad.exe !wvc_program_args!
) else (
  REM add specific paths to programs you need in else ifs above
  echo Unknown program !wvc_program_name!
)
REM start "" ".\!wvc_program_name!" !wvc_program_args!