@echo off
chcp 65001 >nul
title 初中英语散步听 - 本地版
cd /d "%~dp0"

set "PORT=8765"
set "URL=http://127.0.0.1:%PORT%/"
set "PY="

netstat -ano | findstr ":%PORT%" | findstr LISTENING >nul
if not errorlevel 1 goto :open

echo 正在启动本地服务...

where python >nul 2>nul && set "PY=python"
if not defined PY (where py >nul 2>nul && set "PY=py -3")
if not defined PY if exist "%USERPROFILE%\.workbuddy\binaries\python\versions\3.13.12\python.exe" set "PY=%USERPROFILE%\.workbuddy\binaries\python\versions\3.13.12\python.exe"

if defined PY (
  start "walkpod-server" /min %PY% -m http.server %PORT% --bind 127.0.0.1
  ping -n 4 127.0.0.1 >nul
  netstat -ano | findstr ":%PORT%" | findstr LISTENING >nul
  if not errorlevel 1 goto :open
)

echo 未能启动本地服务，改为直接打开单文件版（功能基本相同）
goto :openfile

:open
echo 正在打开 %URL%
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
  start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" "%URL%"
) else if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" (
  start "" "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" "%URL%"
) else if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
  start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" "%URL%"
) else (
  start "" "%URL%"
)
exit

:openfile
echo 正在打开单文件版 podcast.html
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" (
  start "" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" "%~dp0podcast.html"
) else if exist "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" (
  start "" "%ProgramFiles(x86)%\Microsoft\Edge\Application\msedge.exe" "%~dp0podcast.html"
) else (
  start "" "%~dp0podcast.html"
)
exit
