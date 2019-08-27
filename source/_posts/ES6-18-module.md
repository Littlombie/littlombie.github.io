---
title: ES6学习（18）- Module模块化
date: 2019-08-21 01:09:52
categories: ES6
tags: [ES6,javascript ]
---
### 基本概念



### ES6 的模块化语法 
<!-- more -->

``` js
//导出用export 变量

export let A = 123;

//导出函数
export function test(){
    console.log('test');
}

//导出类

export class Hello{
    test(){
        console.log('class');
    }
}
```

在需要导入文件中写法 


``` js
//花括号中需要哪项就 导入哪项 
import {A,test,Hello} form `./${js路径}`

console.log(A,test,Hello);
```
第二种写法
``` js
{
    import * as lesson form `./${js路径}`
    
    console.log(lesson.A,lesson.test);
}
```


### 另一种写法 

需要导出的文件：

``` js
let A = 123;
let test = function(){
    console.log('class');
}
class Hello{
    test(){
        console.log('class');
    }
}

//书写需要导出的类 变量  类
export default{
    A,
    test,
    Hello
}
```

导入文件：

``` js
import lesson form '${js路径}'

console.log(lesson.A,lesson.test);
```


