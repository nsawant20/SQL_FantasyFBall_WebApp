var express = require('express');
var bodyParser = require('body-parser');
var mysql = require('mysql2');
var path = require('path');
var connection = mysql.createConnection({
                host: '34.170.73.27',
                user: 'root',
                password: 'MangoDB',
                database: 'db_PFFA'
});

connection.connect;


var app = express();

// set up ejs view engine 
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');
 
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(__dirname + '../public'));

/* GET home page, respond by rendering index.ejs */
app.get('/', function(req, res) {
  res.render('index', { title: 'Insert Team' });
});

app.get('/success', function(req, res) {
      res.send({'message': 'Team inserted successfully!'});
});
 
// this code is executed when a user clicks the form submit button
app.post('/mark', function(req, res) {
  var QB = req.body.QB;
  var RB = req.body.RB;
  var RB2 = req.body.RB2;
  var WR = req.body.WR;
  var WR2 = req.body.WR2;
  var TE = req.body.TE;
  var D_ST = req.body.D_ST;
  var K = req.body.K;
  var FLEX = req.body.FLEX;
  var user_name = req.body.username;
   
  var sql = `INSERT INTO User_Team (username, QB, RB, RB2, WR, WR2, TE, D_ST, K, FLEX) VALUES ('${user_name}','${QB}','${RB}','${RB2}', '${WR}', '${WR2}', '${TE}', '${D_ST}', '${K}', '${FLEX}')`;


console.log(sql);
  connection.query(sql, function(err, result) {
    if (err) {
      res.send(err)
      return;
    }
        res.render('index',{qb_name: QB, rb_name:RB, rb2_name:RB2, wr_name:WR, wr2_name:WR2, te_name:TE, d_st_name:D_ST, k_name:K, flex_name:FLEX, user_name:user_name});
//    res.redirect('/mark');
//      res.send({'message': 'Team inserted successfully!'});  
});
});

app.post('/delete_team', function(req, res) {
  var delete_username = req.body.team_delete;
  var delete_sql = "DELETE FROM User_Team WHERE username = " + connection.escape(delete_username);

  console.log(delete_sql);
  connection.query(delete_sql, function(err, result) {
    if (err) {
      res.send(err)
      return;
    }
    res.render('index', {delete_success: "Team deleted successfully"});
});  
});

app.post('/update_team', function(req, res) { 
  var update_username = req.body.team_update;
  var update_QB = req.body.QB_update;
  var update_RB1 = req.body.RB1_update;
  var update_RB2 = req.body.RB2_update;
  var update_WR1 = req.body.WR1_update;
  var update_WR2 = req.body.WR2_update;
  var update_TE = req.body.TE_update;
  var update_DST = req.body.DST_update;
  var update_K = req.body.K_update;
  var update_FLEX = req.body.FLEX_update;

  var update_sql = "UPDATE User_Team SET QB  = " + connection.escape(update_QB) + ", RB = " + connection.escape(update_RB1) + ", RB2 = " + connection.escape(update_RB2) + ", WR = " + connection.escape(update_WR1) + ", WR2 = " + connection.escape(update_WR2) + ", TE = " + connection.escape(update_TE) + ", D_ST = " + connection.escape(update_DST) + ", K = " + connection.escape(update_K) + ", FLEX = " + connection.escape(update_FLEX) +  " WHERE username = " + connection.escape(update_username);
  console.log(update_sql);
  connection.query(update_sql, function(err, result) {
    if (err) {
      res.send(err)
      return;
    }
    res.render('index', {update_success: "Team updated successfully"});
});  
});

app.post('/search_team', function(req, res) {
  var search_team = req.body.search_username;
   
  var search_sql = "SELECT * FROM User_Team WHERE username = " + connection.escape(search_team);

  connection.query(search_sql, function(err, result) {
    if (err) {
      res.send(err)
      return;
    }
    console.log(result);
    res.render('index',{qb_name: result[0].QB, rb_name:result[0].RB, rb2_name:result[0].RB2, wr_name:result[0].WR, wr2_name:result[0].WR2, te_name:result[0].TE, d_st_name:result[0].D_ST, k_name:result[0].K, flex_name:result[0].FLEX, user_name: result[0].username});
});
});

app.post('/find_best', function(req, res) {
  var find_best_sql = "SELECT DISTINCT player_id, player_name, team, touchdowns, receiving_yds as yards FROM NFL_Players_WR WHERE (touchdowns >= (SELECT MAX(touchdowns) FROM NFL_Players_WR)) OR (receiving_yds >= (SELECT MAX(receiving_yds) FROM NFL_Players_WR)) UNION SELECT DISTINCT player_id, player_name, team, touchdowns, receiving_yds as yards FROM NFL_Players_TE WHERE (touchdowns >= (SELECT MAX(touchdowns) FROM NFL_Players_TE)) OR (receiving_yds >= (SELECT MAX(receiving_yds) FROM NFL_Players_TE)) UNION SELECT DISTINCT player_id, player_name, team, touchdowns, rushing_yds as yards FROM NFL_Players_RB WHERE (touchdowns >= (SELECT MAX(touchdowns) FROM NFL_Players_RB)) OR (rushing_yds >= (SELECT MAX(rushing_yds) FROM NFL_Pl>

  connection.query(find_best_sql, function(err, result) {
    if (err) {
      res.send(err)
      return;
    }
    console.log(result[0]);
    res.render('index',{best1: result[0].player_name, best2: result[1].player_name, best3: result[2].player_name, best4: result[3].player_name, best5: result[4].player_name});
});
});

app.post('/find_average', function(req, res) {
  var find_average_sql = "SELECT DISTINCT b.player_id, b.player_name, b.team, receiving_yds, touchdowns FROM NFL_Players a JOIN NFL_Players_WR b ON (a.player_id = b.player_id) WHERE b.team = 'CHI' AND b.receiving_yds >= (SELECT AVG(receiving_yds) FROM NFL_Players_WR WHERE receiving_yds > 0)"

  connection.query(find_average_sql, function(err, result) {
    if (err) {
      res.send(err)
      return;
    }
    console.log(result[0]);
    res.render('index',{best1: result[0].player_name});
});
});


app.listen(80, function () {
    console.log('Node app is running on port 80');
});