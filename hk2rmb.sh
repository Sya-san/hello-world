#!/bin/sh
if [ $1 == "hk2rmb" ] ; then
/*
      curl -s "http://web.juhe.cn:8080/finance/exchange/rmbquot?key=b3c8080a83d379dd69fdf606a302a4df" >packet.json
      today=$(./json.sh < packet.json | grep -E "data3" | awk 'NR==6{print $2}' )
*/

      curl -s "http://api.k780.com:88/?app=finance.rate&scur=HKD&tcur=CNY&appkey=10003&sign=b59bc3ef6191eb9f747dd4e83c99f2a4" >packet.json
      today=$(./json.sh < packet.json | awk 'NR==6{print $2}' )   
      content5="

##今天每1元港币兑换
##$today 人民币
##数据仅供参考，实际汇率以银行柜台展示为准
"
      logger -t "【微信推送】" "路由器酱港币汇率推送 $today"
      curl -s "http://sc.ftqq.com/$serverchan_sckey.send?text=$title" -d "&desp=$content5"
      curl -s "http://sc.ftqq.com/$serverchan_sckey4.send?text=$title" -d "&desp=$content5"                   
  else
      echo input error
