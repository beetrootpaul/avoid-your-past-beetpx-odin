@echo off
setlocal

rem Runs the BeetPx CLI, e.g. `scripts\beetpx.bat run js_wasm32`. See
rem `..\beetpx-odin\beetpx\cli\main.odin` for the available commands.
rem
rem The Windows twin of `beetpx.sh`. See there for the reasons behind the flags.

cd /d "%~dp0.."

if not exist build mkdir build
odin run ..\beetpx-odin\beetpx\cli -out:build\beetpx_cli.exe -thread-count:1 -- %*
exit /b %errorlevel%
