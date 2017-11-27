@ECHO OFF
REM Generates the standard-definition resolution images of their high-definition counterparts (@2x suffix).

REM This script may not work if this file tree is not preserved.
CD /D %~dp0..\..

FOR /R %cd% %%f IN (*@2x.png) DO (
    CALL :waifu2x %%~dpf %%~nxf
)

ECHO Finished.

:waifu2x
SET filePath=%1
SET fileName=%2
SET newName=%fileName:@2x=%
IF NOT EXIST %filePath%%newName% (
    IF [%filePath%%fileName%]==[] EXIT /B
    ECHO Downscaling: %filePath%%fileName%
    REM Set --tta 1 and --output_depth 16 for optimal image quality.
    REM Decrease batch_size and crop_size if you have inadequate RAM (currently using up to 6 GB RAM).
    REM --model_dir is essential to processing speed.
    %~dp0waifu2x-caffe\waifu2x-caffe-cui.exe ^
        --tta 0 ^
        --batch_size 16 ^
        --crop_size 256 ^
        --output_depth 8 ^
        --process cpu ^
        --model_dir %~dp0waifu2x-caffe\models\anime_style_art_rgb ^
        --scale_ratio 0.5 ^
        --noise_level 2 ^
        --mode noise_scale ^
        --output_path %filePath%%newName% ^
        --input_path %filePath%%filename%
) ELSE (
    ECHO Already exists: %filePath%%newName%
)
ECHO.
