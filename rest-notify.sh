#!/bin/bash
notify-send "休息提醒脚本执行成功" -i "/home/endercaster/workspace/waiting/favicon.ico"
declare -i count
count=10
declare -i now
declare -i aim
aim=1548950400 # 2018 12 31
aim=${aim}/60 # 精确到分钟
declare -i remaining
declare -i r_h
declare -i r_m
while [[ $count -ne 0 ]]
do
    sleep 2700
    notify-send "滚出去活动" "离开电子屏幕" -i "/home/endercaster/wo{rkspace/waiting/favicon.ico"
    sleep 600
    rest_msg="大脑还没活过来的话先去吸一口"

    now=$(date +%s)
    now=${now}/60
    if [[ ${aim} -gt ${now} ]]
    then
        remaining=${aim}-${now}
        r_h=${remaining}/60
        r_m=${remaining}%60
        rest_msg="你还有${r_h}小时${r_m}分"
    fi
    notify-send "回来写代码" ${rest_msg} -i "/home/endercaster/workspace/waiting/favicon.ico"
done
