@echo off
setlocal

set "github_zip_url=https://codeload.github.com/najmiter/neutrabize/zip/refs/heads/main"

set "download_dir=C:\neutrabize_temp"

set "neutrabize=C:\neutrabize"

if not exist "%neutrabize%" mkdir "%neutrabize%"

if exist "%neutrabize%" (
    del /q "%neutrabize%\*"
)

if not exist "%download_dir%" mkdir "%download_dir%"

echo Downloading the latest 'neutrabize' source code...
powershell -command "(New-Object Net.WebClient).DownloadFile('%github_zip_url%', '%download_dir%\neutrabize.zip')"

if not exist "%download_dir%\neutrabize.zip" (
    echo Failed to download the source code. Exiting.
    exit /b 1
)

echo Extracting source code...
powershell -command "Expand-Archive -Path '%download_dir%\neutrabize.zip' -DestinationPath '%download_dir%'"

echo Moving source code to current directory...
xcopy /s /y "%download_dir%\neutrabize-main\*" "%neutrabize%"

del /q "%download_dir%\neutrabize.zip"
rmdir /s /q "%download_dir%\neutrabize-main"
rmdir /s /q "%download_dir%"

echo The latest 'neutrabize' has been successfully installed.

pause
exit /b 0
