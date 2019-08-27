# hexo搭建个人博客详细步骤
###

 ## hexo 的命令操作

* 使用以下命令安装hexo(ps：以下命令中的$符号只为了让教程和实际看起来一致，实际输入命令只需输入$后面的命令即可) 
  ```markdown
   $ npm install hexo-cli -g 
  ```
* 如果之后在使用的过程中，遇到以下的错误 
  ```markdown
  ERROR Deployer not found : github 
  ```  
  则运行以下命令,或者你直接先运行这个命令更好。
  ```markdown
  $ hexo g

  $ hexo d
  ```
 * 接下来创建放置博客文件的文件夹：hexo文件夹。在自己想要的位置创建文件夹，如我hexo文件夹的位置为E:\hexo，名字和地方可以自由选择，当然最好不要放在中文路径下，至于原因，我想很多人懂得。之后进入文件夹，即E:\hexo内，点击鼠标右键，选择Git Bash，执行以下命令，Hexo会自动在该文件夹下下载搭建网站所需的所有文件。
   ```markdown
    $ hexo init
   ```
 * 让我们看看刚刚下载的hexo文件带来了什么，在E:\hexo内执行以下命令， 
    ```markdown
    $ hexo g
 
    $ hexo s  
    ```
 * 然后用浏览器访问`http://localhost:4000/`，此时，你应该看到了一个漂亮的博客了，当然这个博客只是在本地的，别人是看不到的，hexo3.0使用的默认主题是landscape。轻轻松松就看到了一点成果，是不是很激动，这就是hexo的强大之处，这个本地预览的功能，我真是爱不释手

 * 修改端口的命令
   ```markdown
   hexo s -p 5000  //后边的5000 为端口名
   ```
 *  你执行命令之后，提供执行后提示的详细信息？ 如果查看端口， 可以用 `netstat -ntpl` 查看下是否被占用？如占用了该端口，需要kill下，如没有占用，在查看hexo是否在运行，可以使用`ps -ef | grep 'hexo'` 查下
 
 * ##部署本地文件到github
 
 * 既然Repository已经创建了，当然是先把博客放到Github上去看看效果。编辑E：\hexo下的_config.yml文件，建议使用Notepad++。
   
 *  在_config.yml最下方，添加如下配置(命令中的第一个huangjunhui为Github的用户名,第二个huangjunhui为之前New的Repository的名字,记得改成自己的。另外记得一点，hexo的配置文件中任何’:’后面都是带一个空格的),如果配置以下命令出现`ERROR Deployer not found : github`，则参考上文的解决方法。
   
    ![](http://i1.buimg.com/2b0b56ff987e6c8cs.png)
 *  这里要注意格式了（注意间隔，按照图片上的来，：后面有内容一定要加个空格） 
   配置好_config.yml并保存后，执行以下命令部署到Github上。如果你是第一次使用Github或者是已经使用过，但没有配置过SSH，则可能需要配置一下，具体方法史上最全github使用方法：github入门到精通里面有介绍到。
   
   ```markdown
   $ hexo g
 
   $ hexo d
   ```
 *  执行上面的第二个命令，可能会要你输入用户名和密码，皆为注册Github时的数据，输入密码是不显示任何东西的，输入完毕回车即可。
   
 *  此时，我们的博客已经搭建起来，并发布到Github上了，在浏览器访问`huangjunhui.github.io`就能看到自己的博客了。第一次访问刚地址，可能访问不了，您可以在几分钟后进行访问，一般不超过10分钟。
 
* ## hexo的配置文件

  hexo里面有两个常用到的配置文件，分别是整个博客的配置文件E:\hexo\_config.yml 
  和主题的配置文件E:\hexo\themes\light\_config.yml，此地址是对于我来说，hexo3.0使用的默认主题是landscape，因此你们的地址应该是E:\hexo\themes\landscape\_config.yml，下文所有讲到light的地方，你们将之换为自己的主题名即可。本博客使用的主题是基于light改善的主题，目前还在完善中，如果完成的比较好，以后可能发布在github上。如果你想自己挑选喜欢的主题，hexo官方提供了12个主题供你自己选择，使用方法很简单，点击自己想要的主题，进入该主题的Repository，使用Git将主题clone到本地，然后将整个文件夹复制到E:\hexo\themes文件夹下，将E"\hexo\_config.yml里的theme名字改为自己下载的主题的文件夹名即可。

  接下来介绍整个博客的配置文件。
 

 * ### hexo_config.yml 文件配置
  
  ```markdown
  ## Docs: https://hexo.io/docs/configuration.html
  
  ## Source: https://github.com/hexojs/hexo/
  
  # Site
  
  title: 喜欢雨天的我      //主页导航提示
  
  subtitle:
  
  description: 生活一半记忆，一半继续   //主页描述信息
  
  author: Hou Shuai                //主页呈现的用户名
  
  language: zh-Hans           //根据自己主题设置语言方式
  
  timezone:
  
  # URL
  
  ## If your site is put in a subdirectory, set url as 'http://yoursite.com/child' and root as '/child/'
  
  url: http://yoursite.com/child   
  
  root: /
  
  permalink: :year/:month/:day/:title/
  
  permalink_defaults:
  
  # Directory
  
  source_dir: source
  
  public_dir: public
  
  tag_dir: tags
  
  archive_dir: archives
  
  category_dir: categories
  
  code_dir: downloads/code
  
  i18n_dir: :lang
  
  skip_render:
  
  # Writing
  
  new_post_name: :title.md # File name of new posts
  
  default_layout: post
  
  titlecase: false # Transform title into titlecase
  
  external_link: true # Open external links in new tab
  
  filename_case: 0
  
  render_drafts: false
  
  post_asset_folder: false
  
  relative_link: false
  
  future: true
  
  highlight:                        //高亮
  
  enable: true
  
  line_number: true
  
  auto_detect: false
  
  tab_replace:
  
  # Category & Tag
  
  default_category: uncategorized
  
  category_map:
  
  tag_map:
  
  # Date / Time format
  
  ## Hexo uses Moment.js to parse and display date
  
  ## You can customize the date format as defined in
  
  ## http://momentjs.com/docs/#/displaying/format/
  
  date_format: YYYY-MM-DD
  
  time_format: HH:mm:ss
  
  # Pagination
  
  ## Set per_page to 0 to disable pagination
  
  per_page: 10
  
  pagination_dir: page
  
  # Extensions
  
  ## Plugins: https://hexo.io/plugins/
  
  ## Themes: https://hexo.io/themes/
  
  theme: yelee
  
  # Deployment
  
  ## Docs: https://hexo.io/docs/deployment.html
  #下面的是重点 repository:
  #http://github.com/你的github上用账号名/你的github上用账号
  #名.github.io.git
  
  deploy:
  
  type: git
  
  repository: http://github.com/houshuai0816/houshuai0816.github.io.git
  
  branch: master
  ```
  上面的是重点 repository：后面填写的格式
  http://github.com/你的github上用账号名/你的github上用账号
  名`.github.io.git`     
  
  ##### 这里要注意repository：和你的地址之间有空格。
  ##### branch: 等后面都要加空格  否则hexo配置时会报错 
  
  * 按照自己的意愿修改完后，执行hexo g，hexo s，打开localhost:4000看看效果。
  
  * hexo\themes\light_config.yml，此处针对Concise主题，如果使用其他主题，请查看自己主题的帮助文档 
  
* ### 发布新的文章
  
  1.在Git Bash执行命令：$ hexo new “my new post”
  
  2.在E:\hexo\source_post中打开my-new-post.md，打开方式使用记事本或notepad++。
  
  hexo中写文章使用的是Markdown，没接触过的可以看下Markdown语法说明,一分钟学会Markdown
  
  ```markdown
  title: my new post#可以改成中文的，如“新文章”

  date:2015-04-0822:56:29#发表日期，一般不改动
  
  categories: blog#文章文类
  
  tags: [博客，文章]#文章标签，多于一项时用这种格式，只有一项时使用tags: blog
  ```
  
  有一些主题中如果想要以一条题目呈现给用户需要在加如下信息（注意加的位置，是每一篇的开头）。 
  
  ![名称](http://i1.buimg.com/c3fb1abf23248817s.png)
  
  
  *
    * 如果想新建博文 在你存放的博客目录下   `hexo n "新建博客的名字"`
  
    * 会在 `D:\Users\BokeGitHub\houshuai.github.io\blog\nodejs-hexo\source\_posts` （这是我的目录，你的目录实在；—/你的博客文件\source_posts） 
 
    * 然后用notepad+++打开编辑（这里不推荐用window商城里的MarkDownPaid进行编辑，因为会出现博客界面排版问题）
  
    * 这里是正文，用markdown写，你可以选择写一段显示在首页的简介后，加上
  
    * 在之前的内容会显示在首页，之后的内容会被隐藏，当游客点击Read more才能看到。“`
  
    *  写完文章后，你可以使用 
    
      1.`$ hexo g`生成静态文件。
     
      2.`$ hexo s`在本地预览效果。
     
      3.`hexo d`同步到github， 
 
      然后使用http://你的用户名.github.io进行访问
  
    * 自定义样式布局系列
  
      1 如果觉得hexo自带的样式不好的话，可以在[github](https://github.com/search? utf8=%E2%9C%93&q=hexo)下搜索自己感兴趣的主题，需要先
      ```markdown
        git clone github上对应的网址
      ```
      ![github](http://i1.buimg.com/da8c47de3e4daa5bs.png)
      2 配置样式的内容同样是在样式目录下的全局配置文件中更改 _config.yml.根据样式提示更改 
      3 对样式进行覆盖并部署到github上。需要在当前博客目录下
  
      ```markdown
        hexo clean
        
        hexo g
        
        hexo d
      ```
  
      这样就可以输入自己在github上托管的网址查看效果了，是不是很简单呢。