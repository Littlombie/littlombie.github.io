---
title: 地图坐标与距离摸索
date: 2016-12-27 12:34:58
categories: javascript
tags: [map,javascript]
---
<img src="/images/map.png" class="full-image" />
> 昨天公司要求做一个关于地图的页面，要求根据自己的位置找到最近的客户店铺，然后测出相应的距离，最后点击显示到地图上。以下是我做后的总结：

### 引入地图API
我选的是百度地图，需要在页面引入百度地图的jsAPI:
```html
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=yourkey"></script>
```
<!-- more -->
### 获取自己的定位以及目标的坐标
首先获取自己的定位，需要征求用户的定位许可，然后根据手机/PC浏览器获取到自己的定位以及目标的坐标位置：
```javascript
var map = new BMap.Map("map");
geolocation.getCurrentPosition(function (r) {
    if (this.getStatus() == BMAP_STATUS_SUCCESS) {
        var mk = new BMap.Marker(r.point);
        map.addOverlay(mk);
        //map.panTo(r.point); //定位后地图直接跳转到定位的点
        console.log(r.point.lng + ',' + r.point.lat);
        var point0 = new BMap.Point(r.point.lng, r.point.lat); //定位坐标
        var pointA = new BMap.Point(103.9220890659,30.5741931982);  // 创建点坐标A--双流顺城街店
        var pointB = new BMap.Point(104.2947696856,30.5971282135);  // 创建点坐标B--龙泉新城吾悦店
        var pointC = new BMap.Point(103.9981777893,30.6769847095); // 创建点坐标B--金沙清江西路店
        }else {
            alert('failed' + this.getStatus());
        }
}, {enableHighAccuracy: true})
```
### 获取距离再比较远近
获取每个创建坐标与定位坐标之间的的距离
```javascript
(map.getDistance(point0, pointA)).toFixed(0);//toFixed(0) 取小数点后0位
(map.getDistance(point0, pointB)).toFixed(0);
(map.getDistance(point0, pointC)).toFixed(0);
```
把这三个数存到数组`arr`中 遍历找到最小值
```javascript
//  返回数组最大最小值
function getMaximin(arr, maximin) {
    if(maximin == "max"){
        return Math.max.apply(Math, arr);
    }else if (maximin == "min") {
        return Math.min.apply(Math, arr);
    }
}
var meter = getMaximin(arr, "min");//获取到最小的值
```
### 显示最小值在页面上
如果值大于一千米，换算单位为千米
```javascript
if (meter == arr[i]) {
    if (meter >= 1000) {
        var Mt = (meter / 1000).toFixed(1);
        m.innerHTML = '<span>您距离店铺只剩下' + Mt + '千米</span>';
    } else {
        m.innerHTML = '<span>您距离店铺只剩下' + meter + '米</span>';
    }
}
```