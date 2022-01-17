@echo off
REM Ensure that current directory is the location of this batch file.
set mypath=%~dp0
for /f %%i in ('cd') do set curdir=%%i
cd %mypath%
echo %curdir%
(
REM Configure the instance generation code
if exist .\InstanceGeneration\configure.bat (
    echo Configuring instance generation submodule
    .\InstanceGeneration\configure.bat %curdir%\Utilities
) else (
    echo Instance generation submodule not present
)

REM Configure the feature measuring code
if exist .\Features\configure.bat (
    echo Configuring feature measuring submodule
    .\Features\configure.bat %curdir%\Utilities %curdir%\Instances
) else (
    echo Feature measuring submodule not present
)

REM Configure the genetic instance generation code
if exist .\InstanceGenerationGenetic\configure.bat (
    echo Configuring instance generation submodule
    .\InstanceGenerationGenetic\configure.bat %curdir%\Utilities %curdir%\Features
) else (
    echo Instance generation submodule not present
)

REM make algorithm data folder
if not exist .\AlgorithmData (
    echo Creating algorithm data directory .\AlgorithmData
    mkdir .\AlgorithmData
)

cd %curdir%
)