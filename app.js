/**
 * 作用域
 * @type {{data: {}, conf: {}, routes: {}, fn: {}}}
 */

var express = require('express');


var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
var routesconfig = require('./routes');
//var anuglar = require('./app/components/angular-route/angular-route');
var partials =require('express-partials');//这里express3.*后需要添加
//var ejs = require('ejs');
//var routes = require('./routes/index');
//var users = require('./routes/users');
var app = express();
app.use('/', routesconfig);
// view engine setup
/*app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'html');
app.engine('.html', require('ejs-mate').__express);
app.locals._layoutFile = 'layout.html';*/

/*app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'html');
app.engine('html', require('ejs-mate'));
app.locals._layoutFile = 'layout.html';
app.locals._layoutFile = 'emptyLayout.html';*/

//app.set('views', path.join(__dirname, 'public/views'));
//app.engine('.html', ejs.__express);
//app.set('view engine', '.html'); //修改文件扩展名ejs为html*/

app.use(partials());//这里express3.*后需要添加


app.use(logger('env'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));


// angular启动页
/*app.get('/', function (req, res) {
    res.sendfile('main.html');
});*/
// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});
module.exports = app;
