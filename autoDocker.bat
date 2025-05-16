@echo off
REM Warning message
echo Are you sure? This is going to obliterate all your dockers (containers, volumes, images)...
echo _______________________________^^^^^^^^^^__________________________________________________
echo.

REM Yep confirmation "yep"
set /p CONFIRM="Type 'yep' and ENTER to continue: "

if /I "%CONFIRM%"=="yep" (
    echo Confirmado. Ejecutando limpieza y reconstrucción...
    echo.
    REM Obliteration
    docker system prune -a --volumes

    REM Docker build
    docker compose build

    REM Docker run
    docker compose run --rm rpi_imagegen
) else (
    echo.
    echo Exited.
)

pause
