---
title: javascript基本运动框架
date: 2016-11-01 11:42:21
categories: web
tags: [javascript,css]
description: javascript 基本运动框架，包括变化元素的宽高，透明度 以及文字、背景、边框颜色的渐变
 
---

####  基础的形变

 * 长度、宽度
 * 字体大小
 * 边框宽度
 * 透明度

```javascript
//基本的运动动画
function getStyle(obj, name) {//获取行内的样式 name表示获取的样式
    if (obj.currentStyle) {
        return obj.currentStyle[name];
    } else {
        return getComputedStyle(obj, false)[name];
   } 
}
    
//运动框架主体
function startMove(obj, attr, iTarget) {//attr 变化的样式；iTarget 最后变化目标
    clearInterval(obj.timer);//初始化 清除所有的计时器
    obj.timer = setInterval(function() {
        var cur = 0;
        if (attr == 'opacity') {//如果变化的是透明度  执行下边
            cur = parseFloat(getStyle(obj, attr)) * 100;
        } else {
            cur = parseInt(getStyle(obj, attr));
        }
        var speed = parseInt(iTarget - cur) / 6;// 动画进行的事件 6可以修改 
        speed = speed > 0 ? Math.ceil(speed) : Math.floor(speed);
        if (cur == iTarget) {
            clearInterval(obj.timer);
        } else {
            if (attr == 'opacity') {//如果变化的是透明度  执行下边
                obj.style.filter = 'alpha(opacity:' + (cur + speed) + ')';
                obj.style.opacity = (cur + speed) / 100;
            } else {
                obj.style[attr] = cur + speed + 'px';
            }
        }
    }, 30);
}
```
调用：
 
```javascript
//改变宽度
oDiv.onmouseover = function () {
    startMove(this, 'width', 200);
}

//透明度
oDiv.onmouseout = function () {
    startMove(this, 'opacity', 30);
}
```

#### 颜色的渐变

* 通过修改元素的rgb值 来实现渐变

```javascript
//颜色的渐变动画  改变的是 rgb值
//所有代码的执行时间只有24毫秒左右。  
function fadeColor(from, to, callback, duration, totalFrames) {//form 初始颜色 to最终颜色 callback完后的回调函数  duration 动画执行时间  totalFrames总帧数，默认为持续秒数*15帧，也即每秒15帧   
//用一个函数来包裹setTimeout，根据帧数来确定延时     
    function doTimeout(color, frame) {
        setTimeout(function() {
            try {
                callback(color);
            } catch (e) {
                JSLog.write(e);
            }
        }, (duration * 1000 / totalFrames) * frame);
        //总持续秒数/每秒帧数*当前帧数=延时(秒)，再乘以1000作为延时(毫秒)      
    }
    // 整个渐变过程的持续时间，默认为1秒     
    var duration = duration || 1;
    // 总帧数，默认为持续秒数*15帧，也即每秒15帧      
    var totalFrames = totalFrames || duration * 15;
    var r, g, b;
    var frame = 1;
    //在第0帧设置起始颜色      
    doTimeout('rgb(' + from.r + ',' + from.g + ',' + from.b + ')', 0);
    //计算每次变化所需要改变的rgb值      
    while (frame < totalFrames + 1) {
        r = Math.ceil(from.r * ((totalFrames - frame) / totalFrames) + to.r * (frame / totalFrames));
        g = Math.ceil(from.g * ((totalFrames - frame) / totalFrames) + to.g * (frame / totalFrames));
        b = Math.ceil(from.b * ((totalFrames - frame) / totalFrames) + to.b * (frame / totalFrames));
        // 调用本frame的doTimeout          
        doTimeout('rgb(' + r + ',' + g + ',' + b + ')', frame);
        frame++;
    }
}
```

调用:
```javascript
oDiv.onmouseover = function () {
    fadeColor({
        r: 0,
        g: 0,
        b: 0
    }, //star color
    {
        r: 18,
        g: 162,
         b: 143
    }, //end color
    function (color) {
        oDiv6.style.borderColor = color;
    }, 0.25, 10);
}
```