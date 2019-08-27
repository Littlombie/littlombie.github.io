---
title: CSS实现多行文本溢出显示省略号
date: 2016-12-08 17:36:47
categories: css
tags: css3
---

### 单行文本溢出显示省略号

单行文本溢出隐藏显示出省略号，前提是要先定文本的宽度  
实现方法
```css
.text1{
    display: block;
    width:100px;
    font-size:14px;
    line-height:1.5;
    overflow: hidden;/*溢出隐藏*/
    white-space: nowrap;/*禁止换行*/
    text-overflow: ellipsis;/*超出文字以省略号显示*/
}
```
显示效果  
![单行文本溢出隐藏显示出省略号](http://littlombie.github.io/images/post/2016120801.jpg)

### 多行文本溢出显示省略号

<!-- more -->
实现方法
```css
.text2 {
    width:100px;
    display: -webkit-box;/*课伸缩盒子、弹性盒子*/
    -webkit-box-orient: vertical;/*从上往下垂直排列子元素*/
    -webkit-line-clamp:3;/*限制在一块元素显示的文本的行数（超出三行显示省略号）*/
    overflow: hidden;
}
```
显示效果  
![单行文本溢出隐藏显示出省略号](http://littlombie.github.io/images/post/2016120802.jpg)    
**因使用了WebKit的CSS扩展属性，所以该方法只适用于WebKit浏览器及移动端**

### 兼容写法:（通过定为实现）
实现方法  
```css
.text3 {
    width:100px;/*自己定义高度*/
    position:relative;
    line-height:20px;/*行高*/
    max-height:80px;/*这里是行高的几倍就表示显示几行文本*/
    overflow:hidden;
}
.text3::after {
    content:'...';
    position:absolute;
    bottom:0;
    right:0;
    padding-left:40px;
    background:-webkit-linear-gradient(left,transparent,#fff 55%);
    background:-o-linear-gradient(right,transparent,#fff 55%);
    background:-moz-linear-gradient(right,transparent,#fff 55%);
    background:linear-gradient(to right,transparent,#fff 55%);
}
```
显示效果
![单行文本溢出隐藏显示出省略号](http://littlombie.github.io/images/post/2016120803.jpg)  