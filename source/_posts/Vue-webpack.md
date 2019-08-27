---
title: '基于webpack和Vue搭建基础开发环境'
date: 2017-04-24 18:15:24
categories: web
tags: [web,Vue,webpack]
---


### 安装nodejs

  windows可以直接下载，
  下载链接：https://nodejs.org/zh-cn/  
  
  下载完后查看版本：
  ```bash
  node --version
  ```
  确认版本在6.0以上
  
  为了下载速度更快，可以选择安装[淘宝 NPM 镜像](http://npm.taobao.org/)`cnpm`。
  
* 注：以下命令有全局标志-g

    
### 安装 Vue  

   这里我们选择Vue版本为2.2.6  
   ```bash
   $ npm install vue@2.2.6
   ```
 
<!--  more  -->
### 安装vue-cli

   vue-cli 是vue.js的脚手架，用于自动生成vue.js模板工程的。
   ```bash
    #全局安装 vue-cli
    $ npm install --global vue-cli
   ```
### 创建项目 

   创建一个基于 webpack 模板的新项目my-project

   ```bach
   $ vue init webpack my-project
   ```
### 进入项目目录

   ```bash
   #进入项目目录
   $ cd my-project
   ```
### 安装依赖

  安装依赖模块
   ```
   # 安装依赖
   $ npm install
   ```
* #### 给生产环境装的依赖    
   
```bash
$ npm install vuex vue-router axios qs --save

```

安装vue运行依赖  
1.[vuex](https://vuex.vuejs.org/zh-cn/intro.html)  
2.[vue-router](https://router.vuejs.org/zh-cn/)  
3.[axios ](https://github.com/imcvampire/vue-axios)  
4.[qs]()   

   
* #### 给开发环境安装的依赖    
  安装sass预编译环境
  
```
npm install node-sass sass-loader --save-dev
```

1.node-sass  
2.sass-loader  


### 运行项目
   ```
   # 运行项目
   $ npm run dev
   ```

之后页面会出现以下界面，恭喜你，项目环境搭建成功!

![vue](http://littlombie.github.io/images/post/vue-webpack.png)    

然后就可以在这开始我们的项目了