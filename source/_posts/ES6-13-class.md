---
title: ES6学习（13）- 类与对象
date: 2019-08-21 00:59:43
categories: ES6
tags: [ES6,javascript ]
---

## 类
 
类的概念
  - | - | -
---|---|---
基本语法 | 类的继承 |静态方法
静态属性 | getter | setter


### class  基本定义和生成实例
<!-- more -->
```javascript
{
    //基本定义和生成实例 通过class + 关键字 类来定义类 
    class Parent{
        constructor(name='mukewang'){
            this.name = name;
        }
    }
    let v_parent = new Parent('v');
    
    console.log('构造函数的实例',v_parent);// v_parent {name 'v'}
}
```
### 类的继承
```javascript
{
    //继承
     class Parent{
        constructor(name='mukewang'){
            this.name = name;
        }
    }
    //使用 extends继承 
    class Child extends Parent{
        
    }
    console.log('继承', new Child());// 继承 Child {name 'mukewang'}
    
}
```
继承传递参数 修改参数  
```javascript
{
    //继承传递参数
     class Parent{
        constructor(name='mukewang'){
            this.name = name;
        }
    }
    //使用 extends继承 
    class Child extends Parent{
        constructor(name='child'){
            super(name);
            
            //定义自己属性要用this 一定要用 super 的后边 
            this.type='child';
        }
    }
    console.log('继承', new Child('hello'));// 继承 Child {name： 'hello',type:'child'}
    
}
```

### getter,setter


```javascript
{
    //getter,setter
    class Parent{
        constructor(name='mukewang'){
            this.name = name;
        }
    }
    //属性 不是方法 
    get longName(){
        return 'mk'+this.name
    }
    set longName(value){
        this.name = value;
    }
    
    let v= new Parent();
    
    console.log('getter',v.longName);//getter mkmukewang 
    
    v.longName='hello';
    console.log('setter',v.longName); //setter mkhello
}

```
### 类的 静态方法


使用 **static** 关键词 后边加 **方法名称** 所以 就变成静态方法   **静态方法意思就是 通过 类去调用  而不是通过 类的实例去调用** 
```JavaScript
{
    //静态方法
    class Parent{
        constructor(name='mukewang'){
            this.name = name;
        }
    }
    //静态方法  使用 static 关键词 后边加 方法名称 所以 就变成静态方法   静态方法意思就是 通过 类去调用  而不是通过 类的实例去调用  
    static tell(){
        console.log('tell');
    }
    //调用 用类去调用 
    Parent.tell();//tell
}
```
#### 类的 静态属性


```javascript
{
    //静态属性
    class Parent{
        constructor(name='mukewang'){
            this.name = name;
        }
    }
    //静态方法 
    static tell(){
        console.log('tell');
    }
    //静态属性
    Parent.type='test';
    
    console.log('静态属性',Parent.type);// 静态属性 test 
}
```


