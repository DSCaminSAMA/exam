# exam
学校题库
下载下来后加载jar包，修改数据库配置，导入数据库

前端页面请到另一个仓库查看
https://github.com/DSCaminSAMA/exam-vue

### 管理系统功能
* 登录： 账号为 admin/123456
* 主页： 包含了试卷、题目、做卷数、做题数、用户活跃度的统计功能，活跃度和做题数是按月统计
* 用户管理： 对不同角色 学生、教师、管理员 的增删改查管理功能
* 卷题管理：
    1. 试卷列表：试卷的增删改查，新增包含选择学科、试卷类型、试卷名称、考试时间，试卷内容包含添加大标题，然后添加题目到此试卷中，组成一套完整的试卷
    2. 题目列表：题目的增删改查，目前题型包含单选题、多选题、判断题、填空题、简单题，支持图片、公式等。

###  技术栈列表
后台系统：
* spring-boot  2.1.6.RELEASE
* spring-boot-security 用户登录验证 
* mysql 开源数据库
* redis 缓存，提升系统性能
* mybatis 数据库中间件
* hikari 速度最快的数据库连接池
* 七牛云存储 目前10G内免费

前台系统：
* Vue.js  采用新版，使用了vue-cli3搭建的系统，减少大量配置文件
* vue-element-admin 最新版，对该系统做了大量精简，只保留了部分样式和控件
* echarts 图表统计
* ueditor 为了支持填空题，做了部分修改
