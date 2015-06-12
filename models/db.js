var settings = require('../settings');
/*var Db = require('mongodb').Db;
 module.exports = new Db(settings.db, new Server(settings.host, Connection.DEFAULT_PORT, {}));
db.schema
var Connection = require('mongodb').Connection;
var Server = require('mongodb').Server;*/

var mysql  = require('mysql');  //调用MySQL模块

var dbObject ={
 DB_NAME: 'hhy',
 pool :mysql.createPool({
    host: 'localhost',
    user: 'root',
    password : 'root'
    })
}
dbObject.pool.on('connection', function(connection) {
    connection.query('SET SESSION auto_increment_increment=1');
})
module.exports = dbObject;

/*var connection = mysql.createConnection({
    host     : 'localhost',
    user     : 'root',
    password : 'root',
    port: '3306',
    database: 'hhy'
    });
connection.connect()
connection.schema
connection.connect(function(err){
    if(err){
        console.log('[query] - :'+err);
        return;
        }
    console.log('[connection connect]  succeed!');
    });*/

