---
title: 【AngularJS】解决ng-if中的ng-model值无效的问题
date: 2017-12-25 23:29:37
categories: Angularjs 
tags: [Angularjs,ng-model,ng-if]
---

与其他指令一样，`ng-if`指令也会创建一个子级作用域，因此，如果在`ng-if`指令中添加了元素，并向元素属性增加 `ng-model`指令，那么`ng-model`指令对应的作用域属性子级作用域，而并非控制器注入的`$scope`作用域对象，这点在进行双向数据绑定时，需要引起注意。

<!-- more -->

```html
<!DOCTYPE html>    
<html ng-app="myApp">    
<head>    
<meta charset="UTF-8">    
<script src="http://cdn.static.runoob.com/libs/angular.js/1.4.6/angular.min.js"></script>    
<style>  
  .frame{  
    padding: 5px 8px;  
    margin: 0px;  
    font-size: 12px;  
    width: 320px;  
    background-color: #eee;  
  }  
  .frame div{  
    margin: 5px 0px;  
  }  
</style>   
</head>    
<body>    
  <div ng-controller="myCtrl" class="frame">  
    <div>  
      a 的值： {{a}}  <br>  
      b 的值： {{b}}  
    </div>  
    <div>  
      普通方式： <input type="checkbox" ng-model="a">  
    </div>  
    <div ng-if="!a">  
      ngIf方式：<input type="checkbox" ng-model="$parent.b">  
    </div>  
  </div>  
  
  <script>  
    angular.module('myApp', [])  
      .controller('myCtrl', function($scope){  
        $scope.a = false;  
        $scope.b = false;  
      })  
  </script>  
</body>    
</html>    
```

在`ng-if`方式中，每个包含的元素都拥有自己的作用域，因此，复选框元素也拥有自己的`$scope`作用域。相对于控制器作用域来说，这个作用域属于一个子级作用域，所以，如果它想绑定控制器中的变量值，必须添加`$parent`标识，只有这样才能访问到控制器中的变量。  

因此，解决`ng-if`中`ng-model`值无效的问题，主要方法就是在绑定值时添加`$parent`标识，或者用`ng-show`指令代替`ng-if`指令，这两种方法都可以达到同样的页面效果。

* 文章来源[【AngularJS】解决ng-if中的ng-model值无效的问题】](http://blog.csdn.net/u013451157/article/details/60866210)