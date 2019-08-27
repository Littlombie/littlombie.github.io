---
title: 自动化构建工具-Gulp
date: 2017-09-29 23:25:41
categories: web
tags: gulp
---


### 为什么要自动化

自动化是把源码合并压缩，合并之后就能减少http请求 ，压缩后能减少带宽，这是移动端十分需要的

### 自动化工具：gulp.js

优点：基于流、任务化

常用的API：src dest watch task pipe 
* src ：读取文件和文件夹
* dest：生成文件
* watch：监控文件
* task：定制任务 
* pipe：流的方式处理文件 

官网： [www.gulpjs.com.cn](http://www.gulpjs.com.cn)
<!-- more -->
### 安装gulp

全局安装gulp

```
cnpm install gulp -g
```

初始化文件 

```
cnpm init
```
当前目录 安装gulp

```
cnpm install --save-dev gulp
```


安装gulp插件   


![安装gulp插件](http://littlombie.github.io/images/post/6632257437282781793.jpg)

可以 批量安装 插件之间空格   

```
cnpm  install  --save-dev gulp-clean gulp-concat gulp-connect gulp-cssmin gulp-imagemin gulp-less gulp-load-plugins gulp-uglify open
```
#### gulp.js搭建环境

创建文件`gulpfile.js`:

```javascript
var gulp = require('gulp');
var $ = require('gulp-load-plugins')();
var open = require('open');

var app = {
    srcPath: 'src/',
    devPath: 'build/',
    prdPath: 'dist/'
}

// 放置依赖
gulp.task('lib', function() {
    // 读取文件
    gulp.src('bower_components/**/*.js')
        // 拷贝文件到：
        .pipe(gulp.dest(app.devPath + 'vendor')) //生产目录
        .pipe(gulp.dest(app.prdPath + 'vendor'))//代码上线发布目录
        .pipe($.connect.reload()); //自动刷新
})
```
然后运行：

```
gulp lib
```

就会出现两个文件夹 `build` `dist` ,里边是编译的文件


#### 编译html：
先创建个文件夹 **src>index.html 、 src>view>main.html**

在gulpfile.js里边添加

```javascript
gulp.task('html', function() {
    gulp.src(app.srcPath + '**/*.html')
        .pipe(gulp.dest(app.devPath))
        .pipe(gulp.dest(app.prdPath))
        .pipe($.connect.reload());
});
```
然后再运行

```
gulp html
```

然后src里边的HTML文件会编译到`dist/buile`中

#### json文件

json 跟上边HTML一样，在src中创建一个data文件，里边书写json文件

`gulpfile.js`里边添加

```javascript
gulp.task('json', function() {
    gulp.src(app.srcPath + 'data/**/*.json')
        .pipe(gulp.dest(app.devPath + 'data'))
        .pipe(gulp.dest(app.prdPath + 'data'))
        .pipe($.connect.reload());
});
```
在执行`gulp json`就会在build dist 里边出现json文件

#### 编译less 文件

首先在src下创建文件`src>style>index.less` ， `src>style>main.less`  
`index.less` 为主要文件 里边引入外部需要的文件，    
index.less:

```less
@import 'main.less';
```
main.less:

```less
@color:#fff;
a {
   color:@color; 
}
```

编译的时候只编译`index.less`文件 ，
然后再配置文件`gulpfile.js`里边添加：

```javascript
gulp.task('less', function() {
    gulp.src(app.srcPath + 'style/index.less')
        // 在此设置编译 less为css
        .pipe($.less())
        .pipe(gulp.dest(app.devPath + 'css'))
        // 在此处设置压缩css文件
        .pipe($.cssmin())
        .pipe(gulp.dest(app.prdPath + 'css'))
        .pipe($.connect.reload());
});
```
执行命令`gulp less` 就会在build里边看到编译出来为css文件 和dist里边出现的css压缩文件
####  js文件
创建两个js文件 src>script>1.js src>script>2.js  
里边写一些简单测试代码 
在gulpfile.js里边添加

```javascript
gulp.task('js', function() {
    gulp.src(app.srcPath + 'script/**/*.js')
        // 合并js文件
        .pipe($.concat('index.js'))
        .pipe(gulp.dest(app.devPath + 'js'))
        //压缩js
        .pipe($.uglify())
        .pipe(gulp.dest(app.prdPath + 'js'))
        .pipe($.connect.reload());
});
```
然后执行`gulp js`，发现在build 和dist文件家中出现了script>index.js


#### image文件

图片的步骤跟上边的差不多， 
最后还有个压缩图片 

```javascript
gulp.task('image', function() {
    gulp.src(app.srcPath + 'image/**/*')
        .pipe(gulp.dest(app.devPath + 'image'))
        // 压缩图片
        .pipe($.imagemin())
        .pipe(gulp.dest(app.prdPath + 'image'))
        .pipe($.connect.reload());
});
```
执行`gulp image`

**为了不让每次的编译的文件重复硬性 ，就要配置一个清除**


```javascript
// 清除重复的文件
gulp.task('clean', function() {
    gulp.src([app.devPath, app.prdPath])
        .pipe($.clean())
});

```
然后每次`build` `dist` 文件会被删除  等待重新编译  

我们每次看效果都需要先清除之前的，然后在一个个打包编译，这样很麻烦，所以我们就需要一个指令，只需要每次执行一次 就可以把所有的任务都执行了  如下：

#### build
```javascript
// 总任务，构建任务 打包时只要执行下边就行 
gulp.task('build', ['image', 'js', 'less', 'lib', 'html', 'json']);
```
执行`gulp build `

#### 构建本地服务器，自动刷新
这样还不够 ，我们需要的是只要执行一次， 就能直接在浏览器里查看效果  而且每次更改代码自动的会编译 ，浏览器会自动刷新。

首先得先创建一个本地访问的服务器 


```javascript
// 启动服务器 本地环境 
gulp.task('serve', ['build'], function() {
    $.connect.server({
        root: [app.devPath],
        livereload: true, //针对高级浏览器，每次代码的更改 会自动的刷新浏览器
        port: 1234 //端口
    });
    open('http://localhost:1234'); //浏览url

    gulp.watch('bower_components/**/*.js', ['lib']);
    gulp.watch(app.srcPath + '**/*.html', ['html']);
    gulp.watch(app.srcPath + 'data/**/*.json', ['json']);
    gulp.watch(app.srcPath + 'style/index.less', ['less']);
    gulp.watch(app.srcPath + 'script/**/*.js', ['js']);
    gulp.watch(app.srcPath + 'image/**/*', ['image']);
});
```

这个服务器需要设置本地`url`,端口 还需要每次刷新的文件，它调用的`build` 来执行，这样就实现了本地的服务搭建！

然后我们还可以在简单一些：

```javascript
gulp.task('default', ['serve']);
```

安装gulp-plumber插件

```
cnpm install --save-dev gulp-plumber
```
这个插件的作用一旦是 css，js编译的时候发生错误时 ，自动化不会停止

然后在gulpfile.js下每个编译 的task里边都添加 

```
.pipe($.blumer())
```


接着直接执行`gulp`，服务器自动打开，浏览器会自动的打开页面，然后修改的文件无需刷新马上就可以在浏览器里查看，这样我们的构建环境就搭完了 ！
