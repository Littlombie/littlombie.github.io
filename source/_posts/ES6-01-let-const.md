---
title: ES6学习（1）-let,const
date: 2019-08-20 18:04:31
categories: ES6
tags: [ES6,javascript ]
---

### let 
#### 作用域的概念


```javascript
function test(){
    //var a = 1;
    for(let i =1;i<3;i++){
        
    console.log(i);
    }
    
    console.log(i);
}
test();//1,2，i is not defined
```
块作用域 ：如果一个方法（函数）用大括号包裹起来 ，那么这就是块级作用域；
`let`只在块级作用域内有效；
 <!--  more  -->
ES6 是强制启用严格模式 （'use strict'）

```
let a = 1;
let a = 2;
```
强调：以上会报错  * 使用`let`不能重复声明变量

### const

`const` 用来定义成常量，常量的作用是其值不能修改 (不严谨);
声明的时候必须赋值；

如：
```javascript
fucntion last(){
    const PI = 3.1415926;
    PI = 8;
    console.log(PI);
}
last();//报错 “PI” is read-only
```
上边PI 的值改变了 ，所以报错
`const` 也是有块级作用域

```javascript
fucntion last(){
    const PI = 3.1415926;
    const k = {
        a:1
    }
    k.b = 3;
    console.log(PI,k);
}
last();
```
上边 用`const`声明 `k` 为一个对象 ；对象是引用类型，对象本身是可以变的，`k`只是指向的是其不变的指针 