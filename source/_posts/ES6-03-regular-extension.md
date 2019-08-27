---
title: ES6学习（3）- 正则扩展
date: 2019-08-20 18:35:25
categories: ES6
tags: [ES6,javascript ]
---

在 ES5 中，RegExp构造函数的参数有两种情况。
第一种情况是，参数是字符串，这时第二个参数表示正则表达式的修饰符（flag）。
``` js
{
 // #构造函数#
    let regex = new RegExp('xyz', 'i'); //第一个参数是字符串，第二个是修饰符
    let regex2 = new RegExp(/xyz/i); //第一个参数是正则表达式，不接受第二个参数，否则会报错
}
```
<!-- more -->
第二种情况是，参数是一个正则表示式，这时会返回一个原有正则表达式的拷贝
``` js
var regex = new RegExp(/xyz/i);
// 等价于
var regex = /xyz/i;
``` 
但是，ES5 不允许此时使用第二个参数添加修饰符，否则会报错。
```js
var regex = new RegExp(/xyz/, 'i');
// Uncaught TypeError: Cannot supply flags when constructing one RegExp from another
``` 
ES6 改变了这种行为。如果RegExp构造函数第一个参数是一个正则对象，那么可以使用第二个参数指定修饰符。而且，返回的正则表达式会忽略原有的正则表达式的修饰符，只使用新指定的修饰符。
```js
new RegExp(/abc/ig, 'i').flags   // "i"
```
上面代码中，原有正则对象的修饰符是ig，它会被第二个参数i覆盖。

ES6
``` js
{
  let regex3 = new RegExp(/abc/ig, 'i');
  console.log(regex3.flags); //原有正则对象的修饰符是ig，它会被第二个参数i覆盖
}
```
es6 允许 第一个参数为正则表达式，也有第二个参数，为修饰符，原有正则对象的修饰符是ig，所以它会被第二个参数i覆盖

[更多参考](http://es6.ruanyifeng.com/#docs/regex)

