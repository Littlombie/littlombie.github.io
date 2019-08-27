---
title: webpack项目流程学习（二）
date: 2017-04-11 10:29:03
categories: web
tags: [web,webpack]
---

<img src="/images/post/what-is-webpack.png" class="full-image" alt='webpack' />

> 本文只是作为学习webpack入门所作的笔记，仅供参考。阅读本文之前，请首先阅读[webpack项目流程学习（一）](https://littlombie.github.io/2017/04/10/webpack-1/)；

## 项目测试  

我们试做一个项目测试,适用`laoder` 以及其特性处理项目中的资源文件； 

### 重新配置文件

配置目录为下

![目录](http://img2.ph.126.net/xxKBMcOgvgeAuVN9Ft1b4g==/6631949574026962709.png)

<!-- more -->
文件中内容为：  

layer.html
```html
<div class="layer">
  <div>this is  a layer</div>
</div>
```

layer.js

```javascript
//import tpl from './layer.html';
function layer (){
  return {
    name:'layer',
    tpl:tpl
  }
}

export default layer;

```
layer.less

```less
.layer {
  width: 600px;
  height: 400px;
  background-color: #ff0;
  .>div{
    width: 600px;
    height: 300px;
    background-color: #f00;
  }
}
```
app.js

引入 layer.js文件 执行
```javascript
import layer from './components/layer/layer.js';
const App  = function (){
console.log(layer);
}

new App();

```

### 使用babel-loader转换ES6 

使用`babel` 把`es6`的语法解析成浏览器支持的语法

首先需要安装需要支持的`loader`插件 

安装`loader`  和 `core`  的插件   

```
npm install --save-dev babel-loader babel-core 
```

 
安装 `babel-preset-latest`

```
npm install --save-dev babel-preset-latest
```

webpack.config.js


```javascript
var htmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
    entry:'./src/app.js',
  output:{
    path:'./dist',
    filename:'js/[name].bundle.js',
  },
  module:{
    loader:[
      {
        test:/\.js/,
        loader:'babel-loader',
        query:{
            presets:['lastest']//告诉babel 执行js的
        }
      }
    ]
  },
  plugins:[
    new htmlWebpackPlugin({
      filename:'index.html',
      template:'index.html',
      inject:'body',
    })
  ]

}
```

配置文件设置 `entry`, `output`以及` module` 模块 ，模块打包 的`loader`的打包工具以及执行js的版本  


```javascript
// query:{
//    presets:['lastest']//告诉babel 执行js的
// }
```

上边的代码也可以设置在`package.json` 中为（作用相同）：
``` json
"babel":{
    "presets":["latest"]
  },
```

说明： 使配置告诉webpack，处理文件通过`babel-loader`，并且 处理是以 `'presets":["latest"]'` 版本

现在 执行一下  `npm  run webpack` 会在`dist` 文件中生成`index.html`和js下的 `main.bundle.js` 文件 

在浏览器打开 在console 下会显示：

```
function layer(){
  return {
    name:'layer',
    tpl:tpl
  };
}

```

表示页面 顺利执行 打开，我们可以在修改`html` `app.js` `layer.js`里边的文件  执行 都可以显示出效果 

###  选择性打包

为了加快打包执行的速度 ，选择性打包，我么可以在` module` 中设置 参数 ：

```
exclude:'./node_modules/',//不包含打包的范围 优化打包速度
include:'./src',//包含打包的范围 优化打包速度
```

此时 虽然`include` 加快了速度 , 但是 `exclude` 却没有起作用 ，这时我们需要把之前的路径改为绝对路径：  
```
include:path.resolve(__dirname,'src/'),
exclude:path.resolve(__dirname,'node_modules/'),
```
这样就加快了执行命令的速度


### 使用打包css 


首先 要安装 `css-loader` 和 `style-loader` 

```
npm i style-loader css-loader --save-dev
```
然后在`src-->css`下边 新建`common.css`文件，在里边书写一些样式 便于观察 ，
然后在`app.js`中头部引用`common.css`文件

```
import  './css/common.css';
```
在配置文件 `webpack.config.js`中的`module`下添加 `css loader`:

```
,
{
    test:/\.css$/,
    loader:'style-loader!css-loader'
}
```
 执行命令`npm run webpack`，打开浏览器 可以看见浏览器内联样式

###   css  后处理

平时写样式我们不只局限与css ,有时会写预加载样式 如`sass`,`less`,以及为了浏览器兼容，我们需要添加前缀，此时我们只要 安装一个`postcss-loader` 就可以实现 自动添加 浏览器前缀 -webkit- ，-moz-，-ms-,-o-;相关参数可以查看[postcss-loader](https://github.com/postcss/postcss#plugins)


首先下载[postcss-loader](https://www.npmjs.com/package/postcss-loader)
```
npm install postcss-loader --save-dev
```
然后安装添加前缀插件[autoprefixer](https://github.com/postcss/autoprefixer)
```
npm install autoprefixer --save-dev
```
然后在`loader` 后边添加`!postcss-loader` (loader 是从右到左加载的)


1.添加 `autopredixer` ，在 `module` 后边 添加`postcss`(此方法以失败)

2.首先 引入webpack(参考imooc下边[评论](http://www.imooc.com/video/14197))

```javascript
var webpack = require('webpack');

```

在plugin下边添加
```javascript
,
new webpack.LoaderOptionsPlugin({
    options: {
      postcss: [
        require("autoprefixer")({
         browsers: ["last 5 versions"]
        })
      ]
    }
})
```
如果css  页面有引入文件 `@import`，如：
```
@import "./flex.css";
```
则需要在配置文件的  loader处设置处理：
```
loader:'style-loader!css-loader?importLoaders=1!postcss-loader'
```
其中`=`后边的`1`表示有1个引入文件 ，如果需要引入多少个文件，则设置数字为引入的数量


### 处理.less/.sass文件

在项目中处理.less文件时，首先需要下载安装`less-loader`

```
npm install less-loader --save-dev
```
如果本机没有less  支持，则需要首先安装less
```
npm install less
```
安装完成后 可以在module 设置 loader 

```
,
{
  test:/\.less$/,
  loader:'style!css!postcss!less'
}
```
注意 `postcss`需放在css! 与less之间

以上的`less` 同样可以适用 `@import `与`postcss` 的后处理 输出的文件同样添加了前缀


> sass 的原理与less 相同 只需要把less改为sass 即可

注意：安装 `sass-loader` 时 需要安装 `node-sass` （建议vpn安装，或者使用淘宝镜像）

```
npm install node-sass/node-less
```

### 处理项目中的模板文件

使webpack把模板文件当做一个字符串处理

 首先 安装HTML的模块 ： `html-loader`
 
 ```
 npm install html-loader --save-dev
 ```

在 `layer.js`中 引入layer.html文件

```
import tpl from "./layer.html";
```

在`app.js`引入layer.js 文件，在在HTML中输出

```
import Layer from './ components/layer/layer.js';


const App  = function (){

  console.log(Layer);


  var dom  = document.getElementById('#app');
  var layer = new Layer();
  dom.innerHTML = layer.tpl;//引入 layer.js 中 的tpl
}

new App();

```
在index.html中添加`#app`标签

现在 执行 命令`npm run webpack` 在浏览器就可以看见layer模板的 文件，此时 任意更改模板文件都可以


如果我们使用模板文件`.ejs`的文件 怎么可以先安装`ejs-loader` 模板引擎 

```
npm install ejs-loader --save-dev
```

然后我们在loader里边添加 ejs-loader
```
,
 {
    test:/\.ejs/,
    loader:'ejs-loader'
}
```

然后 我们可以在.ejs书写ejs代码

```
<div class="layer">
  <div>this is    <%= name %> layer</div>

    <% for(var i = 0;i<arr.length;i++){ %>
    <%=arr[i]%>
    <%} %>
</div>

```
此时 在layer.js里边引入的文件应该改为.ejs的模板文件

在app.js 文件中可以插入js调用参数

```
  dom.innerHTML = layer.tpl({
    name:'john',
    arr:['apple','xiaomi','oppo']
  });
```
此时运行命令后，在浏览其里边就可以看见模板代码的引入和js代码的计算结果 


> 也可以书写.tpl后缀的格式的模板文件

 
### 处理图片以及其他文件


首先先安装图片`loader`  

####  1. `file-loader`（查看相关资料可看官网 ）
```
npm install file-loader --save-dev
```

在配置文件中 进行loader配置：

```
,
{//loader img
  test:/\.(png|jpg|gif|svg)$/,
  loader:'file-loader'
}
```
把所有的图片格式包含里边  

然后在 css/less/sass中引入图片文件背景时 ，可以使用绝对路径、设置的cdn路径、也可以直接使用相对路径 

```
{
    background-image: url(../../assets/1.jpg);
}
```
在 index.html 中也可以直接引用

```
<img src="./src/assets/1.jpg" alt="">
```

但是在模板文件中就不能直接使用相对路径，我们做一些 修改，可以像是nodes.js那样引入文件

在图片src中以这种形式添加图片：

```html
<img src="${ require('文件的相对路径') }" alt>
```
如：

```html
<img src="${ require('../../assets/1.jpg') }" alt="">
```
然后打开生成的文件 就会看见引入的图片了   


* 为了使图片能同意在一个图片文件夹中，我们可以设置query值 name   
在` file-loader `中设置  


路径为： 图片文件夹名/图片名称-5位hash值.文件格式 

```
,
{//loader img
  test:/\.(png|jpg|gif|svg)$/,
  loader:'file-loader',
  query:{
    name:'assets/[name]-[hash:5].[ext]'
  }
}
```
#### 2. url-loader 

类似于file-loader , 都可以处理图片以及文件 ，但是我们可以指定一个limit ，当处理时文件/图片大小大于limit设定后，会把文件交于file-loader 处理，小于指定的大小后，则会把图片/文件处理成base:64位的编码 
安装 `url-loader`

```
npm install url-loader --save-dev
```

测试：我们把刚才的file-loader 改为url-loader ,在query中添加一个limit值，设置limit大小 
```
,
{//loader img
  test:/\.(png|jpg|gif|svg)$/,
  loader:'url-loader',
  query:{
  limit:50000,
    name:'assets/[name]-[hash:5].[ext]'
  }
}
```
然后打包一下  就会看见，我们的图片文件如果大于设置的limit：50000,50k时，会直接把图片loader进来，如果文件没有50k大师，怎会处理成base:64位的编码

#### 3. 图片压缩 -- image-webpack-loader 


首先先安装
```
npm install image-webpack-loader --save-dev
```
  然后我们修改loader 为：
  
  ```
  {//loader img
        test:/\.(png|jpg|gif|svg)$/,
        // loader:'url-loader',//loader 可省略
        // query:{
        //   limit:300000,
        //   name:'assets/[name]-[hash:5].[ext]'
        // }
        loaders:[
          'url-loader?limit=300000&name=assets/[name]-[hash:5].[ext]',
          'image-webpack-loader'
        ]
      }
  ```
上边还是遵守loader的顺序（从右到左），先是把图片压缩，压缩后的图片再交给url-loader 判断 是否大于limit值，大于直接交给file-loader 引入，如果在范围之内就把图片转成base：64位的编码
