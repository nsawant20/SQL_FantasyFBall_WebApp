var express = require('express');
var bodyParser = require('body-parser');
var mysql = require('mysql2');
var path = require('path');
let config = require('./config.js');
var connection = mysql.createConnection(config);

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

var sqlQB = "CALL QB_Reccs(?)";
var sqlRB = "CALL RB_Reccs(?, ?)";
var sqlWR = "CALL WR_Reccs(?, ?)";
var sqlTE = "CALL TE_Reccs(?)";
var sqlK = "CALL K_Reccs(?)";
var sqlDST = "CALL D_ST_Reccs(?)";
var sqlFLEX = "CALL FLEX_Reccs(?)";
var sqlInjury = "CALL Injury()";

var User_RB1_rating = "SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5) AS rb1_rating FROM NFL_Players_RB WHERE player_name = (SELECT player_name FROM NFL_Players_RB JOIN User_Team WHERE RB = player_name LIMIT 1)";
var User_RB2_rating = "SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5) AS rb2_rating FROM NFL_Players_RB WHERE player_name = (SELECT player_name FROM NFL_Players_RB JOIN User_Team WHERE RB2 = player_name LIMIT 1)";
var User_QB_rating = "SELECT (((0.04 * passing_yds) + (0.1 * rushing_yds) + (6 * rush_touchdowns) + (-2 * turnovers) + (4 * pass_touchdowns)) / 5) AS qb_rating FROM NFL_Players_QB WHERE player_name = (SELECT player_name FROM NFL_Players_QB JOIN User_Team WHERE QB = player_name LIMIT 1)";
var User_WR1_rating = "SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5) AS wr1_rating FROM NFL_Players_WR WHERE player_name = (SELECT player_name FROM NFL_Players_WR JOIN User_Team WHERE WR = player_name LIMIT 1)";
var User_WR2_rating = "SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5) AS wr2_rating FROM NFL_Players_WR WHERE player_name = (SELECT player_name FROM NFL_Players_WR JOIN User_Team WHERE WR2 = player_name LIMIT 1)";
var User_TE_rating = "SELECT (((0.1 * receiving_yds) + receptions + (-2 * fumbles) + (6 * touchdowns)) / 4) AS te_rating FROM NFL_Players_TE WHERE player_name = (SELECT player_name FROM NFL_Players_TE JOIN User_Team WHERE TE = player_name LIMIT 1)";
var User_FLEX_rating = "SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5) AS flex_rating FROM NFL_Players_WR WHERE player_name = (SELECT player_name FROM NFL_Players_WR JOIN User_Team WHERE FLEX = player_name LIMIT 1)";
var User_K_rating = "SELECT (((1 * extrapt_made) + (-1 * extrapt_missed) + (-1 * fg_missed) + (3 * fg_made)) / 4) AS k_rating FROM NFL_Players_K WHERE player_name = (SELECT player_name FROM NFL_Players_K JOIN User_Team WHERE K = player_name LIMIT 1)";
var User_D_ST_rating = "SELECT (((2 * interceptions) + (1 * sacks) + (2 * fumbles) + (6 * touchdowns)) / 5) AS dst_rating FROM NFL_Players_D_ST WHERE team = (SELECT team FROM NFL_Players_D_ST JOIN User_Team WHERE D_ST = team LIMIT 1)";

//console.log(User_WR1_rating);
//console.log(User_WR2_rating);
var rating_qb = 0;
var rating_rb = 0
var rating_rb1 = 0;;
var rating_wr = 0;
var rating_wr1 = 0;
var rating_te = 0;
var rating_k = 0;
var rating_dst = 0;
var rating_flex = 0;

connection.query(sqlInjury, (error, results, fields) => {
    if (error) {
      return console.error(error.message);
    }

   // console.log(rating_qb)
 });

connection.query(User_FLEX_rating, function(err, result) {
    if (err) {
      result.send(err)
      return;
    }
    //console.log(result);
    rating_flex = parseInt(result[0].flex_rating);
    
    connection.query(sqlFLEX, rating_flex, (error, results, fields) => {
    if (error) {
      return console.error(error.message);
    }

   // console.log(rating_qb)
 });
});

connection.query(User_QB_rating, function(err, result) {
    if (err) {
      result.send(err)
      return;
    }
    //console.log(result);
    rating_qb = parseInt(result[0].qb_rating);
    
    connection.query(sqlQB, rating_qb, (error, results, fields) => {
    if (error) {
      return console.error(error.message);
    }

   // console.log(rating_qb)
 });
});

connection.query(User_RB1_rating, function(err, result) {
    if (err) {
      result.send(err)
      return;
    }
//    console.log(result);
    rating_rb = parseInt(result[0].rb1_rating);

    connection.query(User_RB2_rating, function(err, result) {
    if (err) {
      result.send(err)
      return;
    }
  //  console.log(result);
    rating_rb2 = parseInt(result[0].rb2_rating);


            connection.query(sqlRB, [rating_rb, rating_rb2], (error, results, fields) => {
            if (error) {
               return console.error(error.message);
            }

   // console.log(rating_qb)
}); 
});
});

connection.query(User_WR1_rating, function(err, result) {
    if (err) {
      result.send(err)
      return;
    }
    //console.log(result);
    rating_wr = parseInt(result[0].wr1_rating);

    connection.query(User_WR2_rating, function(err, result) {
    if (err) {
      result.send(err)
     return;
    }
    //console.log(result);
    rating_wr2 = parseInt(result[0].wr2_rating);


            connection.query(sqlWR, [rating_wr, rating_wr2], (error, results, fields) => {
            if (error) {
               return console.error(error.message);
            }

   // console.log(rating_qb)
}); 
});
});


connection.query(User_TE_rating, function(err, result) {
    if (err) {
      result.send(err)
      return;
    }
    //console.log(result);
    rating_te = parseInt(result[0].te_rating);
    
    connection.query(sqlTE, rating_te, (error, results, fields) => {
    if (error) {
      return console.error(error.message);
    }

   // console.log(rating_qb)
 });
});


connection.query(User_K_rating, function(err, result) {
    if (err) {
      result.send(err)
      return;
    }
    //console.log(result);
    rating_k = parseInt(result[0].k_rating);
    
    connection.query(sqlK, rating_k, (error, results, fields) => {
    if (error) {
      return console.error(error.message);
    }

   // console.log(rating_qb)
 });
});


connection.query(User_D_ST_rating, function(err, result) {
    if (err) {
      result.send(err)
      return;
    }
   // console.log(result);
    rating_dst = parseInt(result[0].dst_rating);
    
    connection.query(sqlDST, rating_dst, (error, results, fields) => {
    if (error) {
      return console.error(error.message);
    }

   // console.log(rating_qb)
 });
});


app.post('/qb_recommendations', function(req, res) {
  var ratings_sql = "SELECT * FROM QB_Reccs LIMIT 5";
  console.log(ratings_sql);
  connection.query(ratings_sql, function(err, result) {
    if (err) {
      res.send(err)
      return;
    }
    console.log(result);
    res.render('index',{qb_rec1: result[0].player_name, qb_rec2:result[1].player_name, qb_rec3:result[2].player_name, qb_rec4:result[3].player_name, qb_rec5:result[4].player_name});
});  
});

app.post('/rb_recommendations', function(req, res) {
var ratings_sql = "SELECT * FROM RB_Reccs LIMIT 5";
console.log(ratings_sql);
connection.query(ratings_sql, function(err, result) {
  if (err) {
    res.send(err)
    return;
  }
  console.log(result);
  res.render('index',{rb_rec1: result[0].player_name, rb_rec2:result[1].player_name, rb_rec3:result[2].player_name, rb_rec4:result[3].player_name, rb_rec5:result[4].player_name});
});  
});

app.post('/te_recommendations', function(req, res) {
var ratings_sql = "SELECT * FROM TE_Reccs LIMIT 5";
console.log(ratings_sql);
connection.query(ratings_sql, function(err, result) {
  if (err) {
    res.send(err)
    return;
  }
  console.log(result);
  res.render('index',{te_rec1: result[0].player_name, te_rec2:result[1].player_name, te_rec3:result[2].player_name, te_rec4:result[3].player_name, te_rec5:result[4].player_name});
});  
});


app.post('/k_recommendations', function(req, res) {
var ratings_sql = "SELECT * FROM K_Reccs LIMIT 5";
console.log(ratings_sql);
connection.query(ratings_sql, function(err, result) {
  if (err) {
    res.send(err)
    return;
  }
  console.log(result);
  res.render('index',{k_rec1: result[0].player_name, k_rec2:result[1].player_name, k_rec3:result[2].player_name, k_rec4:result[3].player_name, k_rec5:result[4].player_name});
});  
});

app.post('/wr_recommendations', function(req, res) {
var ratings_sql = "SELECT * FROM WR_Reccs LIMIT 5";
console.log(ratings_sql);
connection.query(ratings_sql, function(err, result) {
  if (err) {
    res.send(err)
    return;
  }
  console.log(result);
  res.render('index',{wr_rec1: result[0].player_name, wr_rec2:result[1].player_name, wr_rec3:result[2].player_name, wr_rec4:result[3].player_name, wr_rec5:result[4].player_name});
});  
});


app.post('/dst_recommendations', function(req, res) {
var ratings_sql = "SELECT * FROM D_ST_Reccs LIMIT 5";
console.log(ratings_sql);
connection.query(ratings_sql, function(err, result) {
  if (err) {
    res.send(err)
    return;
  }
  console.log(result);
  res.render('index',{dst_rec1: result[0].player_name, dst_rec2:result[1].player_name, dst_rec3:result[2].player_name, dst_rec4:result[3].player_name, dst_rec5:result[4].player_name});
});  
});

app.post('/flex_recommendations', function(req, res) {
var ratings_sql = "SELECT * FROM FLEX_Reccs LIMIT 5";
console.log(ratings_sql);
connection.query(ratings_sql, function(err, result) {
  if (err) {
    res.send(err)
    return;
  }
  console.log(result);
  res.render('index',{flex_rec1: result[0].player_name, flex_rec2:result[1].player_name, flex_rec3:result[2].player_name, flex_rec4:result[3].player_name, flex_rec5:result[4].player_name});
});  
});


app.post('/injury_recommendations', function(req, res) {
var ratings_sql = "SELECT * FROM Injured LIMIT 5";
console.log(ratings_sql);
connection.query(ratings_sql, function(err, result) {
  if (err) {
    res.send(err)
    return;
  }
  console.log(result);
  res.render('index',{injuries_rec1: result[0].player_name, injuries_rec2:result[1].player_name, injuries_rec3:result[2].player_name, injuries_rec4:result[3].player_name, injuries_rec5:result[4].pl});
});  
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


app.post('/team_ratings', function(req, res) {
var ratings_sql = "SELECT * FROM User_Team_Ratings LIMIT 1";
console.log(ratings_sql);
connection.query(ratings_sql, function(err, result) {
  if (err) {
    res.send(err)
    return;
  }
//      console.log(result);
  res.render('index',{qb_rating: result[0].qb_rating, rb_rating:result[0].rb_rating, rb2_rating:result[0].rb2_rating, wr_rating:result[0].wr_rating, wr2_rating:result[0].wr2_rating, te_rating:result[0].te_rating, D_ST_rating:result[0].D_ST_rating, K_rating:result[0].K_rating, Flex_rating:result[0].Flex_rating});
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

