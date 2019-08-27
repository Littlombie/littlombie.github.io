---
title: 'webpack项目流程学习（一）'
date: 2017-04-10 12:53:01
categories: web
tags: [web,webpack]
---

<img src="/images/post/what-is-webpack.png" class="full-image" alt='webpack' />

## 前言

>前端开发和其他开发工作的主要区别，首先是前端是基于多语言、多层次的编码和组织工作，其次前端产品的交付是基于浏览器，这些资源是通过增量加载的方式运行到浏览器端，如何在开发环境组织好这些碎片化的代码和资源，并且保证他们在浏览器端快速、优雅的加载和更新，就需要一个模块化系统，这个理想中的模块化系统是前端工程师多年来一直探索的难题。

## 什么是 Webpack
Webpack 是一个模块打包器。它将根据模块的依赖关系进行静态分析，然后将这些模块按照指定的规则生成对应的静态资源。

<!-- more -->
## 学习 Webpack
本文只是本人webpack学习时所做的简单笔记，围绕这个[视频](http://www.imooc.com/learn/802)所作，笔记是以项目的方式记录；仅供参考！  

### 项目开始
* 新建文件夹  

```
mkdir <your name>
```
* 进入文件夹  

```
cd <your name>
```

* 格式化   

```
npm init
```

* 下载安装 webpack

本地安装    

```
npm install webpack --save-dev
```


### 创建项目文件 

创建文件`index.html`  

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>webpac demo</title>
  </head>
  <body>
<script type="text/javascript" src="bundle.js"></script>
  </body>
</html>

```
里边添加`bundle.js` 的js 文件

创建 测试文件main.js 

然后创建配置文件 `webpack.config.js`， 配置入口`entry`，输出`output`

```javascript
module.exports = {
  context:__dirname,//当前目录
  entry:'./src/script/main.js',
  output:{
    path:'./dist/js',
    filename:'bundle.js'
  }
}

```
然后在终端输入`webpack`就会在`dist/js`文件夹下生成`bundle.js`文件

配置文件的名字 建议为默认的`webpack-config.js`,方便执行（其他名称执行命令为`webpack <配置文件名称>`）  

为了以后执行命令方便 可以在`package.json`中做配置

```json
"scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "webpack": "webpack --config webpack.config.js --progress --display-modules --colors --display-reasons"
  },
```
scripts中添加一项 `"webpack"`的配置

* entry 可以为数组 
```
entry:['./src/script/main.js','./src/script/a.js'],
```
最后打包的文件都会在bundle.js 中显示

`entry` 为对象时， `output` 的`filename` 可以用占位符 `[name]`,`[hash]`,`[chunkhash]`;



*  安装插件  
 
```
npm install html-webpack-plugin --save-dev
```
配置文件简历插件引用 

```
var htmlWebpackPlugin = require('html-webpack-plugin');
```
* 添加插件   
  在moudle.exports中添加  

```
  plugins:[
    new htmlWebpackPlugin({
      telmplate:'index.html'
    })
  ]
```

这样我们更改根目录的index.html文件执行  就会在`dist/js`下边生成个index.html文件 里边的js都自动引入进来了   
但是我们工作中 index.html 都是在根目录下的 所以要更改文件的生成路径

在 output下边 修改   
```
  output:{
    path:'./dist',
    filename:'js/[name]-[chunkhash].js'
  },
```
 这样 就会得到想要的结果 js的路径也只在js文件夹下
 
 如果想要js 文件放在html的head
 
 可以在plugin里边添加
 ```
 inject:'head'
 ```
 
 我们可以设置一些参数 比如`title`，详见webpack 官网 的`plugin` 配置
 
 也可以书写js ，如`date:new Date()`
 
 html里边书写插件
 ```html
  <title><%=htmlWebpackPlugin.options.title %></title>
  
  <p><%=htmlWebpackPlugin.options.date %></p>
 ```
 
 插入js 
 
 ```
    <script type="text/javascript" src="<%= htmlWebpackPlugin.files.chunks.a.entry %> "></script>
 ```
 
 html 中可以书写js 模板文件的方式遍历  查找完整的配置参数 文件 也可以到`npm` 官网上去查看插件的详细信息 （在npm 搜索框里边输入 插件名称 进行查看 ）
 ```html
<body>

   <!--js 模板文件的方式遍历  -->
    <%=htmlWebpackPlugin.options.date %>
    <!-- 直接运行js代码 -->
    <% for(var key in htmlWebpackPlugin.files) {%>
    <%= key %>:<%=JSON.stringify(htmlWebpackPlugin.files[key]) %>
    <%}%>
    
    <% for(var key in htmlWebpackPlugin.options) {%>
    <%= key %>:<%=JSON.stringify(htmlWebpackPlugin.options[key]) %>
    <%}%>
</body>
 ```
 
 
 
 打包后文件上线 ，使用output 新属性 `publicPath`,设置发布后的统一路径
 
plugin配置里边可以添加`minify`设置压缩的参数

```javascript
minify:{
    removeComments:true,
    collapseWhitespace:true
    
}
```
 
 文件压缩 `minify`设置压缩的参数  详见 [html-minifier](https://github.com/kangax/html-minifier/#options-quick-reference)
 
 
 
 ### 生成多个页面
 
 
 entry 中添加 引入的 js文件 
 
 ```javascript
   entry:{
      main:'./src/script/main.js',
      a:'./src/script/a.js',
      b:'./src/script/b.js',
      c:'./src/script/c.js'
    },
 ```
 
 与之对应的，在配置文件plugin 下添加 制定`chunks`
 
 ```javascript
 plugins:[
    new htmlWebpackPlugin({
      filename:'a.html',
      template:'index.html',
      inject:'body',
      title:'webpack is good a',
      chunks:['main','a']
    }),
    new htmlWebpackPlugin({
      filename:'b.html',
      template:'index.html',
      inject:'body',
      title:'webpack is good b',
      chunks:['b']
    }),
    new htmlWebpackPlugin({
      filename:'c.html',
      template:'index.html',
      inject:'body',
      title:'webpack is good c',
      chunks:['c']
    })
  ]
 ```
 
 也可以除了`xx.js`的文件，其余的都引用
 
 可以在plugin下边修改chunks 为
 ```javascript
 excludeChunks['b','c']
 ```
 表示生成文件中除了 b.js,c.js 其他的文件都生成并在HTML中导入 
 
 
 减少http请求  js
 
可以使用 `js inline`  到HTML中 

找到不需要publicPath 的路径

```html
  <script type="text/javascript">
    <%=htmlWebpackPlugin.files.chunks.main.entry.substr(htmlWebpackPlugin.files.publicPath.length) %>
  </script>
```
 
 取到里边的内容 修改上边代码  
 
 ```html
 <script type="text/javascript">
    <%=compilation.assets[htmlWebpackPlugin.files.chunks.main.entry.substr(htmlWebpackPlugin.files.publicPath.length)].source() %>
  </script>
 ```
 
 这样 main.js里边的文件就会inline在 HTML中 
 
 
 
 如果 我们只让 main.js文件inline  其他 js 文件 引入 则需要在HTML文件中 循环一下 
 
 ```html
   <% for(var k in htmlWebpackPlugin.files.chunks){ %>
      <%if(k !=='main'){ %>
          <script type="text/javascript" src="<%= htmlWebpackPlugin.files.chunks[k].entry %>">

          </script>
          <% }%>
    <%}%>
 ```
 
 把插件 plugin 的 `inject` 改为`'body'`, 引入的文件就会显示在HTML的body 底部
  
  
  
  <iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=330 height=86 src="//music.163.com/outchain/player?type=2&id=28613251&auto=1&height=66"></iframe>