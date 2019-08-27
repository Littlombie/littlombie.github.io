---
title: javascript中定义对象的几种方式
date: 2016-11-25 18:41:31
categories: javascript
tags: javascript
---

> JavaScript中没有类的概念，只有对象。  
> 在JavaScript中定义对象可以采用以下几种方式：  
> 1.基于已有对象扩充其属性和方法  
> 2.工厂方式  
> 3.构造函数方式  
> 4.原型(“prototype”)方式  
> 5.动态原型方式
 
 
### 基于已有对象扩充其属性和方法

```javascript
    var object = new Object();
    object.name = "zhangsan";
    object.sayName = function(name){
        this.name = name;
        alert(this.name);
    }
    object.sayName("lisi");
<<<<<<< HEAD
=======
    
>>>>>>> update hexo
````
这种方式的弊端：这种对象的可复用性不强，如果需要使用多个对象，还需要重新扩展其属性和方法。
 
 <!-- more -->
 
### 工厂方式

```javascript
function createObject(){
    var object = new Object();
    object.username = "zhangsan";
    object.password = "123";

    object.get = function(){
        alert(this.username + ", " + this.password);
    }
    return object;
}

var object1 = createObject();
var object2 = createObject();

object1.get();
````
 
* 改进一：采用带参数的构造方法：

```javascript
function createObject(username, password){
    var object = new Object();

    object.username = username;
    object.password = password;

    object.get = function(){
        alert(this.username + ", " + this.password);
    }

    return object;
}

var object1 = createObject("zhangsan", "123");

object1.get();
````
 
* 改进二：让多个对象共享函数对象  
这样，不用每个对象都生成一个函数对象。

```javascript

function get(){
    alert(this.username + ", " + this.password);
}
//函数对象只有一份
function createObject(username, password){
    var object = new Object();

    object.username = username;
    object.password = password;

    object.get = get; //每一个对象的函数对象都指向同一个函数对象return object;
}

var object = createObject("zhangsan", "123");
var object2 = createObject("lisi", "456");

object.get();
object2.get();
```

优点：让一个函数对象被多个对象所共享，而不是每一个对象拥有一个函数对象。  
缺点：对象和它的方法定义分开了，可能会造成误解和误用。
 
### 构造函数方式

构造函数的定义方法其实和普通的自定义函数相同。

```javascript
function Person(){
    //在执行第一行代码前，js引擎会为我们生成一个对象this.username = "zhangsan";
    this.password = "123";

    this.getInfo = function(){
        alert(this.username + ", " + this.password);
    } 
    //此处有一个隐藏的return语句，用于将之前生成的对象返回//只有在后面用new的情况下，才会出现注释所述的这两点情况
}

//生成对象var person = new Person();//用了new
person.getInfo(); 

```
* 改进版：加上参数：

```javascript

function Person(username, password){
    this.username = username;
    this.password = password;

    this.getInfo = function(){
    alert(this.username + ", " + this.password);
    }
}

var person = new Person("zhangsan", "123");
person.getInfo();

```
 
### 原型(“prototype”)方式

例子：
```javascript
function Person(){}

Person.prototype.username = "zhangsan";
Person.prototype.password = "123";

Person.prototype.getInfo = function(){
    alert(this.username + ", " + this.password);
}

var person = new Person();
var person2 = new Person();

person.username = "lisi";

person.getInfo();
person2.getInfo();
```
 
* 使用原型存在的缺点：
  * 1.不能传参数；
  * 2.有可能会导致程序错误。
 

如果使用原型方式来定义对象，那么生成的所有对象会共享原型中的属性，这样一个对象改变了该属性也会反映到其他对象当中。
单纯使用原型方式定义对象无法在构造函数中为属性赋初值，只能在对象生成后再去改变属性值。  
 比如，username改为数组后：

```javascript
function Person(){}

Person.prototype.username = new Array();
Person.prototype.password = "123";

Person.prototype.getInfo = function(){
    alert(this.username + ", " + this.password);
}

var person = new Person();
var person2 = new Person();

person.username.push("zhangsan");
person.username.push("lisi");
person.password = "456";

person.getInfo(); //输出：zhangsan,lisi, 456
person2.getInfo(); //输出：zhangsan,lisi, 123//虽然没有对person2对象进行修改，但是它的name和person是一样的，即为zhangsan,lisi
```
这是因为使用原型方式，person和person2指向的是同一个原型，即对应了同样的属性对象。  
对于引用类型(比如数组)，两个对象指向了同一个引用，所以对一个所做的更改会影响另一个。  
而对于字符串(字面常量值)，重新赋值之后就指向了另一个引用，所以二者的修改互不影响。  
 
 
* 对原型方式的改进：

使用原型+构造函数方式来定义对象，对象之间的属性互不干扰，各个对象间共享同一个方法。
```javascript

//使用原型+构造函数方式来定义对象
function Person(){
    this.username = new Array();
    this.password = "123";
}

Person.prototype.getInfo = function(){
    alert(this.username + ", " + this.password);
}

var p = new Person();
var p2 = new Person();

p.username.push("zhangsan");
p2.username.push("lisi");

p.getInfo();
p2.getInfo();

```
 
 
### 动态原型方式

在构造函数中通过标志量让所有对象共享一个方法，而每个对象拥有自己的属性。

```javascript

function Person(){
    this.username = "zhangsan";
    this.password = "123";

    if(typeof Person.flag == "undefined"){
        //此块代码应该只在第一次调用的时候执行
        alert("invoked");

        Person.prototype.getInfo = function(){
            //这个方法定义在原型中，会被每一个对象所共同拥有
            alert(this.username + ", " + this.password);
        }

        Person.flag = true;//第一次定义完之后，之后的对象就不需要再进来这块代码了
    }
}

var p = new Person();
var p2 = new Person();

p.getInfo();
p2.getInfo();
```
###### 文章来自网络，如有侵权请联系进行删除，谢谢