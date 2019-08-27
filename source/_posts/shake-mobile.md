---
title: Shake--手机摇一摇
date: 2017-01-17 16:46:00
categories: javascript
tags: javascript 
---

<img src="/images/post/newYear.jpg" class="full-image" />

>马上过年了，发红包肯定是不能少的，为了增加趣味性，我们可以做一个摇一摇抢红包。

页面演示(用手机扫描下边二维码)   

![shake](http://littlombie.github.io/images/post/qr-shake.png)  


[查看代码](https://github.com/Littlombie/practice/tree/master/shake)   

### 操作流程
1. 页面刚打开，是不能执行摇一摇，需要点击`Shake`按钮开启；  
2. 点击按钮后，会有一个摇一摇动画，提示可也摇；  
2. 摇一摇后执行函数，弹出奖品页面

<!-- more -->
### HTML页面  
```html
<div class="container">
    <button>Shake</button>
    <img class="yaoPic" src="images/ico-yao.png" alt="">
    <div class="showPage">
        <h2>Congratulations <br/>to you on the award!</h2>
        <img class="qr" src="images/qr.png" alt="">
        <span><img src="images/close.svg" alt=""></span>
    </div>
</div>
<audio controls="controls" id="audio" autoplay="false" loop="false" style="display: none">
    <source src="shake.mp3" type="audio/mp3" />
</audio>
<!--noHorizontal-->
<section id="noHorizontal">
    <div></div>
    <p>请在竖屏模式下浏览</p>
</section>
```
`button`按钮为摇一摇的开关，如果不点击，摇一摇函数不会执行；  
`yaoPic` 点击按钮后 图片会有一个摇一摇的动画，提示现在可以开始摇一摇；  
`showPage` 是摇一摇后的回调函数：显示要到的内容； 
 
###  库  
* 引入代码库 shake.js:  
```html
<script src="shake.js"></script>
```
  
*  [shake.js](https://github.com/alexgibson/shake.js)代码：
```javascript
(function(global, factory) {
    if (typeof define === 'function' && define.amd) {
        define(function() {
            return factory(global, global.document);
        });
    } else if (typeof module !== 'undefined' && module.exports) {
        module.exports = factory(global, global.document);
    } else {
        global.Shake = factory(global, global.document);
    }
} (typeof window !== 'undefined' ? window : this, function (window, document) {

    'use strict';

    function Shake(options) {
        //feature detect
        this.hasDeviceMotion = 'ondevicemotion' in window;

        this.options = {
            threshold: 15, //default velocity threshold for shake to register
            timeout: 1000 //default interval between events
        };

        if (typeof options === 'object') {
            for (var i in options) {
                if (options.hasOwnProperty(i)) {
                    this.options[i] = options[i];
                }
            }
        }

        //use date to prevent multiple shakes firing
        this.lastTime = new Date();

        //accelerometer values
        this.lastX = null;
        this.lastY = null;
        this.lastZ = null;

        //create custom event
        if (typeof document.CustomEvent === 'function') {
            this.event = new document.CustomEvent('shake', {
                bubbles: true,
                cancelable: true
            });
        } else if (typeof document.createEvent === 'function') {
            this.event = document.createEvent('Event');
            this.event.initEvent('shake', true, true);
        } else {
            return false;
        }
    }

    //reset timer values
    Shake.prototype.reset = function () {
        this.lastTime = new Date();
        this.lastX = null;
        this.lastY = null;
        this.lastZ = null;
    };

    //start listening for devicemotion
    Shake.prototype.start = function () {
        this.reset();
        if (this.hasDeviceMotion) {
            window.addEventListener('devicemotion', this, false);
        }
    };

    //stop listening for devicemotion
    Shake.prototype.stop = function () {
        if (this.hasDeviceMotion) {
            window.removeEventListener('devicemotion', this, false);
        }
        this.reset();
    };

    //calculates if shake did occur
    Shake.prototype.devicemotion = function (e) {
        var current = e.accelerationIncludingGravity;
        var currentTime;
        var timeDifference;
        var deltaX = 0;
        var deltaY = 0;
        var deltaZ = 0;

        if ((this.lastX === null) && (this.lastY === null) && (this.lastZ === null)) {
            this.lastX = current.x;
            this.lastY = current.y;
            this.lastZ = current.z;
            return;
        }

        deltaX = Math.abs(this.lastX - current.x);
        deltaY = Math.abs(this.lastY - current.y);
        deltaZ = Math.abs(this.lastZ - current.z);

        if (((deltaX > this.options.threshold) && (deltaY > this.options.threshold)) || ((deltaX > this.options.threshold) && (deltaZ > this.options.threshold)) || ((deltaY > this.options.threshold) && (deltaZ > this.options.threshold))) {
            //calculate time in milliseconds since last shake registered
            currentTime = new Date();
            timeDifference = currentTime.getTime() - this.lastTime.getTime();

            if (timeDifference > this.options.timeout) {
                window.dispatchEvent(this.event);
                this.lastTime = new Date();
            }
        }

        this.lastX = current.x;
        this.lastY = current.y;
        this.lastZ = current.z;

    };

    //event handler
    Shake.prototype.handleEvent = function (e) {
        if (typeof (this[e.type]) === 'function') {
            return this[e.type](e);
        }
    };

    return Shake;
}));
```
### 实现  
实现、设置参数如下
```javascript
    //create a new instance of shake.js.
    var myShakeEvent = new Shake({
        threshold: 15
    });
    // start listening to device motion
    btn.addEventListener('touchend',function(){
        yao.className = 'yaoPic yaoAni';
        // start listening to device motion
         myShakeEvent.start();
    },false);
    // register a shake event
    window.addEventListener('shake', shakeEventDidOccur, true);
    //shake event callback
    function shakeEventDidOccur () {
        //if phone support navigator.vibrate
        if (navigator.vibrate) {
            //vibrate 1 second
            navigator.vibrate(1000);
        } else if (navigator.webkitVibrate) {
            navigator.webkitVibrate(1000);
        }
        //put your own code here etc.
        audio.play();
        audio.loop = false;
        setTimeout( function(){
            showPage.className = 'showPage showAni';
        },600);
     
        document.title = 'shaked! O_o'
        close.addEventListener('touchend',function(){
            showPage.className = 'showPage';
        },false);
    }
```
* 代码中 `myShakeEvent` 里边设置摇动的幅度，数字越大，表示幅度越大，启动摇一摇函数；  
* `myShakeEvent.start();`按钮点击后启动摇一摇函数；  
* `navigator.vibrate` 检测手机是否支持振动，目前经测试大部分Android手机支持振动，ios不支持；  
* 添加一个手机摇一摇声音，音乐执行一次就关闭  

###### **弹出页面内容可以使根据奖品内容不同随机展示**



