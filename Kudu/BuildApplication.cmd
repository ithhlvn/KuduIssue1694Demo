@if "%SCM_TRACE_LEVEL%" NEQ "4" @echo off

if "%1"=="" (
	echo Usage: BuildApplication ^<relative path to project folder^> ^<.csproj file^>
	goto exit
)

if "%2"=="" (
	echo Usage: BuildApplication ^<relative path to project folder^> ^<.csproj file^>
	goto exit
)

echo.
echo ------------------------------------------------------
echo Building %1%2
echo ------------------------------------------------------
echo.

IF /I "%IN_PLACE_DEPLOYMENT%" NEQ "1" (
  "%MSBUILD_PATH%" "%1%2" /nologo /verbosity:n /t:Build /t:pipelinePreDeployCopyAllFilesToOneFolder /p:_PackageTempDir="%DEPLOYMENT_TEMP%";AutoParameterizationWebConfigConnectionStrings=false;Configuration=Release /p:SolutionDir="%DEPLOYMENT_SOURCE%\.\\" %SCM_BUILD_ARGS%
) ELSE (
  "%MSBUILD_PATH%" "%1%2" /nologo /verbosity:n /t:Build /p:AutoParameterizationWebConfigConnectionStrings=false;Configuration=Release /p:SolutionDir="%DEPLOYMENT_SOURCE%\.\\" %SCM_BUILD_ARGS%
)

:exit
exit /b %ERRORLEVEL%