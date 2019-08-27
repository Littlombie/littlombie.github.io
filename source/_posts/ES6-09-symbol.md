---
title: ES6学习（9）- Symbol
date: 2019-08-21 00:51:51
categories: ES6
tags: [ES6,javascript ]
---

### Symbol 概念

Symbol()声明的变量永远都是独一无二的 

```javascript
{
  // 声明
  let a1=Symbol();//生成一个独一无二的值
  let a2=Symbol();
  console.log(a1===a2);//false 
  let a3=Symbol.for('a3');
  let a4=Symbol.for('a3');
  console.log(a3===a4);//true
}
```
<!-- more -->
### Symbol 作用


```javascript
{
  let a1=Symbol.for('abc');
  let obj={
    [a1]:'123',
    'abc':345,
    'c':456
  };
  console.log('obj',obj);//Object abc:345 c:456 Symbol(abc):"123"  这跟之前的abc不冲突

  for(let [key,value] of Object.entries(obj)){
    console.log('let of',key,value);
  }
  // let of abc 345,let of c 456 拿不到a1（Symbol.for('abc')）的值 
  
  //getOwnPropertySymbols 只能拿到 Symbol.for('abc')的值
  Object.getOwnPropertySymbols(obj).forEach(function(item){
    console.log(obj[item]);//123
  })
    
    
 //Reflect.ownKeys(obj)  能返回了 所有的key 和value 值（包括Symbol.for('abc') 的值 ）
  Reflect.ownKeys(obj).forEach(function(item){
    console.log('ownkeys',item,obj[item]);
  })
}
```


