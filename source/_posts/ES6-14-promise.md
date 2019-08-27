---
title: ES6学习（14）- Promise
date: 2019-08-21 01:01:37
categories: ES6
tags: [ES6,javascript ]
---

### Promise 概念

**Promise** 是异步编程的解决方案


### 什么是异步
有一个函数A ，A执行完后执行B，
异步方式有：

- 回调方式，
- 事件触发 

Promise 不同于以上两种方式

### Promise 的作用

用来解决异步操作的解决方法 
<!-- more -->

### Promise的基本用法


#### 之前的写法 
```javascript

{
    //基本定义 用 计时器模拟ajax 的回调 
    let ajax = function(callback){
        console.log('执行');
        setTimeout(function(){
            callback && callback.call();
        },1000);
    };
    ajax(function(){
        console.log('timeout1');
    });
    
    //先输出'执行' 1s后输出timeout1
}
```
这样写影响后期维护，回调的顺序很乱

#### 使用Promise

```javascript
{
    let ajax=function(){
        console.log('执行2');
        //返回new Promise实例 该实例有个then()方法  resolve 表示执行下一步 reject中断当前操作
        return new Promise(function(resolve,reject){
            setTimeout(function(){
                resolve();
            },1000);
        });
    }
    //then()方法 表示执行下一步 
    ajax().then(function(){
        console.log('promise','timeout2');
    })
}
```

串行过程 ，then()链式操作
```javascript
{
    let ajax=function(){
        console.log('执行3');
        return new Promise(function(resolve,reject){
            setTimeout(function(){
                resolve();
            },1000);
        });
    }
    ajax()
        .then(function(){
        //继续返回Promise实例 
        return new Promise(function(resolve,reject){
            setTimeout(function(){
                resolve();
            },2000);
        })
    })
        .then(function(){
        console.log('timeout3');
    });
}
```


catch 捕获异常错误

```javascript
{
    let ajax=function(num){
        console.log('执行4');
        return new Promise(function(resolve,reject){
            setTimeout(function(){
                //如果参数大于5 继续向下执行
                if(num>5){
                    resolve();
                }else {//否则 抛出错误 
                    throw new Error('出错了');
                }
            },1000);
        });
    }
    ajax(6).then(function(){
        console.log('log',6);// log 6
    }).catch(function(err){
        console.log('catch',err);
    });
    ajax(3).then(function(){
        console.log('log',3);
    }).catch(function(err){
        console.log('catch',err);//catch 出错了 
    });
}

```
### Promise 高级用法 

fade流  今日头条、uc 新闻案例 加载新闻图片 

- **Promise.all** 所有图片加载完再添加到页面

```javascript
{
    //所有图片加载完再添加到页面
    function loadImg(src){
        return new Promise((resolve,reject)=>{
            let img = document.creatElement('img');
            img.src=src;
            //本身就是一个Promise实例 
            img.onload = function(){
                resolve(img);
            }
            img.onerror=function(err){
                reject(err);
            }
        })
    }
    function showImgs(imgs){
        imgs.forEach(function(img){
            document.body.appendChild(img);
        })
    }
    //加载图片 Promise.all返回的是一个实例 表示把多个 promise 实例当做一个promise实例来
    Promise.all([
        loadImg('https://img.com/1.png'),
        loadImg('https://img.com/2.png'),
        loadImg('https://img.com/3.png')
    ]).then(showImgs)
}
```
先到先得 
- **Promise.race** 表示有一个状态率先改变 那么这个race 状态就改变  

```javascript
{ 
    //有一个图加载完 就添加到页面中 
    function loadImg(src){
        return new Promise((resolve,reject)=>{
            let img = document.creatElement('img');
            img.src=src;
            img.onload = function(){
                resolve(img);
            }
            img.onerror=function(err){
                reject(err);
            }
        })
    }
    
    function showImgs(img){
        let p = document.creatElement('p');
        p.appendChild(img);
        document.body.appendChild(p);
    }
    
    Promise.race([
        loadImg('https://img.com/1.png'),
        loadImg('https://img.com/2.png'),
        loadImg('https://img.com/3.png')
    ]).then(showImgs)
}
```




