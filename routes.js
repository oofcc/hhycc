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
hehe.main=require('./controllers/main');
hehe.router.get('/main',hehe.main.main);
//hehe.router.get('/', hehe.site.index);
hehe.router.get('/', hehe.topic.topicList);
module.exports = hehe.router;