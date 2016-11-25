#!/bin/sh

serverchan_sckey=`nvram get serverchan_sckey`
cd /tmp/

curl -s "http://api.map.baidu.com/telematics/v3/weather?location=深圳&output=json&ak=6dd11fd43e63dde2abc6bc9564aa37b3" >packet.json
#get sourse data
./json.sh < packet.json | grep -E "weather_data|temperature" | awk 'NR<7{print $2,$3,$4}' >jsond.json
#format sourse data

today=$(awk '{print $1,$2,$3}' jsond.json) && today=$(echo $today | awk '{print $1,$2,$3}') && today=$(echo ${today#\"}) && today=$(echo ${today%\"})
#get format sourse values						#awk format sourse values						#remove front & end '"'
day_pic=$(awk '{print $1}' jsond.json) && day_pic=$(echo $day_pic | awk '{print $2}') && day_pic=$(echo ${day_pic#\"}) && day_pic=$(echo ${day_pic%\"})
night_pic=$(awk '{print $1}' jsond.json) && night_pic=$(echo $night_pic | awk '{print $3}') && night_pic=$(echo ${night_pic#\"}) && night_pic=$(echo ${night_pic%\"})
weather=$(awk '{print $1}' jsond.json) && weather=$(echo $weather | awk '{print $4}') && weather=$(echo ${weather#\"}) && weather=$(echo ${weather%\"})
wind=$(awk '{print $1}' jsond.json) && wind=$(echo $wind | awk '{print $5}') && wind=$(echo ${wind#\"}) && wind=$(echo ${wind%\"})
temp=$(awk '{print $1,$2,$3}' jsond.json) && temp=$(echo $temp | awk '{print $8,$9,$10}') && temp=$(echo ${temp#\"}) && temp=$(echo ${temp%\"})




title="Server醬"
content="变态 今天$today 天气是:$weather 气温$temp $wind


![day]($day_pic)
![night]($night_pic)


才 才不是特意提醒你的呢 哼~


![face](http://sc.ftqq.com/static/image/bottom_logo.png)"


logger -t "【微信推送】" "路由器酱天气推送"
curl -s "http://sc.ftqq.com/$serverchan_sckey.send?text=$title" -d "&desp=$content"
