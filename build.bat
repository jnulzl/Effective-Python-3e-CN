@echo off
REM =============================================================
REM  Effective Python, 3e (Brett Slatkin) - Chinese edition
REM  One-click build script (Windows)
REM
REM  Requires: TeX Live 2026 (bundles latexminted 0.7+) + Python 3
REM  Usage    : double-click this file, or run  build.bat
REM =============================================================
setlocal EnableExtensions

set TEXBIN=D:\ProgramData\texlive\2026\bin\windows
set PYTHON=D:\anaconda3

set "PATH=%PYTHON%;%TEXBIN%;%PATH%"
set "PYTHONPATH="

REM  minted v3 needs an ABSOLUTE cache dir (see ccs.tex).
for %%A in ("%~dp0.") do set "TEXMF_OUTPUT_DIRECTORY=%%~fA"
set "TEXMFOUTPUT=%TEXMF_OUTPUT_DIRECTORY%"
echo [build] project root = %TEXMF_OUTPUT_DIRECTORY%
cd /d "%~dp0."

xelatex -shell-escape -interaction=nonstopmode -synctex=1 main.tex
if errorlevel 1 goto :err
xelatex -shell-escape -interaction=nonstopmode -synctex=1 main.tex
if errorlevel 1 goto :err
xelatex -shell-escape -interaction=nonstopmode -synctex=1 main.tex
if errorlevel 1 goto :err

findstr /C:"Cannot write file" /C:"Cannot highlight code" main.log >nul 2>&1
if not errorlevel 1 (
  echo.
  echo [WARN] minted highlight failures still present in main.log.
  goto :err
)

echo.
echo [cleanup] removing *.minted / *.listing ...
for %%F in ("%CD%\*.minted") do @del /q "%%~fF" 2>nul
for %%F in ("%CD%\*.listing") do @del /q "%%~fF" 2>nul

echo.
echo Build finished. Output: main.pdf
goto :eof

:err
echo.
echo Build FAILED. See main.log in this directory.
pause
