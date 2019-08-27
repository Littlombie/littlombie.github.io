---
title: css3的3D立体效果
date: 2017-02-10 17:52:05
categories: css3 
tags: [css3,3d]
---

<img src="/images/post/3D.jpg" class="full-image" alt='3D' />

>周末朋友叫我去看电影，  
我：“啥片，3D的不？”，  
朋友：“不是！”；  
我：“不是3D那就不去了，等以后在电脑上看吧，去电影院不就是去感受影片的3D的视觉效果么！”  
朋友：“……”    
  
  
 做网页也一样，现在2D已经不能满足我们的视觉需求，为了追求视觉冲突的真实感，我们往往会使用一些css3 3D效果的交互；最近我被[淘宝造物节](http://jdc.jd.com/lab/zaowu/index_new.html)给刺激了，试着学着折腾css3的 3D transform效果。虽然现在还没有达到效果，但是还是有所收获。

 ### 建立立体感
  
 首先我们要有一定的立体感： 
 
 ![3d_axes](http://littlombie.github.io/images/post/3d_axes.png)
 
 通过这个图片应该清楚的了解到了x轴 y轴 z轴是什么概念了。  
 <!--  more  -->
 3D transform 就是沿着x轴 y轴 z轴 做变化；  
 3D transform中有下面这三个方法：
 
 `rotateX( angle )`   
 `rotateY( angle )`  
 `rotateZ( angle )` 
 
`rotateX`旋转X轴，`rotateY`旋转Y轴，`rotateZ`旋转Z轴，括号里边都是变化的度数；  
3d无非就是通过X Y Z轴来进行操作  
### 搭建3D
搭建之前首先明白以下属性的意思：  
`transform-style: preserve-3d;` 3d空间  
`perspective: 800px; `它被成为视距或者景深.   
`perspective-origin:50% 50%;` 这就是你的眼睛位置 位置不同效果也就不用了  


`translateZ`则可以帮你理解透视位置。  
`transform-origin`我们成为基点 在水平方向改变观看div的位置   
`backface-visibility:hidden;`为了切合实际，我们常常会这样设置，使后面元素不可见  
`scale` 缩放 `rotate` 旋转 `translate`移动 `skew`倾斜 通过这些来进行3d效果   

一个小例子：

![翻转](http://littlombie.github.io/images/post/3dTransform.gif)
HTML:
```html
 
<div id="box"> 
    <div class="bian zhi1">
        <img src="01.jpg" alt="">
    </div>
    <div class="bian zhi2">
        <img src="02.jpg" alt="">
    </div>
</div> 
```
CSS:
```css
#box{ 
    width: 300px; 
    height: 300px; 
    margin: 0 auto; 
    transform-style: preserve-3d; 
    position: relative; 
    transition: 2s; 
} 
#box:hover{ 
transform:rotateY(180deg);
} #box .bian{ 
    width: 300px; 
    height: 300px; 
    text-align: center; 
    line-height: 300px; 
    font-size: 100px; 
    position: absolute;
} .zhi1{ 
    background-color: red; 
    transform:rotateY(180deg); 
} .zhi2{ 
    background-color: yellow; 
    backface-visibility: hidden;/*设置后面的可视度为看不见 */
}
```
### 实例

我们可以用css 3Dtransform制作个魔方  
首先先让六个面全部叠加在一起； 通过自己对3d空间的理解 和 x y z 轴的移动来拼接这个立方体；
然后使用css3 动画 animation 改变rotate值，使其动起来   
1. 
![魔方](http://littlombie.github.io/images/post/rotate.gif)


部分css3代码：
```css
 #box {
      perspective: 800px;
      transform-style: preserve-3d;
      transition: 5s infinite;
      transform: rotateX(0deg) rotateY(0deg);
 }
 .mofang_box {
      width: 200px;
      height: 200px;
      margin: 300PX auto;
      position: relative;
      transform-style: preserve-3d;
      -webkit-animation: rotate 60s linear infinite;
      -o-animation: rotate 60s linear infinite;
      animation: rotate 60s  linear infinite;
 }
 @-webkit-keyframes rotate{
      0%{
          transform: rotateX(0deg) rotateY(0deg);
      }
      100% {
          transform: rotateX(3600deg) rotateY(3600deg);
      }
 }
 .mofang_box:hover {
     transform: rotateX(3600deg) rotateY(3600deg);
 }
 .mofang {
     width: 200px;
     height: 200px;
     text-align: center;
     line-height: 200px;
     position: absolute;
 }
 .left{
     transform:rotateY(90deg)translateZ(-100px);
 }
 .right {
     transform: rotateY(90deg) translateZ(100px);
 }
 .top {
     transform: rotateX(90deg) translateZ(100px) rotateZ(360deg);
 }
 .buttom {
     transform: rotateX(90deg) translateZ(-100px) rotateZ(180deg);
 }
 .hou {
     transform: rotateX(0deg) translateZ(-100px) rotateZ(180deg);
 }
 .qian {
     transform: rotateX(0deg) translateZ(100px);
 }
```
* 设置6个`div`分别表示`left(左)`、`right(右)`、`top(上)`、`buttom(下)`、`hou(后)`、`qian(前)`各六个面，然后给一定的`transform`形成一个立方体，再给整体添加个动画，让其自运动  

[查看完整代码](https://github.com/Littlombie/practice/blob/master/css3-cube/index.html)

2.[css3 3D轮播图（demo）](https://littlombie.github.io/practice/css3-rotate-banner/)





######  参考文章：  
######  [一篇文章搞定css3 3d效果](http://www.cnblogs.com/changlel/p/6385953.html)  
######  [好吧，CSS3 3D transform变换，不过如此！](http://www.zhangxinxu.com/wordpress/2012/09/css3-3d-transform-perspective-animate-transition/)  
######  图片来源于网络  