---
title: ES6学习（7）- 函数扩展
date: 2019-08-21 00:49:05
categories: ES6
tags: [ES6,javascript ]
---
### 参数默认值

函数参数里边直接赋默认值，但是可以被重新赋值
```JavaScript
{
  function test(x, y = 'world'){
    console.log('默认值',x,y);
  }
  test('hello');
  test('hello','kill');
}

```
<!-- more -->
强调：默认值的后边不能再有没有默认值的变量，比如在`y = 'world'`后边添加个参数`c`，这样就会报错，如果写成`c = 'www'`这样是可以的 


作用域 
```JavaScript
{
  let x='test';
  function test2(x,y=x){
    console.log('作用域',x,y);//kill kill
  }
  test2('kill');
}

```
如果` test2()`不赋值，那么输出为`undefined undefined`；但是如果把第一个参数`x`变为`c`，那么输出的值为 `kill test`，它会把上边x的值给`y` 

### rest参数

...;作用是把一系列的参数转换为一个数组

```
{
  function test3(...arg){
    for(let v of arg){
      console.log('rest',v);//rest 1,rest2,rest 3,rest 4,rest a,
    }
  }
  test3(1,2,3,4,'a');
}
```
注意rest参数之后就不能有其他参数 

### 扩展运算符

rest的逆运算
把数组拆成了离散的值

```
{
  console.log(...[1,2,4]);//1,2,4
  console.log('a',...[1,2,4]);//a,1,2,4
}
```

### 箭头函数 =>

先看下边箭头函数的代码：
```
{
  let arrow = v => v*2;
  let arrow2 = () => 5;
  console.log('arrow',arrow(3));//arrow 6
  console.log(arrow2());//5

}
```
上边第一个函数 的`arrow`为函数名，第二个`v`表示函数的参数；第三个`=>`后边的表示执行的函数;第二个函数，如果箭头函数没有参数时 就写个`()`


### this绑定
箭头函数中`this`的指向，指函数在定义是的指向的所在，

ES5是函数在调用的时候的指向

注意作`this`绑定的时候要看特性，有事可用，有时勿用

### 尾调用

尾调用存在于函数式编程的里边,主要能提升性能，主要针对函数嵌套 
```
{
  function tail(x){
    console.log('tail',x);
  }
  function fx(x){
    return tail(x)
  }
  fx(123)// tail 123
}

```
