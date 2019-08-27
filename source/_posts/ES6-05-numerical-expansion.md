---
title: ES6学习（5）- 数值扩展
date: 2019-08-21 00:47:52
categories: ES6
tags: [ES6,javascript]
---
## ES6 的 数值扩展
<!-- more -->
``` js
{
  console.log('B',0B111110111);//503； 二进制都是以'0B'开头，大小写都可以，后边跟二进制数字
  console.log(0o767);//503 ；八进制是以'0o'开头后边跟八进制数字
}

{
  console.log('15',Number.isFinite(15));//15 true ;isFinite 判断有无群大；有尽 
  console.log('NaN',Number.isFinite(NaN));//NaN false
  console.log('1/0',Number.isFinite('true'/0));//1/0 false 
  console.log('NaN',Number.isNaN(NaN));//NaN ture 
  console.log('0',Number.isNaN(0));//0 false

}
// Number.isInteger 判断是不是整数 
{
  console.log('25',Number.isInteger(25));//25 ture
  console.log('25.0',Number.isInteger(25.0));//25.0 ture 
  console.log('25.1',Number.isInteger(25.1));//25.1 false 
  console.log('25.1',Number.isInteger('25'));//25.1 false 不是数字
}

{
  console.log(Number.MAX_SAFE_INTEGER,Number.MIN_SAFE_INTEGER);//9007199254740991,-9007199254740991 判断最大值 最小值
  console.log('10',Number.isSafeInteger(10));//ture 判断数是否安全范围的数
  console.log('a',Number.isSafeInteger('a'));//false 不为数
}
// Math.trunc(num) 判断带小数的整数部分 并返回
{
  console.log(4.1,Math.trunc(4.1));//4
  console.log(4.9,Math.trunc(4.9));//4
}
//Math.sign(num) 判断一个数到底为正数，负数，还是0
{
  console.log('-5',Math.sign(-5));//-5 -1
  console.log('0',Math.sign(0));//0 0
  console.log('5',Math.sign(5));//5 1
  console.log('50',Math.sign('50'));//50 1
  console.log('foo',Math.sign('foo'));//foo NaN (非数字)
}

// Math.cbrt(num)立方根的计算 
{
  console.log('-1',Math.cbrt(-1));// -1 -1
  console.log('8',Math.cbrt(8));//8 2
}

```