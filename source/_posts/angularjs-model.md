---
title: AngularJS的模块化实现
date: 2017-12-26 00:00:17
categories: Angularjs 
tags: [Angularjs,路由,模块,依赖注入]
---

### AngularJS的模块化实现



![image](https://littlombie.github.io/images/post/model.jpg)

<!-- more -->
```html
<div ng-sctroller='helloModule'>
<p>{{greeeing.text}},Angular</p>
</div>
```


```javascript
//定义一个模块
var helloModule = angular.module('helloAngular', []);//创建个匿名函数
//创建 controller 控制器 $scope表示告诉angular把$scope注入到里边
helloModule.controller('helloNgCtrl',['$scope',function($scope){
    $scope.greeting = {
        text:'hello'
    }
}])
```

一个完整的项目   

![一个完整的项目](https://littlombie.github.io/images/post/6632454249863766400.png)






![image](https://littlombie.github.io/images/post/2608147134218969088.png)


模块之间的依赖    

比如下边：

```javascript
var bookStoreApp = angular.module('bookStoreApp',[
'ngRoute','ngAnimate','bookStoreCtrls','bookStoreFilters','bookSXtoreServices','bookStoreDirectives'
])
```

然后再HTML中作为启动点开始引用：


```html
<html ng-app="bookStoreApp">
```

### 指令系统


```html
<html ng-app='MyModule'>
    <body>
        //定义一个自定义标签 浏览器不识
        <hello></hello>
    </body>
</html>
```
js代码
```javascript
var MyModule = angular.module('MyModule', []);

MyModule.directive('hello',function(){
    return {
        restrict:'E',//模式为属性模式
        template:'<div>Hi everyone !</div>',//模板
        replace:true//表示可ui替换HTML相对应的标签
    }
}])
```
