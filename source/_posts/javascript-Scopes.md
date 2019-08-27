---
title: javascript--函数及作用域总结介绍
date: 2017-07-19 23:21:10
categories: javascript
tags: javascript
---


本文是对javascript在的函数及作用域进行了详细的总结介绍，需要的朋友可以过来参考下，希望对大家有所帮助  
在js中使用函数注意三点：

1、函数被调用时，它是运行在他被声明时的语法环境中的；  
2、函数自己无法运行，它总是被对象调用的，函数运行时，函数体内的this指针指向调用该函数的对象，如果调用函数时没有明确指定该对象， this 默认指向 window ( strict 模式除外，本文不涉及 strict 模式)；  
3、函数是一种带有可执行代码的对象类型数据。
### 声明函数
* 1、使用 function 关键字
复制代码代码如下:  

```javascript
function myfun(a,b){ //声明名为myfun的函数
return a+b;
} 
```
<!--  more  -->
* 2、 声明匿名函数

```javascript
function(a,b){
    return a+b;
}
```
匿名函数自身是无法保存的，由于在js中函数是一种对象型数据，因此可以把匿名函数赋给变量来保存。
```javascript
var myfun = function(a,b){ 
    return a+b;
}
```
* 3、使用函数构造器Function //注意首字母大写  
Function 是js内置的一个函数，他是所有函数对象的构造器。（其他数据对象也有自己的内置构造函数，比如Number，Object等，这些构造函数自己的构造器就是Function，因为他们都是函数）。  
```javascript
var myfun = new Function('a,b','return a+b;');
```
其中最后一个参数是函数体，前面的参数都是函数的形式参数名，个数不定，因为需要用字符串传参来构造，函数较长时这种写法很不方便，一般很少用，也许你会用它来构造特定的返回值从而取代 eval函数。  
需要注意的是，全局变量和全局函数都可以看作window对象的属性，如果存在同名的函数和变量，只能有一个生效(实际上只有一个属性)，试试下面的代码。  
复制代码代码如下:
```javascript
function a(){ 
    alert('a');
}
alert(window.a);  //访问window对象的属性也可以省去window不写
var a=1;
alert(window.a); 
```
函数和变量的声明都发生在代码解析期，不同的是，变量在解析期只声明不赋值，因此，同一个作用域内存在同名的函数和变量时，在代码运行期执行到变量赋值之 前，同名函数生效，同名变量赋值之后(用新的数据覆盖了该window对象属性原有的值)，变量生效(但是要注意，在firefox 下， 在 with 伪闭包内声明的函数，只能在声明之后才能被调用，即，firefox 的 with 内没有对函数预先声明)。  
复制代码代码如下:
```javascript
with({}){ 
    a();  //在 firefox 下 a 是未声明
    function a(){ 
        console.log("function a is called")
    } 
} 
```
如果同名称的函数被多次声明，后面声明的将覆盖前面声明的，如：  
复制代码代码如下:
```javascript
alert(func1);//弹出func1(){alert(2);}
func1(){
    alert(1);
}
alert(func1);  //弹出func1(){alert(2);}
func1(){  //这是最后一次声明的func1，以该函数为准
    alert(2);
}
alert(func1);  //弹出func1(){alert(2);}
var func1 = function(){  //注意 ，这里是变量赋值，不是函数声明
    alert(3);
}
alert(func1);  //弹出function(){alert(3);} 
```
除了 IE8 及IE8以下的浏览器，表达式中的函数声明都会返回匿名函数，不会成功声明具名函数  
复制代码代码如下:
```javascript
if(function fun(){}){
   alert(fun); // error，不会成功声明名称为 fun 的函数，但在IE8及以下的浏览器中中会成功声明一个函数 fun
}
(function fun(){ });
alert(fun); //error但是即使在 IE8 一下， 表达式中的具名函数也不能覆盖该作用于下同名的变量：
var fun = 1; //该变量不能被函数表达式中的函数名覆盖
var f = function fun(){};
alert(f); //function fun(){};
alert(fun); //1 
```
注意区别：
```javascript
if(fun = function (){}){
   alert(fun); // ok，这里声明了一个变量，该变量保存了一个匿名函数
}
//js函数是引用型的对象
var a = function(){};
var b=a;
b.x=2;
alert(a.x); //2
```
### 函数的参数
js函数不会检查函数调用时传入的参数个数与定义他时的形式参数个数是否一致，一般地，js函数调用时可以接收的参数个数为25个，当然不同的浏览器可能有差异，ECMAScript标准对这一点并没有规范。  
如果你不确定函数调用时传入了多少个参数，可以使用函数的arguments对象。
arguments 有点像数组，arguments.length 为传入的参数个数，arguments[0] 是第一个参数，arguments[1]是第二个参数，类推...  
函数对象的length属性：这个属性很少用到，甚至很少人知道，函数的length属性就是该函数定义时的形式参数个数。  
复制代码代码如下:
```javascript
function myfun(a,b){
    alert(arguments.length);  //弹出调用时实际传入的参数个数
    alert(arguments[0]); //对应参数a
    return a+b;
}
alert(myfun.length);   //形参个数，2 
```
arguments对象还有其他属性，比如常用的arguments.callee ，指向该函数自身。  
**要注意**：如果函数内部声明了与形参同名的子函数（同域内，变量未赋值时同名函数生效），arguments 的相应值也会被修改，但是，在作用域内使用 var 声明了同名的 变量则不会导致 arguments 的参数值被函数替换（但firefox 依然替换）。  
复制代码代码如下:
```javascript
function aa(a , b,c){ //js 群的一道题
    function a(){}

    console.log(a); //function a 
    console.log(aa);

    //如果作用域内没有 var a ,则 arguments[0] 为 function a (friefox(version 17) 则一定是function a)
    console.log(arguments[0]); 
    var a = "ee";  //注销此句，考擦 arguments[0] 将变为 a 函数
    var aa = "444";
    arguments = 6;
    console.log(a);
    console.log(aa);
    console.log(arguments);
}
aa(1,2,3); 
```
### 函数的返回值

js函数使用 return 语句返回值。  
一切数据类型都可以作为函数的返回值(包括函数)，js函数也可以没有返回值。  
### 四、函数调用
函数自己是不会运行的，当它运行时，总是存在一个调用它的对象。  
默认情况下，在任何语法环境中，如果没有显式指定函数的调用对象，就是指通过window对象来调用该函数，此时，函数体内的this指针指向window对象。  
复制代码代码如下:
```javascript
function myfun(a,b){
    alert(this);
    return a+b;
}
myfun(1,2); // 调用函数并传入2个参数，这2个参数分别对应形式参数a,b调用函数时，如果传入的参数个数超过形式参数，就只有用arguments加下标来接收了。 
```
由于没有显式指定调用函数的对象，alert(this)将弹出 window对象。这种调用方法是最常见的。  
用于显式指定函数的调用对象方法有三个：  
* 1、如果一个函数被赋为一个对象的属性值，这个函数只能通过该对象来访问（但并非是说该函数只能被该对象调用），通过该对象调用这个函数的方式类似以面向对象编程语言中的方法调用(实际上在js中也习惯使用方法这种称呼)。
复制代码代码如下:  

```javascript
var obj={}; //定义一个对象
obj.fun=function(a,b){
alert(this); //弹出this指针
return a+b;
} //对象属性值为函数
alert(obj.fun);// 访问fun函数。 只能通过该对象来访问这个函数
obj.fun(1,2);  //通过obj对象来调用fun函数，将弹出obj对象。这种方式也称为调用obj对象的fun方法。 
```
* 2、 任意指定函数的调用对象：在某个语法环境中，如果可以同时访问到函数fun和对象obj，只要你愿意，可以指定通过obj对象来调用fun函数。  
指定方法 有2种：call方法和apply方法。(因为window对象是浏览器环境下的顶级对象，在任何语法环境中都能访问到window对象，因此，任何函数 都可以通过window对象来调用)  
复制代码代码如下:

```javascript
function fun(a,b){
    alert(this);
    return a+b;
}
var obj={};
fun.call(obj,1,2);   //通过obj对象来调用fun函数，并传入2个参数，弹出的指针为obj对象。
 
var obj2={};
obj2.fun2 = function(a,b){ //obj2对象的属性fun2是一个函数
    alert(this);
    return a+b;
};
obj2.fun2.call(obj,1,2);   //通过obj对象来调用obj2对象的fun2属性值所保存的函数，弹出的this指针是obj对象
//比较隐蔽的方法调用：数组调用一个函数[9,function(){ alert(this[0]); }][1]();
//使用window对象调用函数下面几种方法是等价的
fun(1,2);
window.fun(1,2);  //如果fun函数是全局函数
fun.call(window,1,2);
fun.call(this,1,2);  //如果该句代码在全局环境下（或者被window对象调用的函数体内），因为该语法环境下的this就是指向window对象。
func.call(); //如果函数不需要传参
func.call(null,1,2);
func.call(undefined,1,2);var name = "window";
function kkk(){
    console.log(this.name); // not ie
}
kkk(); //window
kkk.call(kkk); //kkk 函数被自己调用了 
```
另一种比较容易疏忽的错误是，在A 对象的方法中，执行了使用了 B 对象的方法调用，试图在 B 对象的方法里使用 this 来访问 A 对象，这在各种回调函数中比较常见，最常见的情形就是 ajax 回调函数中使用 this 。  
复制代码代码如下:
```javascript
var obj = {
   data:null,
   getData:function(){
        $.post(url,{param:token},function(dataBack){ //jQuery ajax post method
            this.data = dataBack; //试图将服务器返回的数据赋给 obj.data ,但这里的 this 已经指向 jQuery 的 ajax 对象了
        },'json');   
   }
}
//正确做法
var obj = {
   data:null,
   getData:function(){
        var host = this; //保存 obj 对象的引用
        $.post(url,{param:"token"},function(dataBack){
            host.data = dataBack;
        },'json');   
   }
} 
```
* 3、apply方法调用：
apply方法与call方法唯一不同的地方是函数传参方式不同。  
`obj2.fun2.call(obj,1,2);`  
改为 apply方式就是  
`obj2.fun2.apply(obj,[1,2]);`  
apply使用类数组方式传参，除数组外，还可以使用arguments、HTMLCollection来传参，但arguments并非数组，如：

```javascript
var obj={};
function fun_1(x,y){
   function fun_2(a,b){
     return a+b;
  }
fun_2.apply(obj,arguments);  //用fun_1的arguments对象来传参，实际上是接收了x,y
}
```
apply 传参在IE8 及IE8一下的浏览器中哟2个问题
在 call 和 apply 调用中，如果传入标量数据(true/false ，string，number)，函数运行时将把他们传入的基本数据包装成对象，然后把this指向包装后的对象,试试下面的代码。 
```javascript
function a(){
    alert(typeof this);
    alert(this.constructor);
    alert(this);
}
a.call(false);
a.call(100);
a.call('hello');
//甚至可以用这个特点来传参数，但是不建议这种用法：
function a(){  alert(1+this); } //对象在运算中自动进行类型转换
a.call(100); //101
```
* 4、函数作为对象构造器  
当函数使用 new 运算作为对象构造器运行时，this 指向新构造出对象，如果该构造函数的返回值不是 null 以外的对象，构造函数运行完毕将返回 this 指向的对象,否则返回原定义的对象。  
复制代码代码如下:

```javascript
function Fun(){
    this.a = 1;
    this.b = 3;
    console.log(this); //{a:1,b:2}
    // return {a:999};  //加上此举 ,将返回 {a:999}
}
var obj = new Fun();  //obj = {a:1,b:2} ，如果没有参数，也可以写成 var obj = new Fun; 
```
### 函数作用域
js的变量作用域是函数级的，在js里没有类似c语言的块级作用域。  
js编程环境的顶级作用域是window对象下的范围，称为全局作用域，全局作用域中的变量称为全局变量。  
js函数内的变量无法在函数外面访问，在函数内却可以访问函数外的变量，函数内的变量称为局部变量。  
js函数可以嵌套，多个函数的层层嵌套构成了多个作用域的层层嵌套，这称为js的作用域链。  
js作用域链的变量访问规则是：如果当前作用域内存在要访问的变量，则使用当前作用域的变量，否则到上一层作用域内寻找，直到全局作用域，如果找不到，则该变量为未声明。  
注意，变量的声明在代码解析期完成，如果当前作用域的变量的声明和赋值语句写在变量访问语句后面，js函数会认为当前作用域已经存在要访问的变量不再向上级作用域查找，但是，由于变量的赋值发生的代码运行期，访问的到变量将是undefined.  
如：
复制代码代码如下:  

```javascript
var c=1000;
function out(){
    var a=1;
    var b=2;
    function fun(){
        alert(a); //undefined
        var a=10;
        alert(a); //10
        alert(b); //2
        alert(c); //1000
    }
    fun();
}
out(); 
```
### 匿名函数的调用
匿名函数的使用在js很重要，由于js中一切数据都是对象，包括函数，因此经常使用函数作为另一个函数的参数或返回值。  
如果匿名函数没有被保存，则运行后即被从内存中释放。  
匿名函数的调用方式一般是直接把匿名函数放在括号内替代函数名。如：  
```javascript
(function(a,b){ 
    return a+b;
})(1,2); //声明并执行匿名函数，运行时传入两个参数：1和2
//或者
(function(a,b){ 
    return a+b;
}(1,2));
//下面这种写法是错误的：
function(a,b){ 
    return a+b;
}(1,2); 
由于js中语句结束的分号可以省略，js引擎会认为`function(a,b){ return a+b;}`是一句语句结束，因此匿名函数只声明了没有被调用，如果语句没有传参(1,2)写成()，还会导致错误，js中空括号是语法错误。  
下面这种写法是正确的。
var  ab = function(a,b){ 
    return a+b;
}(1,2);  // ab=3
```
js 解析语法时，如果表达式出现在赋值运算或操作符运算中，是"贪婪匹配"的(尽量求值)

```javascript
function(t){ 
    return 1+t;
}(); //error
var f = function(t){ 
    return t+1;
}(); // ok
~ function(t){return t+1;}();  //ok
+ function(t){return t+1;}(); //ok
```
如果你只是想把一个匿名函数赋给一个变量，记得在赋值语句后面加上分号，否则，如果后面跟了小括号就变成了函数调用了，尤其是小括号与函数结尾之间分隔了多行时，这种错误往往很难发现。
实际开发中，匿名函数可能以运算值的方式返回，这种情况可能不容易看出，比如
```javascript
var a =1;
var obj = {a:2,f:function(){ 
    return this.a;
}};
(1,obj.f)(); //1 
```
逗号表达式反悔了一个匿名函数，当这个匿名函数被调用时,函数体内的 thsi 指向 window
声 明并立即运行匿名函数被称为”自执行函数“，自执行函数经常用于封装一段js代码。      由于函数作用域的特点，自执行函数内的变量无法被外部访问，放在函数内 的代码不会对外面的代码产生影响，可以避免造成变量污染。   js开发很容易造成变量污染，在开发中经常引入其他编码人员开发的代码，如果不同的编码人员定义 了同名称不同含义的全局变量或函数，便造成了变量污染，同一作用域内出现同名的变量或函数，后来的将覆盖前面的。  
```javascript
(function(){
   //自己的代码.....
})();
```
匿名函数还可以使内存及时释放：因为变量被声明在匿名函数内，如果这些变量没有在匿名函数之外被引用，那么这个函数运行完毕，里面的变量所占据的内存就会立即释放。
函数的name：在firefox等浏览器，函数有一个name属性，就是该函数的函数名，但是这个属性在IE中不存在，另外，匿名函数的name为空值。
```javascript
var a=function(){}
alert(a.name); //undefined，a是一个存储了一个匿名函数的变量
function b(){}
alert(b.name); //b ,but undefined for IE
```
### 函数被调用时，运行在他被定义时的环境中
无论函数在哪里被调用，被谁调用，都无法改变其被声明时的语法环境，这决定了函数的运行环境  
复制代码代码如下:
```javascript
var x=99;
var inerFun=null;
function fun1(){
    alert(x);
}
function holder(){
    var x = 100;
    var fun2 = fun1;
    inerFun = function(){ alert(x);}
    fun1(); //99
    fun2();//99
    inerFun(); //100
}
holder();
fun1(); //99
inerFun(); //100
 
 //另一个例子：
var x = 100;
var y=77;
var a1={
    x:99,
    xx:function(){
        //var y=88;  //如果注释这个变量，y将是全局变量的77
        alert(y); //没有使用this指针，调用函数的对象无法影响y的值，函数运行时将从这里按作用域链逐级搜索取值
        alert(this.x);  //使用了 this 指针，调用函数的
    }
}
a1.xx();
a1.xx.call(window);
var jj = a1.xx;
jj(); //效果跟a1.xx.call(window); 一样//试试下面代码
var x=99;
function xb(){
    this.x=100;
    this.a = (function(){
        return this.x
    }).call(this); //new 的时候执行了,匿名函数被 实例化的对象 调用
    this.b = (function(){
        return this.x
    })(); //new 的时候执行了,匿名函数被window调用
    this.method = function(){
        return this.x;
    }
}

var xbObj = new xb();
console.log(xbObj.x);
console.log(xbObj.a);
console.log(xbObj.b);
console.log(xbObj.method()); 
```
注意区分调用函数的对象、函数声明时的语法环境、函数调用语句的语法环境这几个概念  
1、调用函数的对象(或者说函数的调用方式)决定了函数运行时函数体内的this指针指向谁  
2、函数声明时的语法环境决定了函数运行时的访问权限  
3、函数调用语句的语法环境决定了函数是否真的能够被调用及何时被调用(只有函数在某个语法环境是可见的，这个函数才能被调用)  
函数在运行时，产生一个 arguments 对象可以访问传入函数内的参数,arguments 有一个属性可以指向函数自身：arguments.callee.  
函数运行时，函数的 caller 属性可以指向本函数调用语句所在函数，比如，a函数在b函数体内被调用，则当a函数运行时，a.caller就指向了b函数，如果a 函数在全局环境中被调用则 a.caller=null
arguments 和a.caller 的值与函数的每一次调用直接关联，他们都是在函数运行时产生的，只能在函数体内访问。  
IE8及IE8以下浏览器中，a 函数的内的 `arguments.caller`( IE9之后这个属性被移除) 指向 `a.caller `执行时的 `arguments （arguments.caller.callee === a.caller）`，
### 字符串实时解析中的函数调用：

`eval()、new Function()、setTimeout()、setInterval()`
`eval() 与 window.eval()`  
复制代码代码如下:
```javascript
function a(){
    console.log('out of b');
}
function b(){
    function a(){ console.log("in b"); }
    var f = function(){ a(); };
    eval('a()'); // in b
    window.eval('a()'); //out of b ,ie 6\7\8 in b, ie 9 out of b
    (new Function('a();'))(); //out of b
    setTimeout('a()',1000);   // out of b 
    setTimeout(f,2000);// in b
}
b(); 
```
eval() 中的代码执行于eval() 语句所处的作用域内：  
复制代码代码如下:  
```javascript
var Objinit = function(){
  var param = 123;
  return {
          execute:function(codes){
                eval(codes);
          },
          setCallback:function(f){
               this.callback = f;
          },
          fireCallback:function(){
               this.callback && this.callback.call(this);
          },
         getParam:function(){
             return param;
         }
    }
};
var obj = Objinit ();
var param = 'outerParam';
console.log(param,obj.getParam()); //outerParam 123
obj.execute('param = 456');
console.log(param,obj.getParam()); //outerParam 456
obj.setCallback(function(){ eval("param = 8888")});
obj.fireCallback();
console.log(param,obj.getParam()); //8888 456
obj.setCallback(function(){ eval("eval(param = 9999)")});
obj.fireCallback();
console.log(param,obj.getParam()); //9999 456eval() 
```
字符串中解析出的代码运在 `eval` 所在的作用域，`window.eval()` 则是运行在顶级作用域（低版本 chrome 和 低于IE9 则同 `eval()`）.
IE 中 ，`window.execScript()`;  相当于 `window.eval()`
`new Function()`、`setTimeout()`、`setInterval() ` 的第一个字符串参数所解析得到的代码，都是在顶级作用域执行。  
### 函数闭包
要理解函数闭包，先了解 js 的垃圾自动回收机制。 
`number`、`string`、`boolean`、`undefined`、`null` 在运算和赋值操作中是复制传值，而对象类型的数据按引用传值，
js 的同一个对象型数据可能被多次引用，如果某个对象不再被引用，或者两个对象之间互相引用之外不在被第三方所引用，浏览器会自动释放其占用的内存空间。  
函数被引用：函数被赋为其他对象的属性值，或者函数内部定义的数据在该函数外被使用，闭包的形成基于后一种情形。  
复制代码代码如下:
```javascript
var f;
function fun(){
    var a =1;
    f = function(){ return ++a;};
}
fun(); //产生一个闭包
f(); //  闭包中 a=2
f(); // 闭包中 a =3  ，模拟静态变量 
```
在 fun 内 声明的匿名函数赋给 fun 外的变量 f，该匿名函数内使用了在 fun 内声明的变量 a，于是 f可以访问 变量 a，为了维持这种访问权限(f执 行时需要访问a，但何时执行未定)， fun() 执行完毕产生的变量 a 不能被释放（除非f 中的函数被释放），于是产生了一个闭包（变量 a 被封 闭了，供 f 使用）。  
产生闭包的关键是，一个在函数 A内的声明的函数 B被传出 A 之外，并且 B 函数内使用了在 函数A 内生成的数据（声明或按值传参）,
函数B传出函数A之外的方式有多种，如：  
复制代码代码如下:
```javascript
function fun(){    
    var a =1;
    return {a:123,b:456, c: function(){ return ++a;} };
}
var f = fun();
f.c(); //a=2 
```
广义上来说，函数运行时都会形成闭包，没有数据在函数外被引用时，闭包的生命周期很短：函数执行完毕即释放。  
闭包的独立性：即使由同一个函数产生的多个闭包也是相互独立的  
复制代码代码如下:
```javascript
function fun(){
    var a =1;
    return function(){ return ++a;};
}
var f1 =  fun(); //一份闭包
var f2 = fun(); //另一份闭包
alert(f1()); //2
alert(f1()); //3
alert(f2()); //2
alert(f2()); //3 
```
这两份闭包中的变量 a 是不同的数据，每产生一份闭包， fun() 执行了一次，  变量声明语句也执行了一次。  
js oop 编程中闭包可以用于模拟私有成员、构造单体类  
复制代码代码如下:
```javascript
function MakeItem(name,val){
    var myName,myVal; //私有属性
    //私有方法
    function setName(name){
        myname=name; 
    }
    //私有 方法
    function setVal(val){
        myVal=val;
    }
    //执行new构造对象时调用内部私有方法 
    setName(name);
    setVal(val);
    //公共方法
    this.getName=function(){ 
        return myName; 
    }
    this.getVal=function(){ 
        return myVal;
    }
}
var obj = new MakeItem("name",100);
obj.myname; //undefined 无法在外面访问私有属性
obj.getName(); //ok 
```
下面是一种单体类构建方法  
复制代码代码如下:
```javascript
var Singleton = (function(){
    var instance = null; //在闭包中保存单体类的实例
    var args = null;
    var f = function(){
        if(!instance){
            if(this===window){               
               args = Array.prototype.slice.call(arguments,0);               
                instance = new arguments.callee();
            }else{
               this.init.apply(this,args||arguments);
                instance = this;
            }
        }
        return instance;
    };
    f.prototype = {
        init:function(a,b,c){
            this.a = a;
            this.b = b;
            this.c = c;      
            this.method1 = function(){ console.log("method 1"); };
            this.method1 = function(){ console.log("method 1"); };
            console.log("init instance");
        }
    };
    f.prototype.constructor = f.prototype.init;
    return f;
 
})();

//单体的使用
var obj1 =  Singleton(1,2,3);
var obj2 = new Singleton();
var obj3 = new Singleton();
console.log(obj1===obj2,obj2===obj3); //true
console.log(obj1);
//一个单体类声明函数
var SingletonDefine= function(fun){
    return (function(){
        var instance = null;
        var args = null;      
        var f = function(){
            if(!instance){
                if(this===window){
                    args = Array.prototype.slice.call(arguments,0);                   
                    instance = new arguments.callee();
                }else{
                    fun.apply(this,args||arguments);                   
                    instance = this;
                }
            }
            return instance;
        };
 
        f.prototype = fun.prototype;
        f.prototype.constructor = fun;            
        return f;
    })();
};
var fun = function(a,b,c){
    this.a = a;
    this.b = b;
    this.c = c;
    this.method1 = function(){ console.log("method 1"); };
    console.log("init instance");
};
fun.prototype.method2 = function(){ console.log('method 2'); };

//单体类声明函数用法
var Singleton = SingletonDefine(fun);
var obj1 =  Singleton(8,9,10);
var obj2 = new Singleton();
var obj3 = new Singleton(3,2,1);
console.log(obj1===obj2,obj2===obj3);
console.log(obj1);
//console.log(obj1.toSource()); //firefox
obj1.method1();
obj1.method2(); 
```
IE6 的内存泄露与闭包
在IE 6 中，非原生js对象（DOM 等）的循环引用会导致内存泄露，使用闭包时如果涉及非 js 原生对象引用时要注意。  
```javascript
function fun(){
    var node = document.getElementById('a');
    node.onclick = function(){ alert(node.value); 
};
node = null; //打断循环引用防止内存泄露
```
`node` 保存的是 `DOM` 对象，`DOM`对象存在于` fun` 之外(并且一直存在，即使删除也只是从文档树移出)，fun 执行后产生闭包，也构成DOM对象与回调函数的循环引用（`node-function-node`），在IE 6 下发生内存泄露。
***
您可能感兴趣的文章:

###### 关于javascript 回调函数中变量作用域的讨论  
###### JavaScript的变量作用域深入理解  
######  网易JS面试题与Javascript词法作用域说明  
###### JavaScript中的作用域链和闭包  
###### 深入Javascript函数、递归与闭包(执行环境、变量对象与作用域链)使用详解
###### 深入理解JavaScript高级之词法作用域和作用域链
###### 深入理解Javascript中this的作用域
###### 浅谈Javascript变量作用域问题
###### javascript作用域问题实例分析