---
title: ES6学习（8）- 对象扩展
date: 2019-08-21 00:50:47
categories: ES6
tags: [ES6,javascript ]
---

### 简介表示法

注意下列ES5，ES6代码的不同写法
<!-- more -->
``` js
{
  // 简洁表示法
  let o=1;
  let k=2;
  //es5的写法
  let es5={
    o:o,
    k:k
  };
  //es6的写法
  let es6={
    o,
    k
  };
  console.log(es5,es6);
  //es5中的方法
  let es5_method={
    hello:function(){
      console.log('hello');
    }
  };
  //es6中的方法
  let es6_method={
    hello(){
      console.log('hello');
    }
  };
  console.log(es5_method.hello(),es6_method.hello());
}
```


### 属性表示法

``` js
{
  // 属性表达式
  let a='b';
  let es5_obj={
    a:'c',
    b:'c'
  };
  //key 值，表达式 
  let es6_obj={
    [a]:'c'
  }

  console.log(es5_obj,es6_obj);

}
```
`es6_obj`输出的值为 `b:'c'`

### 扩展运算符

**`Object.is`** 判断是否相等  
**`Object.assign`** 浅拷贝   
**`Object.entries`** 对象的遍历 
``` js
{
  // 新增API
  console.log('字符串',Object.is('abc','abc'),'abc'==='abc'); true true 
  console.log('数组',Object.is([],[]),[]===[]);//false false 
  
  //浅拷贝 
  console.log('拷贝',Object.assign({a:'a'},{b:'b'}));

  let test={k:123,o:456};
  for(let [key,value] of Object.entries(test)){
    console.log([key,value]);
  }
}
```

### Object新增方法

扩展运算符 

``` js
{
  // 扩展运算符
  // let {a,b,...c}={a:'test',b:'kill',c:'ddd',d:'ccc'};
  // c={
  //   c:'ddd',
  //   d:'ccc'
  // }
}
```
