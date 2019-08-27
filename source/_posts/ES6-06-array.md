---
title: ES6学习（6）- 数组扩展
date: 2019-08-21 00:48:48
categories: ES6
tags: [ES6,javascript ]
---


### Array.of()

Array.of()把一组数据变量转换成数据类型,如果里边不传任何参数，那么输出的就是一个空数组
```javascript
{
  let arr = Array.of(3,4,7,9,11);
  console.log('arr=',arr);//[3,4,7,9,11]

  let empty=Array.of();
  console.log('empty',empty);//[]
}
```
### Array.from()

Array.from() 把一些伪数组、集合转换为数组；为了演示这个功能 需要在在HTML里边添加几个标签
<!-- more -->
```HTML
<p>张三</p>
<p>李四</p>
<p>王五</p>

```
因为p是一个集合，需要把它转换为数组 
```javascript
{
  let p=document.querySelectorAll('p');
  let pArr=Array.from(p);
  pArr.forEach(function(item){
    console.log(item.textContent);//item.textContent；textContent 原生js获取dom节点文本内容的方法、属性
  });


 //类似于Map()的映射的作用
  console.log(Array.from([1,3,5],function(item){return item*2}));//[2,6,10]
}
```
上边的Array.from()有两个参数，第一个为数组，第二个就相当于map 的作用，把里边每个元素都乘以2

### Array.fill() 填充数组
把数组内部的值全部替换成需要的值

``` js
{
  console.log('fill-7',[1,'a',undefined].fill(7));//[7,7,7]
  
  //第一个参数表示替换的内容，第二个表示替换的起始位置，第三个参数为换的长度
  console.log('fill,pos',['a','b','c'].fill(7,1,3));
}

```

### .keys()，.values()，.entries()

1. `.keys()` 返回所有数组的下标（索引）
2. `.values()`  返回数组的值 （现在存在兼容性问题，需要插件polylily）
3. `.entries()` 既能取到索引，也能取到值

``` js
{
  for(let index of ['1','c','ks'].keys()){
    console.log('keys',index);//0,1,2
  }
  for(let value of ['1','c','ks'].values()){
    console.log('values',value);//1,c,ks
  }
  
  for(let [index,value] of ['1','c','ks'].entries()){
    console.log('values',index,value);// values 0 1 , values 1 c, values 2 ks
  }
}
```
### .copyWithin() 

有三个参数；第一个参数为从那个位置开始替换，第二个值为读取数据的位置，第三个值为截至位置 
(使用频率不高)

``` js
{
  console.log([1,2,3,4,5].copyWithin(0,3,4));//[4,2,3,4,5]
}

```

### .find()，.findIndex()

查找 
1. `.find()` 内部可以写条件，只找出符合条件的第一个就停止查找了 
2. `.findIndex()` 返回 找出符合条件的下标（索引）

``` js
{
  console.log([1,2,3,4,5,6].find(function(item){return item>3}));//4
  console.log([1,2,3,4,5,6].findIndex(function(item){return item>3}));//3
}

```
### .includes()

判断数组中是否包含某个值

``` js
{
  console.log('number',[1,2,NaN].includes(1));//number true 说明数组中包含1，也没有判断数组中有NaN 
  console.log('number',[1,2,NaN].includes(NaN)); //number true  表示NaN也能找到  
}

```
