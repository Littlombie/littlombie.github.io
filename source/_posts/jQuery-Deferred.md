---
title: jQuery的deferred对象使用详解
date: 2017-06-16 17:41:00
categories: jQuery
tags: [jQuery,$.Deferred()]
---

### 什么是deferred对象？  

开发网站的过程中，我们经常遇到某些耗时很长的javascript操作。其中，既有异步的操作（比如ajax读取服务器数据），也有同步的操作（比如遍历一个大型数组），它们都不是立即能得到结果的。    
通常的解决方法是，为它们指定回调函数（callback）。即事先规定，一旦它们运行结束，应该调用哪些函数。  
但是，在回调函数方面，jQuery的功能非常弱。为了改变这一点，jQuery开发团队就设计了`deferred`对象。  
简单说，`deferred`对象就是jQuery的回调函数解决方案。 在英语中，defer的意思是"延迟"，所以deferred对象的含义就是"延迟"到未来某个点再执行。  
它解决了如何处理耗时操作的问题，对那些操作提供了更好的控制，以及统一的编程接口。它的主要功能，可以归结为四点。下面我们通过示例代码，一步步来学习。  

<!-- more -->
### ajax操作的链式写法

jQuery的ajax操作，传统写法是这样的：
```

　　$.ajax({

　　　　url: "test.html",

　　　　success: function(){ 
　　　　　　alert("哈哈，成功了！"); 
　　　　},

　　　　error:function(){ 
　　　　　　alert("出错啦！"); 
　　　　}

　　});
　　
```
在上面的代码中，`$.ajax()`接受一个对象参数，这个对象包含两个方法：`success`方法指定操作成功后的回调函数，`error`方法指定操作失败后的回调函数。

`$.ajax()`操作完成后，如果高于`1.5.0`版本，返回的是`deferred`对象，可以进行链式操作。

新的写法是这样的：

```

　　$.ajax("test.html")

　　.done(function(){ alert("哈哈，成功了！"); })

　　.fail(function(){ alert("出错啦！"); });
```
可以看到，`done()`相当于success方法，`fail()`相当于error方法。采用链式写法以后，代码的可读性大大提高。

### 指定同一操作的多个回调函数

`deferred`对象的一大好处，就是它允许你自由添加多个回调函数。

还是以上面的代码为例，如果ajax操作成功后，除了原来的回调函数，我还想再运行一个回调函数，怎么办？

很简单，直接把它加在后面就行了。

```
　　$.ajax("test.html")

　　.done(function(){ alert("哈哈，成功了！");} )

　　.fail(function(){ alert("出错啦！"); } )

　　.done(function(){ alert("第二个回调函数！");} );
```

回调函数可以添加任意多个，它们按照添加顺序执行。

### 为多个操作指定回调函数

`deferred`对象的另一大好处，就是它允许你为多个事件指定一个回调函数，这是传统写法做不到的。

请看下面的代码，它用到了一个新的方法`$.when()`：
```
　　$.when($.ajax("test1.html"), $.ajax("test2.html"))

　　.done(function(){ alert("哈哈，成功了！"); })

　　.fail(function(){ alert("出错啦！"); });
```


这段代码的意思是，先执行两个操作`$.ajax("test1.html")`和`$.ajax("test2.html")`，如果成功了，就运行`done()`指定的回调函数；如果有一个失败或都失败了，就执行`fail()`指定的回调函数。

### 普通操作的回调函数接口（上）

`deferred`对象的最大优点，就是它把这一套回调函数接口，从ajax操作扩展到了所有操作。也就是说，任何一个操作----`不管是ajax操作还是本地操作，也不管是异步操作还是同步操作----都可以使用deferred对象的各种方法`，指定回调函数。

我们来看一个具体的例子。假定有一个很耗时的操作wait：
 ```

　　var wait = function(){

　　　　var tasks = function(){

　　　　　　alert("执行完毕！");

　　　　};

　　　　setTimeout(tasks,5000);

　　};
```
我们为它指定回调函数，应该怎么做呢？

很自然的，你会想到，可以使用$.when()：
```
　　$.when(wait())

　　.done(function(){ alert("哈哈，成功了！"); })

　　.fail(function(){ alert("出错啦！"); });
```
但是，有一个问题。`$.when()`的参数只能是`deferred`对象，所以必须对wait进行改写，所以我们需要手动新建一个deferred对象：
```
　　var dtd = $.Deferred(); // 新建一个deferred对象

　　var wait = function(dtd){

　　　　var tasks = function(){

　　　　　　alert("执行完毕！");

　　　　　　dtd.resolve(); // 改变deferred对象的执行状态

　　　　};

　　　　setTimeout(tasks,5000);

　　　　return dtd.promise();//返回promise对象

　　};
```
这里有两个地方需要注意。

首先，最后一行不能直接返回`dtd`，必须返回`dtd.promise()`。原因是jQuery规定，任意一个deferred对象有三种执行状态----未完成，已完成和已失败。如果直接返回`dtd`，`$.when()`的默认执行状态为"已完成"，立即触发后面的`done()`方法，这就失去回调函数的作用了。`dtd.promise()`的目的，就是保证目前的执行状态----也就是"未完成"----不变，从而确保只有操作完成后，才会触发回调函数。

其次，当操作完成后，必须手动改变`Deferred`对象的执行状态，否则回调函数无法触发。`dtd.resolve()`的作用，就是将dtd的执行状态从"未完成"变成"已完成"，从而触发`done()`方法。

最后别忘了，修改完`wait`之后，调用的时候就必须直接传入`dtd`参数。
```
　　$.when(wait(dtd))

　　.done(function(){ alert("哈哈，成功了！"); })

　　.fail(function(){ alert("出错啦！"); });
```


上面的代码有一些问题，就是`dtd对象是暴露在全局的`，所以我们可以通过在全局进行`dtd.resolve()`来提前回调。

为了避免这种情况，jQuery提供了deferred.promise()方法，它的作用是，在原来的deferred对象上返回另一个deferred对象，后者只开放与改变执行状态无关的方法（比如done方法和fail方法）屏蔽与改变执行状态有关的方法（比如resolve和reject方法）。

```
var dtd = $.Deferred(); // 新建一个Deferred对象
var wait = function(dtd){

    var tasks = function(){

        alert("执行完毕！");

        dtd.resolve(); // 改变Deferred对象的执行状态

    };

    setTimeout(tasks,5000);

    return dtd.promise(); // 返回promise对象

};

var d = wait(dtd); // 新建一个d对象，改为对这个对象进行操作

$.when(d)

    .done(function(){ alert("哈哈，成功了！"); })

    .fail(function(){ alert("出错啦！"); });

d.resolve(); // 此时，这个语句是无效的
```
当然，我们也可以把dtd包在函数内：
```
var wait = function(dtd){
    var dtd = $.Deferred(); //在函数内部，新建一个Deferred对象
    var tasks = function(){
        alert("执行完毕！");
        dtd.resolve(); // 改变Deferred对象的执行状态
    };
    setTimeout(tasks,5000);
    return dtd.promise(); // 返回promise对象
};

$.when(wait())
    .done(function(){ alert("哈哈，成功了！"); })
    .fail(function(){ alert("出错啦！"); });
```
### 普通操作的回调函数接口（中）

除了使用`$.when()`为普通操作添加回调函数，还可以使用deferred对象的建构函数`$.Deferred()`。

这时，wait函数还是保持不变，我们直接把它传入$.Deferred(),完整代码：

``` javascript
　　　var wait = function(dtd){

　　　　var tasks = function(){

　　　　　　alert("执行完毕！");

　　　　　　dtd.resolve(); // 改变Deferred对象的执行状态

　　　　};

　　　　setTimeout(tasks,5000);

　　　　return dtd.promise();

　　};

　　$.Deferred(wait)

　　.done(function(){ alert("哈哈，成功了！"); })

　　.fail(function(){ alert("出错啦！"); });
　　
```

jQuery规定，`$.Deferred()`可以接受一个函数作为参数，该函数将在`$.Deferred()`返回结果之前执行。并且，`$.Deferred()`所生成的Deferred对象将作为这个函数的默认参数。

### 普通操作的回调函数接口（下）

除了上面两种方法以外，我们还可以直接在wait对象上部署deferred接口。

``` javascript
　　var dtd = $.Deferred(); // 生成Deferred对象

　　var wait = function(dtd){

　　　　var tasks = function(){

　　　　　　alert("执行完毕！");

　　　　　　dtd.resolve(); // 改变Deferred对象的执行状态

　　　　};

　　　　setTimeout(tasks,5000);

　　};

　　dtd.promise(wait);

　　wait.done(function(){ alert("哈哈，成功了！"); })

　　.fail(function(){ alert("出错啦！"); });

　　wait(dtd);

```

这里的关键是`dtd.promise(wait)`这一行，它的作用就是在wait对象上部署Deferred接口。正是因为有了这一行，后面才能直接在wait上面调用`done()`和`fail()`。


### 小结：deferred对象的方法

前面已经讲到了deferred对象的多种方法，下面做一个总结：

*  $.Deferred()生成一个deferred对象。

* deferred.done()指定操作成功时的回调函数

* deferred.fail()指定操作失败时的回调函数

* deferred.promise()没有参数时，作用为保持deferred对象的运行状态不变；接受参数时，作用为在参数对象上部署deferred接口。

* deferred.resolve()手动改变deferred对象的运行状态为"已完成"，从而立即触发done()方法。

* $.when()为多个操作指定回调函数。

  除了这些方法以外，deferred对象还有三个重要方法，上面的教程中没有涉及到。

* deferred.then()

  有时为了省事，可以把done()和fail()合在一起写，这就是then()方法。
```
　　$.when($.ajax( "/main.php" ))

　　.then(successFunc, failureFunc );
```
   如果then()有两个参数，那么第一个参数是done()方法的回调函数，第二个参数是fail()方法的回调方法。如果then()只有一个参数，那么等同于done()。

* deferred.reject()

  这个方法与deferred.resolve()正好相反，调用后将deferred对象的运行状态变为"已失败"，从而立即触发fail()方法。

* deferred.always()

  这个方法也是用来指定回调函数的，它的作用是，不管调用的是deferred.resolve()还是deferred.reject()，最后总是执行。

```
    $.ajax( "test.html" )

　　.always( function() { alert("已执行！");} );
```



* 本文转自网络，侵删。