---
title: css3导航动画切换
date: 2016-11-09 18:14:22
categories: css
tags: [css3,html]
---

我们浏览有些手机网站时，有时会发现页面的导航打开动画很有意思，类似下图这种：

![nav](http://littlombie.github.io/images/nav.gif)

现在我们用`html` `input`表单以及`css3`实现这个功能，原理如下：

* html为用`input` 与`label`表单，`label`下边三个`div`表示导航的三条横线；

* 当点击`label`时，`input`会选中,与之对应的`label`下边三个`div`执行动画,其中第二个div让宽度为0，位置发生变化，第一个与第三个div执行旋转动画，形成`×`；

* 再次点击取消选中时，利用`input`的属性，恢复到选中之前的状态。

html代码如下：

<!-- more -->

```html
<div class="nav_bar">
    <input type="checkbox" id="nemu_button">
    <label for="nemu_button">
         <div class="line_top transition"></div>
         <div class="line_meddle transition"></div>
         <div class="line_bottom transition"></div>
    </label>
</div>
```

css代码如下：

```css

/*过渡动画transition*/
.transition {
	-webkit-transition: all .25s ease-in-out;
	   -moz-transition: all .25s ease-in-out;
	    -ms-transition: all .25s ease-in-out;
	     -o-transition: all .25s ease-in-out;
	        transition: all .25s ease-in-out;
}

#nemu_button {
    position: absolute;
    left: 9999px;
}
label {
	position: absolute;
	right:50px;
	cursor:pointer;
}
label>div {
	width: 30px;
	height: 2px;
	margin-bottom: 8px;
	background: #fff;
}
/*input选中是 label下边的三条横线的过渡动画*/
input:checked + label .line_top {
	margin-top: 15px;
	-webkit-transform: rotate(-45deg);
	   -moz-transform: rotate(-45deg);
	    -ms-transform: rotate(-45deg);
	     -o-transform: rotate(-45deg);
	        transform: rotate(-45deg);
}
input:checked + label .line_meddle {
	width: 0;
	margin-top: -15px;
	margin-left: 15px;
}
input:checked + label .line_bottom {
	margin-top: -5px;
	-webkit-transform: rotate(45deg);
	   -moz-transform: rotate(45deg);
	    -ms-transform: rotate(45deg);
	     -o-transform: rotate(45deg);
	        transform: rotate(45deg);
}
```
