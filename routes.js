/**
 * Created by hehe on 2015/3/23.
 */

express = require('express');
var hehe = require('./config');
hehe.sign = require('./controllers/sign');
hehe.topic = require('./controllers/topic');

hehe.index = require('./routes/index');
hehe.users = require('./routes/users');
//hehe.routes.get('/',index.);//app.use('/', routes);
//hehe.router.get('/users', users);
hehe.site = require('./controllers/site');
hehe.router = express.Router();
/****
 * 系统管理主页面
 */
hehe.sitehome = require('./controllers/sitehome');
hehe.router.get('/', hehe.sitehome.home);
hehe.main=require('./controllers/main');
hehe.router.get('/main',hehe.main.main);
//进入主题清单页面
hehe.router.get('/totopicList',hehe.topic.topicList);
//hehe.router.get('/', hehe.site.index);
//hehe.router.get('/', hehe.topic.topicList);

/**
 * 公用方法
 */
hehe.pbc=require('./controllers/pbc');
hehe.routes.get('',hehe.pbc.pbcjs);
hehe.routes.get('',hehe.pbc.pgccss);
module.exports = hehe.router;