---
title: js实现活动倒计时
date: 2016-11-02 18:35:28
categories: javascript
tags: javascript 
---
>js倒计时
* 包括天数、时、分、秒
* 手动填写活动开始/结束时间

javascript 获取当前时间 然后在填写活动开始/结束时间

javascript 代码如下：
 <!-- more -->
```javascript
var now = new Date();//获取当前时间

function GetServerTime() {
    var urodz = new Date("11/7/2016 10:00:00"); //填写活动开始/结束时间
    now.setTime(now.getTime() + 250);
    days = (urodz - now) / 1000 / 60 / 60 / 24; //获取天数
    daysRound = Math.floor(days);
    hours = (urodz - now) / 1000 / 60 / 60 - (24 * daysRound); //获取小时
    hoursRound = Math.floor(hours);
    minutes = (urodz - now) / 1000 / 60 - (24 * 60 * daysRound) - (60 * hoursRound); //获取分钟
    minutesRound = Math.floor(minutes);
    seconds = (urodz - now) / 1000 - (24 * 60 * 60 * daysRound) - (60 * 60 * hoursRound) - (60 * minutesRound); //获取秒钟
    secondsRound = Math.round(seconds);
    document.getElementById("date").innerHTML = daysRound;
    //把时分秒显示出来
    document.getElementById("time").innerHTML = hoursRound + "Hours," + minutesRound + "Minutes," + secondsRound + "Seconds";
}
//保持页面1/4秒重新获取一次 
setInterval("GetServerTime()", 250);

```
html代码：
```html
<p class="time">
    <span id="date"></span><span class="white14b">Days,<br/></span><span id="time"></span>
</p>
```