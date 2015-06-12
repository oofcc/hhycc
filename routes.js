/**
 * Created by hehe on 2015/3/23.
 */

express = require('express');
var hhycc = require('./config');
hhycc.sign = require('./controllers/sign');
hhycc.topic = require('./controllers/topic');

hhycc.index = require('./routes/index');
hhycc.users = require('./routes/users');
//hhycc.routes.get('/',index.);//app.use('/', routes);
//hhycc.router.get('/users', users);
hhycc.site = require('./controllers/site');
hhycc.router = express.Router();
/****
 * 系统管理主页面
 */
hhycc.sitehome = require('./controllers/sitehome');
hhycc.router.get('/', hhycc.sitehome.home);
hhycc.main=require('./controllers/main');
hhycc.router.get('/main',hhycc.main.main);
//进入主题清单页面
hhycc.router.get('/totopicList',hhycc.topic.topicList);
//hhycc.router.get('/', hhycc.site.index);
//hhycc.router.get('/', hhycc.topic.topicList);

/**
 * 公用方法
 */
hhycc.pbc=require('./controllers/pbc');
hhycc.routes.get('',hhycc.pbc.pbcjs);
hhycc.routes.get('',hhycc.pbc.pgccss);
module.exports = hhycc.router;