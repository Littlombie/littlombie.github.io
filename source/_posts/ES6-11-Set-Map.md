---
title: ES6学习（11）- map-set与数组和对象的比较
date: 2019-08-21 00:56:40
categories: ES6
tags: [ES6,javascript ]
---

### Map 与Array的对比
<!-- more -->

```javascript
{
    //数据结构的横向对比 增、删、改、查
    let map = new Map();
    let array=[];
    
    //增
    map.set('t',1);
    array.push({t:1});
    
    console.info('map-array',map,array);
    
    //查
    let map_exist = map.has('t');
    let array_exist =array.find(item=>item.t);
    
    console.info('map-array',map_exist,array_exist);//true Object{t:1} 第一个返回的事布尔值  第二个直接返回对象 
    
    //改
    map.set('t',2);
    //通过数组的forEach遍历，看数组中是否存在该值 ，如果存在 ，改变其值，如果不存在 ，返回空
    array.forEach(item=>item.t?item.t=2:''); 
    
    console.info('map-array-modify',map,array); //Map(1){'t',2}  
    
    
    //删
    map.delete('t');
    let idnex = array.findIndex(item=>item.t);
    array.splice(index,1);
    
    console.info('map-array-empty',map,array);//  Map(0) {} 
}
```

### Set 与Array的对比


```javascript
  
 {
    //set和array 的对比
    let set = new Set();
    let array =[];
   
    //增
    set.add({t:1});
    array.push({t:1});
   
    console.info('set-array',set,array); //Set(1)  {Object {t:1}}
   
    //查
    let set_exist = set.has({t:1});
    let array_exist =array.find(item=>item.t);
    
    console.info('set-array',set_exist,array_exist);//false 
    
    //改
    set.forEach(item =>item.t?item.t=2:'');
    array.forEach(item =>item.t?item.t=2:'');
    
    console.info('set-array-modefy',set_exist,array_exist);// Set(1) Object{t:2}
    
    //删
    set.forEach(item=>item.t?set.delete(item):'');
    let index = array,findIndex(item=>item.t);
    arr.splice(index,1);
    
    console.info('set-array-empty',set,array);// Set(0) {}
 }

```

### Map , Set , Object 的对比


```javascript
{
    //Map,Set ,Objec 对比 
    let item= {t:1};
    let map = new Map();
    let set = new Set();
    let obj = {};
    
    //增
    map.set('t':1);
    set.add(item);
    obj['t']=1;
    
    console.info('map-set-obj',map,set,obj);//Map(1){"t"=>1} set(1) {Object{t:1}} Object{t:1}
    
    //查
    console.info({
        map_exist:map.has('t');
        set_exist:set.has(item);
        obj_exist:'t' in obj
    });//map_exist:true;set_exist: true;obj_exist:true
    
    //改
    map.set('t',2);
    item.t=2;
    obj['t']=2;
    
    console.info('map-set-obj-modify',map,set,obj);//Map(1){'t'=>2} Set(1) {Object {t:2}} Object {t:2}
    
    //删
    map.delete('t');
    set.delete(item);
    delete obj['t'];
    
    console.log('set-array-empty',map,set,obj);//Map(0)  Set(0)  Object {}
     
}
```
通过上边的对比 ，可以看出：  
**对于复杂的数组结构，优先使用Map，如果要求 数组的唯一性，则使用Set()，在数据的存储中尽量使用 Map,而放弃使用 Object 和数组**
