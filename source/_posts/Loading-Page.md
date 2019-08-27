---
title: 数字化Loading 
date: 2016-11-07 18:15:27
categories: javascript
tags: javascript 
description:  js页面从0~100%的loading； 用`document.readyState == "complete"`判断页面是否加载完成，loading完成后显示加载完成。
---

* js页面从0~100%的loading；

javascript代码：

```javascript
function setSB(v, el) {
        //判断页面是否加载完成
        if (document.readyState == "complete") {
            valueEl = el.children[0];
            valueEl.innerText = v + "%";//显示百分比
        }
    }
    function fakeProgress(v, el) {
        if (v > 100){//加载完成
            document.querySelector('#text').innerHTML="加载完成";
            setTimeout(function(){
                document.querySelector('#sb').style.display="none";
            },200);
        }
        else {
            setSB(v, el);
            window.setTimeout("fakeProgress(" + (++v) + ", document.all['" + el.id + "'])", 20); 
        }
    }
```



html代码：

```html
<body onload="fakeProgress(0, sb)">
    <center>
        <p id="text">正在载入中，请稍侯……</p>
        <span id='sb' style="width: 302px">
            <div></div>
            <div style="font-size: 9pt; width: 100%; text-align: center"></div>
        </span>
    </center>
</body>
```
