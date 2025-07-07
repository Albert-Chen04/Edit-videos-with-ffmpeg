@echo off
REM 将当前代码页更改为UTF-8 (65001)，以正确处理中文和特殊字符文件名
chcp 65001 >nul

setlocal enabledelayedexpansion

REM ====== 用户设置区域 ======
REM !!! 请确保下面的输入文件路径和输出目录路径是正确的 !!!
set "input_file=E:\48tool\pocket48\pocket48-live-broadcast-replay\20250703\B站\[口袋48录播]_CGT48-谭思慧_☁️_2025-07-03~23.45.28_1147678717646802944__2025-07-05~07.33.39_chatbox_hardsub_final.mp4"
set "output_dir=E:\48tool\pocket48\pocket48cut\20250703\B站视频"

REM ====== 结束设置区域 ======


REM 创建输出目录
if not exist "%output_dir%" (
    echo 创建目录: %output_dir%
    mkdir "%output_dir%"
)

REM 定义裁剪列表 (格式: "名称 开始时间 时长")
REM 时间格式为 HH:MM:SS (时:分:秒)
set "clips[0]=大人中 00:07:10 00:05:13"
set "clips[1]=千年 00:17:15 00:04:20"
set "clips[2]=踮起脚尖爱 00:22:20 00:04:32"
set "clips[3]=苏州河 00:27:55 00:04:17"
set "clips[4]=最佳损友 00:43:40 00:04:15"
set "clips[5]=喜帖街 00:48:04 00:00:36"
set "clips[6]=银河 00:52:30 00:05:00"
set "clips[7]=因为我爱你 00:59:15 00:04:58"
set "clips[8]=关不上的窗 01:13:20 00:03:34"
set "clips[9]=对手 01:17:51 00:04:14"
set "clips[10]=小英雄大肚腩 01:22:55 00:03:00"
set "clips[11]=我 01:27:00 00:04:15"
set "clips[12]=宝宝巴士 01:32:20 00:02:20"
set "clips[13]=听到请回答 01:44:20 00:03:30"
set "clips[14]=黄昏 01:49:55 00:05:02"
set "clips[15]=用背脊唱情歌 01:57:45 00:03:50"
set "clips[16]=致明天 02:02:20 00:03:50"

echo 开始剪辑视频片段...
echo.

REM 循环处理每个片段 (共17个片段, 索引从0到16)
for /l %%i in (0,1,16) do (
    for /f "tokens=1-3" %%a in ("!clips[%%i]!") do (
        set "name=%%a"
        set "start=%%b"
        set "duration=%%c"
        
        echo 正在处理: !name! (!start! 开始，持续 !duration!)
        
        REM 使用-nostdin防止ffmpeg干扰批处理的输入
        REM 使用-y参数自动覆盖同名文件，避免中途暂停
        REM -ss [开始时间] -t [持续时长]
        ffmpeg -nostdin -ss !start! -i "%input_file%" -t !duration! -c copy -y "%output_dir%\!name!.mp4"
        if errorlevel 1 (
            echo 错误: 剪辑 !name! 失败
        ) else (
            echo 成功: !name! 已保存
        )
        echo.
    )
)

echo 所有视频片段已剪辑完成!
echo 保存位置: %output_dir%
echo.
pause
endlocal