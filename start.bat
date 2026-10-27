@echo off
chcp 65001 >nul
cd /d "%~dp0"
echo.
echo   初中单词 · 散步听
echo   正在启动本地服务，浏览器会自动打开
echo   关闭此窗口即可停止
echo.
start "" http://localhost:8765/index.html
python -m http.server 8765
pause
