---
title: hexo 在github上部署成功
date: 2016-10-31 18:07:47
categories: web
tags: [hexo,github,web]

---

终于把本地Hexo部署到github上了，之前不知为什么 就是不成功，今天重新试了一下命令 就成功了 命令为：


### 发布新文章

* 首先打开文件夹 `hexo`，再右键打开Git Bash， 在Git Bash 上执行下列命令：

```bash 
hexo new "my new post" //"my new post"为文件名
```

在hexo文件夹下 `source_post` 中打开`my-new-post.md`进行编辑

或者在存放博客的目录下

```bash
 hexo n "新建博客的名字"
```

<!-- more -->

### Front-matter

Front-matter 是文件最上方以 --- 分隔的区域，用于指定个别文件的变量，举例来说：
```markdown
title: Hello World
date: 2013/7/13 20:46:25
---
```
以下是预先定义的参数，您可在模板中使用这些参数值并加以利用。

参数	描述	默认值

```gantt
layout:	    布局	

title:	    标题	

date:	    建立日期	文件建立日期

updated	:	更新日期	文件更新日期

comments:	开启文章的评论功能	true

tags:	    标签（不适用于分页）	

categories:	分类（不适用于分页）	

permalink:	覆盖文章网址	
```

举例：

```dash
title: 标题
date: 2016-11-01 11:42:21
categories: web
tags: [javascript,css] //多个标签用[,]标记
description: 这是说明，在首页显示的文字
---
```
### 本地预览

hexo 本地环境查看时首先打开文件夹 `hexo`， 在内执行以下命令

```markdown
hexo s -p 5000 //后边的-p 5000是修改端口
```
然后打开浏览器 输如`http://localhost:5000/`即可查看

### 部署到GitHub

```bash
hexo g //生成静态文件
hexo s  //在本地预览效果
hexo d //同步到github 上
```


-> [参考](http://blog.csdn.net/qq_15807167/article/details/51601234)<:

