---
title: ES6学习（16）- Generator
date: 2019-08-21 01:07:34
categories: ES6
tags: [ES6,javascript ]
---

### Generator 基本概念 
异步编程的总解决方案
Generator 函数是 ES6 提供的一种异步编程解决方案，语法行为与传统函数完全不同。本章详细介绍 Generator 函数的语法和 API，它的异步编程应用请看《Generator 函数的异步应用》一章。

Generator 函数有多种理解角度。从语法上，首先可以把它理解成，Generator 函数是一个状态机，封装了多个内部状态。

执行 Generator 函数会返回一个遍历器对象，也就是说，Generator 函数除了状态机，还是一个遍历器对象生成函数。返回的遍历器对象，可以依次遍历 Generator 函数内部的每一个状态。

形式上，Generator 函数是一个普通函数，但是有两个特征。一是，function关键字与函数名之间有一个星号；二是，函数体内部使用yield表达式，定义不同的内部状态（yield在英语里的意思就是“产出”）。
<!-- more -->

```javascript
{
    //generator基本定义
    let tell = function*(){
        yield 'a';
        yield 'b';
        return 'c'
    };
    
    let k = tell();
    
    console.log(k.next());//Object{value:'a',done:false}    
    console.log(k.next());/Object{value:'b',done:false}    
    console.log(k.next());//Object{value:'c',done:true}    
    console.log(k.next());//Object{value:ubdefined,done:true}    
}
```

```javascript
{
    let obj={};
    //创建generator函数
    obj[Symbol.ierator]=function*(){
        yield 1;
        yield 2;
        yield 3;
    }
    
    for(let value of obj){
        console.log('value',value);
    }
}
```
generator的最大作用

状态机

```javascript
{
    let state = function*(){
        while(1){
            yield 'A';
            yield 'B';
            yield 'c';
        }
    }
    
    let status = state();
    console.log(status.next());//A
    console.log(status.next());//B
    console.log(status.next());//C
    console.log(status.next());//A
    console.log(status.next());//B
}
```



### next 函数用法

### yield*的语法


抽奖次数  逻辑 


```javascript
{
    let draw = function(count){
        //具体抽奖逻辑 
        
        //输出剩余次数
        console.info(`剩余${count}次`);
    }
    
    let residuce = function*(count){
        while(cuont>0){
            count--;
            //抽奖具体逻辑
            yield draw(count);
        }
    }
    
    let star = residue(5);
    
    let btn = document.createElement('button');
    btn.id = 'start';
    btn.textContent = '抽奖';
    document.body.appendChild(btn);
    document.getElementById('start').addEventListener('click',function(){
        star.next();
    },false);
}
```

长轮询
```javascript
{
    //长轮询
    let ajax = function* (){
        yield new Promise(function(resolve,reject){
            setTimeout(function(){
                resolve({code:0})
            },200)
        })
    }
    
    let pull = function(){
        let genertaor = jax();
        let step = genertaor.next();
        step.value.then(function(d){
            if(d.code!=0){
                setTimeout(function(){
                    console.info('wait');
                    pull();
                },1000);
            }else {
                console.info(d);
            }
        })
    }
    
    pull();//Object {code:0}
}
```

