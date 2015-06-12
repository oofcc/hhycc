/**
 * Created by hehe on 2015/3/23.
 */
var Topic = require('../models/Topic');
exports.topicList = function (req, res, next) {
  console.log('-------发布话题-');//req.param("topicId")
 // console.log("id:=="+req.param.topicId);

    var newTopic = new Topic({
        topic_id:'1238110348594',
        topic:'haha'
    });


    newTopic.save(function (err,result) {
        if (err) {
            res.locals.error = err;
            res.render('reg', { title: "hahaha" });
            return;
        }
        if(result.insertId > 0)
        {
            res.locals.success = '注册成功,请点击   <a class="btn btn-link" href="/login" role="button"> 登录 </a>' ;
        }
        else
        {
            res.locals.error = err;
        }
        res.render('reg', { title: "hahaha" });
    });

console.log('add Topic');
  /*  res.render('site/sys/topic', {
        title: 'topic'
        //,layout:'layout' //模版引用，模版默认是继承Layout。如果其他模版需要修改此处

    });*/
};