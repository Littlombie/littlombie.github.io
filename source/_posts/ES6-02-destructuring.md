---
title: ES6学习（2）- 解构赋值
date: 2019-08-20 18:05:31
categories: ES6
tags: [ES6,javascript ]
---

### 数组类的解构赋值

```javascript
{
  let a,b,rest;
  [a,b]=[1,2];//等价于 let a = 1,b = 2;
  console.log(a,b);
}

```
上边的`[a,b]=[1,2];`等价于 `let a = 1,b = 2 ;`

```javascript
{
let a,b,rest;
[a,b,...rest] = [1,2,3,4,5,6];
console.log(a,b,rest);//1,2,[3,4,5,6]
}
```

<!-- more -->
上边的`[a,b,...rest] = [1,2,3,4,5,6];`等价于 ``



```javascript
{
  let a,b,c,rest;
  [a,b,c=3]=[1,2];
  console.log(a,b,c);
}
```
如果上边的`c=3`改为`c`,那么直接就是输出的c为undefined，所以 `c=3`防止没有配对成功时的undefined


```javascript
{
  let a=1;
  let b=2;
  [a,b]=[b,a];
  console.log(a,b);//2,1
}
```
通过解构赋值 可以实现变量交换，不用es5里边需要中间值存储

```javascript
{
  fucntion f(){
    return [1,2]
  } 
  let a,b;
  [a,b]=f();
  console.log(a,b);//1,2
}
```
这是一个重要的场景  
如果我们没有解构赋值，我们想取到第一个或者第二个元素，那么我们得用一个变量来接收这个函数运行的结果，然后通过索引返回0,1两个位置返回的值，这样写比较麻烦，用ES6 写就很方便

```javascript
{
  function f(){
    return [1,2,3,4,5]
  }
  let a,b,c;
  [a,,,b]=f();
  console.log(a,b);//1,4
}

{
  function f(){
    return [1,2,3,4,5]
  }
  let a,b,c;
  [a,,...b]=f();
  console.log(a,b);//1,[3,4,5]
}
```
`,`是把中间的值忽略获取 ；

### 对象类解构赋值 

新建一个块作用域
```javascript
{
    let a,b;
    ({a,b}={a:1;b:2;})
    console.log(a,b);//1,2
}
```

```javascript
{
  let o={p:42,q:true};
  let {p,q}=o;
  console.log(p,q);//42,true
}
```
对象的解构赋值的左右必须为对象
```javascript
{
  let {a=10,b=5}={a:3};
  console.log(a,b);//3,5
}
```


```javascript
{
  let metaData={
    title:'abc',
    test:[{
      title:'test',
      desc:'description'
    }]
  }
  let {title:esTitle,test:[{title:cnTitle}]}=metaData;
  console.log(esTitle,cnTitle);//abc,test
}
```
