/**
 * Created by hehe on 2015/3/23.
 */

var dbObject = require('../models/db');
var pool =dbObject.pool;

function Topic (topic){
    this.topic_id=topic.topic_id;
    this.board_id=topic.board_id;
    this.content_info_id=topic.content_info_id;
    this.topic=topic.topic;
    this.comment=topic.comment;
    this.img_id=topic.img_id;
    this.appear_time=topic.appear_time;
    this.elitetype=topic.elitetype;
    this.actiontype=topic.actiontype;
    this.topic_type=topic.topic_type;
    this.user_id=topic.user_id;

}
module.exports=Topic;
/*function ContentInfo (contentInfo){
    this.content_info_id=contentInfo.content_info_id;
    this.lock_type=contentInfo.lock_type;
    this.appear_time=contentInfo.appear_time;
    this. last_reply_date=contentInfo.last_reply_date;
    this.hists=contentInfo.hists;
    this.replyCount=contentInfo.replyCount;
    this.diggcount=contentInfo.diggcount;
    this.show_name=contentInfo.show_name;
    this.other_name=contentInfo.other_name;
    this.content_type=contentInfo.content_type;
    this.user_ip=contentInfo.user_ip;
    this.client_id=contentInfo.client_id;
    this.user_id=contentInfo.user_id;
    this.stealth_state=contentInfo.stealth_state;
    this.book_id=contentInfo.book_id;
    this.page=contentInfo.page;
    this.ok_answer=contentInfo.ok_answer;
    this.custom_auth=contentInfo.custom_auth;
    this.reply_group_id=contentInfo.reply_group_id;

}
module.exports=ContentInfo;*/

pool.getConnection(function(err, connection) {

    var useDbSql = "USE " + dbObject.DB_NAME;
    connection.query(useDbSql, function (err) {
        if (err) {
            console.log("USE Error: " + err.message);
            return;
        }
        console.log('USE succeed');
    });
//保存数据
    Topic.prototype.save = function save(callback) {
        console.log("调用save");
        var topic = {
            topic_id:this.topic_id,
            board_id:this.board_id,
            content_info_id:this.content_info_id,
            topic:this.topic,
            comment:this.comment,
            img_id:this.img_id,
            appear_time:this.appear_time,
            elitetype:this.elitetype,
            actiontype:this.actiontype,
            topic_type:this.topic_type,
            user_id:this.user_id
         };
    var insertTopic_Sql = "INSERT INTO d_topic(topic_id,board_id,content_info_id,topic,comment,img_id,appear_time," +
        "elitetype,actiontype,topic_type,user_id) VALUES(1,'001','xx01',?,?,?,?,?,?,?,'us01')";

    connection.query(insertTopic_Sql, [
    topic.topic,topic.comment,topic.img_id,topic.appear_time,topic.elitetype,
        topic.actiontype,topic.topic_type], function (err,result) {
        if (err) {
            console.log("insertTopic_Sql Error: " + err.message);
            return;
        }
        connection.release();
        console.log("invoked[save]");
        callback(err,result);
    });
    };
//根据ID取主题数量
Topic.getTopicById = function getTopicById(id, callback) {
    var getTopicById_Sql = "SELECT * FROM d_topic WHERE topic_id = ?";
    connection.query(getTopicById_Sql, [id], function (err, result) {
        if (err) {
            console.log("getTopicById_Sql Error: " + err.message);
            return;
        }
        connection.release();
        console.log("invoked[getTopicById_Sql]");
        callback(err,result);
    });
};
/*//根据用户名得到用户信息
User.getUserByUserName = function getUserNumByName(username, callback) {
    var getUserByUserName_Sql = "SELECT * FROM userinfo WHERE username = ?";
    connection.query(getUserByUserName_Sql, [username], function (err, result) {
        if (err) {
            console.log("getUserByUserName Error: " + err.message);
            return;
        }
        connection.release();
        console.log("invoked[getUserByUserName]");
        callback(err,result);
    });
};*/

});

