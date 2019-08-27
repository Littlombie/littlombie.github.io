---
title: 'nodejs创建http服务'
date: 2018-06-03 23:01:03
categories: nodejs
tags: [nodejs, http]
---
### 安装nodejs

window 进入[官网](http://nodejs.cn/)下载安装

检查版本

```
node -v
node --version
```

### 创建文件server.js

文件里边输入一下内容
<!--  more  -->

```JavaScript
// 创建http服务
var app = require('http').createServer(handler)
var fs = require('fs');
app.listen(2222);

function handler (req, res) {
  fs.readFile(__dirname + '/index.html',
  function (err, data) {
    if (err) {
      res.writeHead(500);
      return res.end('Error loading index.html');
    }

    res.writeHead(200,{'Content-Type':'text/html'});
    res.write('aaaaaaaaaaa');
    res.end(data);
  });
}
```

上边`app.listen(2222)`为监听端口，数字为了与默认端口冲突，尽量不要写 80

创建一个index.html 文件 ，fs读取文件 

完成后 在终端输入

```
node server.js 
```
打开浏览器 在地址栏里边输入`http://localhost:2222`

页面就会显示内容 HTML里边的内容

修改HTML文件或者server里边的配置，重新启动 node server.js 就会显示修改

### 安装supervisor 

为了防止我们每次修改文件后查看效果 都需要重启 服务 ，我们安装 supervisor  

```
npm install supervisor -g 
```

直接执行开启服务

```
supervisor server.js
```

我们就直接可以修改 刷新 ，无需重启服务 


