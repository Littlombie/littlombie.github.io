---
title: ES6学习（12）- Proxy和Reflect
date: 2019-08-21 00:58:33
categories: ES6
tags: [ES6,javascript ]
---
## Proxy和Reflect的概念

### Proxy对象   

代理  

生成对象：  new Proxy();

<!-- more -->
```javascript
{
    let obj = {
        time:'2017-03-11',
        name:'net',
        _r:123
    };
    //第一个参数是需要代理的对象 ，第二个是代理的方法 
    let monitor = new Proxy(obj,{
        //拦截对象属性的读取，跟代理是一个意思 target
        get(target,key){
            return target[key].replace('2017','2018');
        },
        
        
        //拦截对象设置属性
        set(target,key,value){
            if(key==='name'){
                return target[key]=value;
            }else {
                return target[key];
            }
        },
        
        //拦截 key in object 操作
        has(target,key){
            if(key==='name'){
                return target[key];
            }else{
                return false;
            }
        },
        
        //拦截delete
        deleteProperty(target,key){
            if(key.indexOf("_">-1)){
                delete target[key];
                return true;
            }else {
                return target[key];
            }
        },
        
        //拦截object.keys,Object.getOwnPropertySymbols,Object.getOwnPropertyNames
        ownKeys(target){
            return
            Object.keys(target).filter(filter(item=>item!='time'));//过滤掉time属性 ，不让返回
        }
    });

    console.log('get',monitor.time);//get 2018-03-11
    
    monitor.name='mukewang';
    console.log('set',monitor.time,monitor);//set 2018-03-11  Proxy{time:'2017-03-11',name:'mukewang',_r:123}
    
    console.log('has','name'in monitor,'time' in monitor);//has true false;
    
    delete.monitor.time;
    console.log('delete',monitor); //time没有被删除  还是全部 输出 Proxy{time:'2017-03-11',name:'mukewang',_r:123}
    
    delete.monitor._r;
    console.log('delete',monitor);//Proxy{time:'2017-03-11',name:'mukewang',}
    
    console.log('ownKeys',Object.keys(monitor));//Proxy {time,_r}
}

```

### Reflect对象  

反射的是Object

生成对象： 直接 Reflect


```javascript
{
    let obj = {
        time:'2017-03-11',
        name:'net',
        _r:123
    };

    console.log('Reflect     get',Reflect.get(obj,'time'));//Reflect get  time:"2017-03-11",

    Reflect.set(obj,'name','mukewang');
    console.log('Reflect set', obj);//'Reflect set' Object {time:"2017-03-11",name:"mukewang",_r:123}

    console.log('Reflect     has',Reflect.has(obj,'name'));//true  
}

    
```


## Proxy和Reflect的适用场景

通用方式  

数的校验，数据类型 格式校验  表单验证



```JavaScript
{
    function validator(target,validator){
        return new Proxy(target,{
            _validator:validator,
            set(target,key,value,proxy){
                if(target.hasOwnProperty(key)){
                    let va=this._validator[key];
                    if(!!va(value)){
                        return Reflect.set(target,key,value,proxy)
                    }else{
                        throw Error(`不能设置${key}到${value}`)
                    }
                    
                }else{
                    throw Error(`${key} 不存在`)
                }
            }
        })
    } 
    
    const personValidators={
        name(val){
            return typeof val==='tring'
        },
        age(val){
            return typeof val==='number' && val>18
        }
    }
    
    class Person{
        constructor(name,age){
            this.name = name;
            this.age = age;
            return validator(this,personValidators)
        }
    }
    
    const =person = new Person('lilei',30);
    
    console.info(person);//Proxy {name,'lilei',age,30}
    
    person.name = 48;
    console.info(person);//throw Error '不能设置name 到 48' 
    
    person.name = 'Han meimei';
    
    console.info(person);//Proxy {name,'Han meimei',age,30}
}

```
