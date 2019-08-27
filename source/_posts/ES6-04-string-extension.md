---
title: ES6学习（4）- 字符串扩展
date: 2019-08-21 00:46:34
categories: ES6
tags: [ES6,javascript ]
---
## ES6的字符串扩展
<!-- more -->
``` js
{
  console.log('a',`\u0061`);
  console.log('s',`\u20BB7`);

  console.log('s',`\u{20BB7}`);


}


{
  let s='𠮷';
  console.log('length',s.length);
  console.log('0',s.charAt(0));
  console.log('1',s.charAt(1));
  console.log('at0',s.charCodeAt(0));
  console.log('at1',s.charCodeAt(1));

  let s1='𠮷a';
  console.log('length',s1.length);
  console.log('code0',s1.codePointAt(0));//取第一个字符的码值
  console.log('code0',s1.codePointAt(0).toString(16));//取第一个字符的码值，转换为16进制
  console.log('code1',s1.codePointAt(1));
  console.log('code2',s1.codePointAt(2));
}

{
  console.log(String.fromCharCode("0x20bb7"));//es5
  console.log(String.fromCodePoint("0x20bb7"));//es6 通过码值返回字符串
}

{
  let str='\u{20bb7}abc';
  for(let i=0;i<str.length;i++){
    console.log('es5',str[i]);
  }
  for(let code of str){//遍历输出字符串
    console.log('es6',code);
  }
}

{
  let str="string";
  console.log('includes',str.includes("c"));//查看字符串中包含‘c’字符
  console.log('start',str.startsWith('str'));//判断字符串是否以'str'起始
  console.log('end',str.endsWith('ng'));//判断字符串是否以'ng'结束
}

{
  let str="abc";
  console.log(str.repeat(2));//指定重复的次数，相当于字符串的复制粘贴
}

//*模板字符串(很重要)
{
  let name="list";
  let info="hello world";
  let m=`i am ${name},${info}`;//`` 不是单引号'' ,是 键盘上数字1左边的字符 
  console.log(m);
}
// 字符串补白 （es7,需要babel-polyfill插件）
{
  console.log('1'.padStart(2,'0'));//01，补白的作用（es7），第一个参数‘2’表示两位，在前边补个0
  console.log('1'.padEnd(2,'0'));//10，补白的作用（es7），在后边补个0
}

// 标签模板 ，1防止xss攻击时用这个模板，2处理多语言转换 
{
  let user={
    name:'list',
    info:'hello world'
  };
  console.log(abc`i am ${user.name},${user.info}`);
  function abc(s,v1,v2){
    console.log(s,v1,v2);
    return s+v1+v2
  }
}
//.raw 对所有的\进行了转译
{
  console.log(String.raw`Hi\n${1+2}`);
  console.log(`Hi\n${1+2}`);
}
```