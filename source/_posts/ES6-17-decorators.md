---
title: ES6学习（17）- Decorators
date: 2019-08-21 01:08:31
categories: ES6
tags: [ES6,javascript ]
---
### Decorator 

修饰器  

修饰函数类的行为，也可以理解为 类的扩展功能


### 基本用法


需要安装插件
<!-- more -->

```
npm install babel-plugin-transform-decorators-legacy --save-dev 
```
修改babel文件 添加插件   
`plugins:[babel-plugin-transform-decorators-legacy]`



```javascript
{ 
    //限制某个属性是只读的
    let readonly = function(target,name,descriptor){
        descriptor.writable = false;
        return decriptor
    };
    
    //修饰器
    class Test{
        @readonly //修改readonly 的行为 让其只读  
        time(){
            return '2017-08-06';
        }
    }
    
    let test = new Test();
    
    rtest.time = function(){
        console.log('rest time');
    }
    
    console.log(test.time());//Cannot assign to read only property 'time' of object '#<Test>'
}


{
    let typename = function(target,name,descriptor){
        target.myname = 'hello';
    }
    
    @typename //修饰器在类的外部
    class Test{
        
    }
    
    console.log('类修饰符',Test.myname); //hello
}
```

第三方库 修饰器的js库：**core-decortors**;  
内置以上的方法

可以通过下载 
`npm install core-decorators`


```javascript
{
    let log=(type)=>{
        return function(target,name,descriptor){
            let src_method = descriptor.value;
            descriptor.value = (...arg)=>{
                src_method.apply(target,arg);
                console.log(`log${type}`);
            }
        }
    }
    
    class AD{
        @log('show')
        show(){
            console.info('ad is show');
        }
        @log('click')
        click(){
            console.info('ad is click');
        }
    }
    let ad = new AD();
    ad.show();//ad is show
    ad.click();//ad is show
}
```
