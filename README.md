#  定位小程序需求分析

## 目的

- 记录轨迹(实时记录, 后台记录)
- 轨迹分析
- 轨迹回放

## 场景

1. 上下班记录路线, 时间段分析, 路线分享, 记录
2. 运动轨迹记录, 分析

## 主要功能

1. 打开 APP 后, 默认进入自动记录轨迹页面, 可后台自动运行, 多次记录同一坐标点后自动停止(可手动停止录制), 超过(20分钟)时长后自动停止 APP记录功能(节电)
2. 移动网络下不上传轨迹点, 连上 WIFI 后手动同步轨迹

## 主要模块

### 用户管理

* 登录
* 注册

### 定位模块
* 后台记录
* 实时记录

### 处理模块
* 数据缓存
* 联网同步
* 坐标转换(后台)
* 存储分析(后台)

### 设置模块
* 上传频率
* 多久自动停止记录
* 同步方式
* 关于

### 分析模块
* 轨迹回放
* 线路图
* 按月,年分析
* 热力点

## 数据库设计

### 用户表/User

- 记录用户信息

| 字段名 | 参数 | 类型 | 说明 |
| ---- | ---- | ---- | ---- |
| 用户名 | username | string | 默认随机生成，允许修改一次 |
| 昵称 | nickname | string | 昵称 |
| 手机 | phone | string |  |
| 密码 | encrypted_password | string |  |
| 性别 | sex | boolean |  |
| 年龄 | age | integer |  |
| 介绍 | bio | text |  |
| 头像 | avatar | string |  |
| 状态 | state | integer | 是否激活？ 允许登陆等.. |
| 设置 | setting | text |  |

rails g scaffold users  username:string  nickname:string phone:string encrypted_password:string sex:boolean  age:integer bio:string avatar:string state:integer setting:text

### 轨迹段/Track

id
user_id
start_at
end_at
label_id
note
is_manual

rails g scaffold tracks  user_id:integer start_at:datetime end_at:datetime label_id:integer note:string is_manual:boolean

rails d scaffold tracks  user_id:integer start_at:datetime end_at:datetime label_id:integer note:string

is_manual
latitude
longitude

### 轨迹点/Point
id
track_id
created_at
latitude(decimal)
longitude(decimal)

address

rails g scaffold points  track_id:integer latitude:decimal longitude:decimal address:string

### 标签/Label
id
name


rails g scaffold labels  user_id:integer  name:string is_open:boolean



## 接口

### 发送定位接口

>POST  /api/locates.json

| 参数 | 类型 | 说明 |
| ---- | ---- | ---- |
| user_id | integer | 用户id，非必填|
| latitude | decimal | 纬度，必填 |
| longitude | decimal |经度，必填 |
| label | string |标签，非必填|
| note | string | 备注，非必填 |
| is_manual | boolean | 是否手动，必填 ，默认自动|

- 接口示例
https://ilocate.cheenwe.cn:9871/api/locates.json?latitude=xxx&longitude=xxx