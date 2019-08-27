---
title: 关于跨域的一些理解
date: 2018-09-05 22:41:55
categories: http 
tags: [http,cross]
---
### 什么是跨域

#### 跨域:

浏览器对于javascript的同源策略的限制,例如a.cn下面的js不能调用b.cn中的js,对象或数据(因为a.cn和b.cn是不同域),所以跨域就出现了.  
上面提到的,同域的概念又是什么呢??? 简单的解释就是相同域名,端口相同,协议相同

#### 同源策略:

请求的url地址,必须与浏览器上的url地址处于同域上,也就是域名,端口,协议相同.  
比如:我在本地上的域名是xxx.cn,请求另外一个域名一段数据  
这个时候在浏览器上会报错:

<!-- more -->
```
Failed to load http:/xxx.cn/: No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'http://sss.com' is therefore not allowed access.
```
这个就是同源策略的保护,如果浏览器对javascript没有同源策略的保护,那么一些重要的机密网站将会很危险~

|   xxx.cn/json/jsonp/jsonp.html | | |
| --------   | -----:  | :----:  |
| 请求地址    |   形式  |  结果   |
| http://xxx.cn/test/a.html     | 同一域名,不同文件夹 |   成功   |
| http://xxx.cn/json/jsonp/jsonp.html  |  同一域名,统一文件夹   |   成功  |
|  http://a.xxx.cn/json/jsonp/jsonp.html  |   不同域名,文件路径相同    |  失败  |
|http://xxx.cn:8080/json/jsonp/jsonp.html | 同一域名,不同端口 | 失败|
| https://xxx.cn/json/jsonp/jsonp.html | 同一域名,不同协议 | 失败|


#### JS跨域

这里所说的JS跨域，指的是在处理跨域请求的过程中，技术面会偏浏览器端较多一些，一般是利用浏览器的一些特性进行hack处理，从而避开同源策略的限制。

#### JSONP

由于同源策略不会阻止动态脚本的插入到文档中去，所以催生出了一种很常用的跨域方式： JSONP(JSON with Padding)。

### 实例

创建三个文件

`server.js`
```
const http = require('http');
const fs = require('fs');

http.createServer(function (request,response) {
  console.log('request come', request.url);
  
  const html = fs.readFileSync('test.html','utf8');
  // response.writeHead(200, {
  //   'Content-Type': 'test/html'
  // });
  response.end(html);
}).listen(8888);

console.log ('server listening on http://localhost:8888');
```
`server2.js`
```
const http = require('http');

http.createServer(function (request,response) {
  console.log('request come', request.url);
 
 
}).listen(8887);

console.log ('server listening on http://localhost:8887');
```

`test.html`

```
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>Page Title</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
  <div>
    ppppp
  </div>
  <script>
    var xhr = new XMLHttpRequest();
    xhr.open('GET','http://127.0.0.1:8887/');
    xhr.send();
  </script>
</body>
</html>
```

同时启动 `server.js` `server2.js` 服务

然后按照上面代码 使用 `server.js` 启动 `test.html` 页面  但是 `test.htm`页面 发送一个`http请求` 请求的 服务器为端口` 8887` ,也就是 `server2.js` 服务  
 
 此时页面上会提示 跨域
```
Failed to load http://127.0.0.1:8887/: No 'Access-Control-Allow-Origin' header is present on the requested resource. Origin 'http://localhost:8888' is therefore not allowed access.
```


我们的解决方法就是

- 在server2.js 页面 http.createServer 的装添加一下页面
```
 response.writeHead(200, {
    'Access-Control-Allow-Origin': '*'
  })
  response.end('123');
```
上边的 ` 'Access-Control-Allow-Origin': '*'` 表示 允许跨域的 域名 ，`*`表示 允许一切url的跨域 ，如果只是允许 某个网站访问数据 就可以直接 写网站域名 

 - 使用jsonp的方式解决跨域
 
在HTML添加标签
```
<script src="http://localhost:8887"></script>
```

这样同样 可以请求到页面的数据

所以 jsonp 的实现原理， 就是 把请求的数据以标签请求资源的方式请求 ，浏览器对资源请求不会做限制 ，就可以请求到数据

### CORS跨域限制以及预请求验证 
cors 预请求

#### 允许的方法 （method）

GET HEAD POST 不需要预请求验证



#### 允许的 Content-Type
```
text/plan  
multipar/form-data    
application、x-www-form-urlencoded    
```

以上是在form表单做element请求的时候 允许的类型

#### 其他限制


##### 请求头限制

网页 https://fetch.spec.whatwg.org/#cors-safelisted-request-header

##### xmlHttpRequestUpload 对象均没有注册任何时间监听器

##### 请求中没有使用ReadableStream对象

如果以上都允许 服务区改为

```
response.writeHead(200, {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Headers': 'x-Test-Cors', //允许的请求头部
    'Access-Control-Allow-Methods': 'Delete,PUT,POST',//允许的请求方法
    'Access-Control-Max-Age': '1000' //表示多长时间内不做验证 可以直接请求数据
  })
```
### http报文格式

#### http方法

是用来定义对资源的操作  

- get： 获取数据
- post: 创建数据
- put: 更新数据
- delete： 删除数据

最常用的事 post、get

#### http code
定义服务器队请求的处理结果

各个区间的code有个字的语义


- 200 - 299 代表这个操作成功的
- 300 - 399 代表这个操作重定向的，用别的方式获取这个数据
- 400 - 499 发送的请求有问题
- 500 - 599 服务器的错误 

好的http服务可以通过 code直接判断结果

### 可缓存性

#### public

http请求返回过程中 
#### private

#### no-cache
表示虽然可以缓存 ，但是下次请求还是要服务器验证


设置缓存时长 

可以在加载一个js的时候 设置
```
'Content-Type':'text/javascript',
'Cache-Control': 'max-age=200, public',
```
这样的设置后 第二次加载页面时  如果在设置的事件内，会直接加载缓存中的文件 
解决方法 就是在 js后边添加hash值 每次刷新都会改变hash值 所以就会重新加载页面