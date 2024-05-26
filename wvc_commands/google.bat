:: Google search

set "wvc_subject=!wvc_subject:"=%%22!"
set "wvc_subject=!wvc_subject:&=%%26!"

set "wvc_query="
for %%a in (%wvc_subject%) do (
  if defined wvc_query (
      set "wvc_query=!wvc_query!+%%a"
  ) else (
      set "wvc_query=%%a"
  )
)
set "wvc_google=http://www.google.com/search?q=!wvc_query!"
echo !wvc_google!
start "" "!wvc_google!"