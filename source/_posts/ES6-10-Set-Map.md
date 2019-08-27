---
title: ES6学习（10）- set-map数据结构
date: 2019-08-21 00:54:44
categories: ES6
tags: [ES6,javascript ]
---


### Set的用法
1. 用法

set类似于数组，但是成员的值都是唯一的，没有重复的值。一般只是在set中检查某个值是否存在。  
set函数可以接受一个数组（或者具有iterable接口的其他数据结构）作为参数，用来初始化。  
当做数组去用 Set 集合中的元素是不能重复的  


``` js
{
 //声明普通的变量 
  let list = new Set();
  //添加两个元素
  list.add(5);
  list.add(7);
  
  //长度 .size
  console.log('size',list.size);//size 2
}

```
<!-- more -->
Set 初始化的时候就把元素初始化进去

``` js
{
  let arr = [1,2,3,4,5];
  let list = new Set(arr);

  console.log('size',list.size);//size 5 
}
```
Set 数据元素必须是唯一的,不能重复 

``` js
{
  let list = new Set();
  list.add(1);
  list.add(2);
  list.add(1);
  
  //添加重复的元素不会添加进去的  ，也不会报错 
  console.log('list',list); //list 1 ,list 2

  let arr=[1,2,3,1,'2'];
  let list2=new Set(arr);

 //不会做数据类型的转化
  console.log('unique',list2);//unique Set{1,2,3,'2'} 成功的过滤掉重复的元素 但是后边的字符串 ‘2’ 也输出了 
  
  //通过new Set（）去重，然后转换为数组
  let arrs =[1,2,3,4,1,3,"tre"];
  let sets = new Set(arrs);
  Array.from(sets) //[1,2,3,4,"tre"]
}
```

Set 的使用方法 
- **list.add()**，数组中添加元素
- **list.deledte()**， 数组中移除元素
- **list.clear()**，数组中清空元素
- **list.has()** ，数组中判断有无元素 

``` js
{
  let arr=['add','delete','clear','has'];
  let list=new Set(arr);

  console.log('has',list.has('add'));
  console.log('delete',list.delete('add'),list);
  list.clear();
  console.log('list',list);
}

```

Set 实例的遍历 （读取）

``` js
{
  let arr=['add','delete','clear','has'];
  let list=new Set(arr);

  //用 for... of... 遍历
  for(let key of list.keys()){
    console.log('keys',key);// keys add, keys delete,keys clear,keys has 
  }
  for(let value of list.values()){
    console.log('value',value);// keys add, keys delete,keys clear,keys has 打印出来跟上边的一样  都是 元素的名称 
  }
  
  for(let value of list){
    console.log('value',value);// keys add, keys delete,keys clear,keys has 直接遍历list也是也可的  值跟上边的一样 
  }
  
  for(let [key,value] of list.entries()){
    console.log('entries',key,value);//打印出了 entries and and ,entries delete delete, entries clear clear, entries has has
  }
  //foreach 遍历 返回  item // and delete clear has 
  list.forEach(function(item){console.log(item);})
}
```

### WeakSet的用法


WeakSet 与 Set的比较 
- WeakSet 跟Set的支持数据类型不一样，  WeakSet只是必须是**对象** 不能是 **数值** **字符串** 
- WeakSet 是**弱引用**，不会检测这个对象在其他地方用过 ，不会检测器其是否在垃圾回收掉 
- 没有clear 方法 
``` js

{
  //生成weakSet变量  
  let weakList=new WeakSet();

  let arg={};

  weakList.add(arg);

  // weakList.add(2); // 不支持其他的类型 只能是对象

  console.log('weakList',weakList); //weakList wekSet {Object{}}
}
```



### Map的用法
key 可以是任意的类型  数字 字符串  
```
{
  let map = new Map();
  let arr=['123'];
  // Map() 添加元素用 .set()不是 .add()
  map.set(arr,456);

  console.log('map',map,map.get(arr));// map Map{["123"]=>456} 456 
}
```


``` js

{
  let map = new Map([['a',123],['b',456]]);
  console.log('map args',map); // a=>123 b=>456
  console.log('size',map.size);//2 
  console.log('delete',map.delete('a'),map);//b=>456
  console.log('clear',map.clear(),map); //map{}
}
```

### WeakMap的用法

weakMap 与Map 跟 WeakSet 与 Set的 的区别一样  
``` js

{
  let weakmap=new WeakMap();

  let o={};
  weakmap.set(o,123);
  console.log(weakmap.get(o));//123
}
```
