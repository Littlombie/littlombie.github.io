---
title: ES6学习（15）- Iterator
date: 2019-08-21 01:02:46
categories: ES6
tags: [ES6,javascript ]
---

### Iterator接口

在整个es6中，操作数据结构，数据结合的读取方式

### Iterator 的基本用法

调用方式 arr[Symbol.iterator]()

<!-- more -->
```javascript
{
    let arr=['hello world!'];
    let map= arr[Symbol.iterator]();
    
    console.log(map.next());//Object {value:'hello',done:false}
    console.log(map.next());//Object {value:'world',done:false}
    console.log(map.next());//Object {value:undefined,done:false}
}
```
自定义 Iterator 接口 

```javascript
{
    let obj={
        start:[1,3,2];
        end:[7,9,8];
        //es6新增方式
        [Symbol.iterator](){
           let self = this;
           let index=0;
           let arr=self.start.concat(self.end);
           let len =arr.length;
           return {
           //返回对象必须要包含next()
               next(){
                   //遍历的过程
                   if(index<length){
                       return {
                           value:arr[index++],//当前遍历
                           done:false//表示是否结束
                       }
                   }else{
                       return {
                           value:arr[index++];
                           done:true
                       }
                   }
               }
           }
        }
    }
    for(let key of obj){
        console.log(key);
    }
}

```


### for...of...

``` js
{
    let arr=['hello world!'];
    for(let value of arr){
        console.log('value',value);//value hello,value world!
    }
}
```
