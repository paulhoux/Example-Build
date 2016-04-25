@echo off
@setlocal

set config=Release

rem prevent an error only present on HP computers
set Platform=
set platformcode=

:permissions
rem check admin permissions
net session >nul 2>&1
if not errorlevel 1 goto environment
echo Run this script as administrator.
goto done 

:environment
rem set to current directory
setlocal enableextensions
cd /d "%~dp0"

rem enable Visual Studio 2015 environment
call "C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat" x86

:submodules
echo Step 1: Updating Git submodules...
git submodule update --init --recursive
if errorlevel 1 goto error
echo Done.
goto clean

:clean
git diff-index --quiet HEAD --
if not errorlevel 1 goto cinder
echo Your working directory is not clean. Please commit all changes first.
goto done

:cinder
echo.
echo Step 2: Compiling cinder...
msbuild ".\cinder\vc2013\cinder.sln" /m /p:Configuration=%config%
if errorlevel 1 goto error
echo Done.
goto application

:application
echo.
echo Step 3: Compiling source...
msbuild ".\application\vc2013\Example.sln" /m /p:Configuration=%config%
if errorlevel 1 goto error
echo Done.
goto installer

:installer
echo.
echo Step 4: Compiling installer...
rem Update git revision.
git log "--pretty=format:#define MyAppRevision ""%%H""" -n 1 > .\installer\revision.h
git log "--pretty=format:%%at" -n 1 > .\installer\timestamp.txt
rem Compile installer.
"C:\Program Files (x86)\Inno Setup 5\ISCC.exe" .\installer\setup.iss
if errorlevel 1 goto error
echo Done.
goto done

:error
echo An error occurred. See README.md for more information.

:done
echo.
pause