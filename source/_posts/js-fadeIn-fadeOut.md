---
title: 原生js实现淡入淡出效果
date: 2016-12-19 15:31:52
categories: javascript
tags: javascript
---

>淡出淡入效果，在日常生活中经常用到，使用jQuery的`fadeIn/fadeOut`很容易实现，但是页面需要引入jq库，所以就自己封装个库，可以直接使用。兼容IE7以上
                 （IE的透明度设置为0~100）。
  
### 参数说明：  
`fadeIn()`与`fadeOut()`均有三个参数，第一个为事件（必填）；  
第二个是淡出淡入效果速度，正整数，可选参数；
第三个时指定淡出淡入到的透明度（类似于jQuery中的`fadeTo()`），`0~100`的正整数，参数为可选。
 <!-- more -->
### 核心代码及演示：
 * html代码：
 ```html
 <div id="demo">  
     <div class="box">  
         <h2><input type="button" value="点击淡入" /></h2>  
         <div id="fadeIn" style="display:none">  
             <p>相信你还在这里</p>  
             <p>从不曾离去</p>  
             <p>我的爱像天使守护你，</p>  
         </div>   
     </div>  
       
     <div class="box">  
         <h2><input type="button" value="点击淡出" /></h2>  
         <div id="fadeOut">  
             <p>若生命只到这里</p>  
             <p>从此没有我</p>  
             <p>我会找个天使替我去爱你</p>  
         </div>  
     </div>  
       
     <div class="box">  
         <h2><input type="button" value="点击淡出至指定透明度" /></h2>  
         <div id="fadeTo">  
              <p>相信你还在这里</p>  
              <p>从不曾离去</p>  
              <p>我的爱像天使守护你，</p>  
         </div>  
     </div>  
 </div>  
 
 ```
* javascript 代码：
```javascript
window.onload = function() {
    //底层共用
    var iBase = {
        Id: function(name) {
            return document.getElementById(name);
        },
        //设置元素透明度,透明度值按IE规则计,即0~100
        SetOpacity: function(ev, v) {
            ev.filters ? ev.style.filter = 'alpha(opacity=' + v + ')' : ev.style.opacity = v / 100;
        }
    }
    //淡入效果(含淡入到指定透明度)
    function fadeIn(elem, speed, opacity) {
        /*
         * 参数说明
         * elem==>需要淡入的元素
         * speed==>淡入速度,正整数(可选)
         * opacity==>淡入到指定的透明度,0~100(可选)
         */
        speed = speed || 20;
        opacity = opacity || 100;
        //显示元素,并将元素值为0透明度(不可见)
        elem.style.display = 'block';
        iBase.SetOpacity(elem, 0);
        //初始化透明度变化值为0
        var val = 0;
        //循环将透明值以10递增,即淡入效果
        (function() {
            iBase.SetOpacity(elem, val);
            val += 10;
            if (val <= opacity) {
                setTimeout(arguments.callee, speed)
            }
        })();
    }

    //淡出效果(含淡出到指定透明度)
    function fadeOut(elem, speed, opacity) {
        /*
         * 参数说明
         * elem==>需要淡出的元素
         * speed==>淡出速度,正整数(可选)
         * opacity==>淡出到指定的透明度,0~100(可选)
         */
        speed = speed || 20;
        opacity = opacity || 0;
        //初始化透明度变化值为0
        var val = 100;
        //循环将透明值以10递减,即淡出效果
        (function() {
            iBase.SetOpacity(elem, val);
            val -= 10;
            if (val >= opacity) {
                setTimeout(arguments.callee, speed);
            } else if (val < 0) {
                //元素透明度为0后隐藏元素
                elem.style.display = 'none';
            }
        })();
    }

    var btns = iBase.Id('demo').getElementsByTagName('input');

    btns[0].onclick = function() {
        fadeIn(iBase.Id('fadeIn'));
    }
    btns[1].onclick = function() {
        fadeOut(iBase.Id('fadeOut'), 40);
    }
    btns[2].onclick = function() {
        fadeOut(iBase.Id('fadeTo'), 20, 10);
    }
    
}
```
* css代码：
```css
#demo div.box {float:left;width:31%;margin:0 1%}  
#demo div.box h2{margin-bottom:10px}  
#demo div.box h2 input{padding:5px 8px;font-size:14px;font-weight:bolder}  
#demo div.box div{text-indent:10px; line-height:22px;border:2px solid #555;padding:0.5em;overflow:hidden}  
```
* [演示地址](http://littlombie.github.io/practice/js-fadeIn-fadeOut-fadeTo.html)

###### 本文修改与来源：http://mrthink.net/js-fadein-fadeout-fadeto/
