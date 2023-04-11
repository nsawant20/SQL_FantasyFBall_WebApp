-- UNUSED ORIGINAL STORED PROCEDURE 
DELIMITER $$
DROP PROCEDURE IF EXISTS Reccs;
CREATE PROCEDURE Reccs(IN User_QB_rating INT, IN User_RB_rating INT, IN User_RB2_rating INT, IN User_WR_rating INT, IN User_WR2_rating INT, IN User_TE_rating INT, IN User_FLEX_rating INT, IN User_D_ST_rating INT, IN User_K_rating INT)
BEGIN
    DECLARE var_qb_name VARCHAR(255);
    DECLARE var_qb_rating INT;
    DECLARE var_rb_name VARCHAR(255);
    DECLARE var_rb_rating INT;
    DECLARE var_rb2_name VARCHAR(255);
    DECLARE var_rb2_rating INT;
    DECLARE var_wr_name VARCHAR(255);
    DECLARE var_wr_rating INT;
    DECLARE var_wr2_name VARCHAR(255);
    DECLARE var_wr2_rating INT;
    DECLARE var_te_name VARCHAR(255);
    DECLARE var_te_rating INT;
    DECLARE var_flex_name VARCHAR(255);
    DECLARE var_flex_rating INT;
    DECLARE var_k_name VARCHAR(255);
    DECLARE var_k_rating INT;
    DECLARE var_d_st_name VARCHAR(255);
    DECLARE var_d_st_rating INT;
    DECLARE injury_name VARCHAR(255);
    DECLARE injury_rating INT;

    -- SELECT @User_RB_name = SELECT RB FROM User_Team;
    -- SELECT @User_RB_rating = SELECT (((9 * rushing_yds) + (4 * receptions) + (4 * receiving_yards) + (-5 * fumbles) + (9 * touchdowns)) / 5)
    --                     FROM NFL_Players_RB
    --                     WHERE User_RB_name = player_name;
                                 




    DECLARE exit_loop1 BOOLEAN DEFAULT FALSE;
    DECLARE exit_loop2 BOOLEAN DEFAULT FALSE;
    DECLARE exit_loop3 BOOLEAN DEFAULT FALSE;
    DECLARE exit_loop4 BOOLEAN DEFAULT FALSE;
    DECLARE exit_loop5 BOOLEAN DEFAULT FALSE;
    DECLARE exit_loop6 BOOLEAN DEFAULT FALSE;
    DECLARE exit_loop7 BOOLEAN DEFAULT FALSE;
    DECLARE exit_loop8 BOOLEAN DEFAULT FALSE;
    DECLARE exit_loop9 BOOLEAN DEFAULT FALSE;
    DECLARE exit_loop10 BOOLEAN DEFAULT FALSE;
    
    DECLARE qb_ratings_cur CURSOR FOR(
                                SELECT player_name, (((0.04 * passing_yds) + (0.1 * rushing_yds) + (6 * rush_touchdowns) + (-2 * turnovers) + (4 * pass_touchdowns)) / 5)
                                FROM NFL_Players_QB);

    DECLARE rb_ratings_cur CURSOR FOR(
                                SELECT player_name, (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_RB);
                                
    DECLARE rb2_ratings_cur CURSOR FOR(
                                SELECT player_name, (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_RB);

    DECLARE wr_ratings_cur CURSOR FOR(
                                SELECT player_name, (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_WR);

    DECLARE wr2_ratings_cur CURSOR FOR(
                                SELECT player_name, (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_WR);

    DECLARE te_ratings_cur CURSOR FOR(
                                SELECT player_name, (((0.1 * receiving_yds) + receptions + (-2 * fumbles) + (6 * touchdowns)) / 4)
                                FROM NFL_Players_TE);

    DECLARE flex_ratings_cur CURSOR FOR(
                                SELECT player_name, (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_RB
                                WHERE rushing_yds >= (SELECT AVG(rushing_yds)
                                                      FROM NFL_Players_RB)
                                UNION
                                SELECT player_name, (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_WR
                                WHERE receiving_yds >= (SELECT AVG(receiving_yds)
                                                        FROM NFL_Players_WR));

    DECLARE k_ratings_cur CURSOR FOR(
                                SELECT player_name, (((1 * extrapt_pt) + (-1 * extrapt_missed) + (-1 * fg_missed) + (3 * fg_made)) / 4)
                                FROM NFL_Players_K);

    DECLARE d_st_ratings_cur CURSOR FOR(
                                SELECT team, (((2 * interceptions) + (1 * sacks) + (2 * fumbles) + (2 * safety) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_D_ST);

    DECLARE notable_injuries_cur CURSOR FOR(
                                SELECT player_name, (((0.04 * passing_yds) + (0.1 * rushing_yds) + (6 * rush_touchdowns) + (-2 * turnovers) + (4 * pass_touchdowns)) / 5)  
                                FROM Injuries JOIN NFL_Players_QB USING (player_id)
                                WHERE pass_touchdowns >= (SELECT AVG(pass_touchdowns)
                                                          FROM NFL_Players_QB)
                                UNION
                                SELECT player_name, (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)  
                                FROM Injuries JOIN NFL_Players_RB USING (player_id)
                                WHERE touchdowns >= (SELECT AVG(touchdowns)
                                                     FROM NFL_Players_RB)
                                UNION
                                SELECT player_name, (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5) 
                                FROM Injuries JOIN NFL_Players_WR USING (player_id)
                                WHERE touchdowns >= (SELECT AVG(touchdowns)
                                                     FROM NFL_Players_WR)
                                UNION
                                SELECT player_name, (((0.1 * receiving_yds) + receptions + (-2 * fumbles) + (6 * touchdowns)) / 4) 
                                FROM Injuries JOIN NFL_Players_TE USING (player_id)
                                WHERE touchdowns >= (SELECT AVG(touchdowns)
                                                     FROM NFL_Players_TE));
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop1 = TRUE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop2 = TRUE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop3 = TRUE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop4 = TRUE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop5 = TRUE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop6 = TRUE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop7 = TRUE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop8 = TRUE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop9 = TRUE;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop10 = TRUE;
    
    DROP TABLE IF EXISTS Reccs;
    CREATE TABLE Reccs(
        player_pos  VARCHAR(255) NOT NULL,
        player_name  VARCHAR(255) NOT NULL,
        rating INT NOT NULL
    );

    DROP TABLE IF EXISTS Injured;
    CREATE TABLE Injured(
        player_name  VARCHAR(255) NOT NULL,
        rating INT NOT NULL
    );
    
    OPEN qb_ratings_cur;
    qbloop: LOOP
        FETCH qb_ratings_cur INTO var_qb_name, var_qb_rating;
        IF(exit_loop1) THEN
            LEAVE qbloop;
        END IF;
        
        IF (var_qb_rating > User_QB_rating) THEN
            INSERT IGNORE INTO Reccs VALUES ('QB', var_qb_name, var_qb_rating);
        END IF;
    END LOOP qbloop;
    CLOSE qb_ratings_cur;

    OPEN rb_ratings_cur;
    rbloop: LOOP
        FETCH rb_ratings_cur INTO var_rb_name, var_rb_rating;
        IF(exit_loop2) THEN
            LEAVE rbloop;
        END IF;
        
        IF (var_rb_rating > User_RB_rating) THEN
            INSERT IGNORE INTO Reccs VALUES ('RB', var_rb_name, var_rb_rating);
        END IF;
    END LOOP rbloop;
    CLOSE rb_ratings_cur;
    
    OPEN rb2_ratings_cur;
    rb2loop: LOOP
        FETCH rb2_ratings_cur INTO var_rb2_name, var_rb2_rating;
        IF(exit_loop3) THEN
            LEAVE rb2loop;
        END IF;
        
        IF (var_rb2_rating > User_RB2_rating) THEN
            INSERT IGNORE INTO Reccs VALUES ('RB2', var_rb_name, var_rb_rating);
        END IF;
    END LOOP rb2loop;
    CLOSE rb2_ratings_cur;

    OPEN wr_ratings_cur;
    wrloop: LOOP
        FETCH wr_ratings_cur INTO var_wr_name, var_wr_rating;
        IF(exit_loop4) THEN
            LEAVE wrloop;
        END IF;
        
        IF (var_wr_rating > User_WR_rating) THEN
            INSERT IGNORE INTO Reccs VALUES ('WR', var_wr_name, var_wr_rating);
        END IF;
    END LOOP wrloop;
    CLOSE wr_ratings_cur;

    OPEN wr2_ratings_cur;
    wr2loop: LOOP
        FETCH wr2_ratings_cur INTO var_wr2_name, var_wr2_rating;
        IF(exit_loop5) THEN
            LEAVE wrloop;
        END IF;
        
        IF (var_wr2_rating > User_WR2_rating) THEN
            INSERT IGNORE INTO Reccs VALUES ('WR2', var_wr2_name, var_wr2_rating);
        END IF;
    END LOOP wr2loop;
    CLOSE wr2_ratings_cur;

    OPEN te_ratings_cur;
    teloop: LOOP
        FETCH te_ratings_cur INTO var_te_name, var_te_rating;
        IF(exit_loop6) THEN
            LEAVE teloop;
        END IF;
        
        IF (var_te_rating > User_TE_rating) THEN
            INSERT IGNORE INTO Reccs VALUES ('TE', var_te_name, var_te_rating);
        END IF;
    END LOOP teloop;
    CLOSE te_ratings_cur;

    OPEN flex_ratings_cur;
    flexloop: LOOP
        FETCH flex_ratings_cur INTO var_flex_name, var_flex_rating;
        IF(exit_loop7) THEN
            LEAVE flexloop;
        END IF;
        
        IF (var_flex_rating > User_FLEX_rating) THEN
            INSERT IGNORE INTO Reccs VALUES ('FLEX', var_flex_name, var_flex_rating);
        END IF;
    END LOOP flexloop;
    CLOSE flex_ratings_cur;

    OPEN k_ratings_cur;
    kloop: LOOP
        FETCH k_ratings_cur INTO var_k_name, var_k_rating;
        IF(exit_loop8) THEN
            LEAVE kloop;
        END IF;
        
        IF (var_k_rating > User_K_rating) THEN
            INSERT IGNORE INTO Reccs VALUES ('K', var_k_name, var_k_rating);
        END IF;
    END LOOP kloop;
    CLOSE k_ratings_cur;

    OPEN d_st_ratings_cur;
    dstloop: LOOP
        FETCH d_st_ratings_cur INTO var_d_st_name, var_d_st_rating;
        IF(exit_loop9) THEN
            LEAVE dstloop;
        END IF;
        
        IF (var_d_st_rating > User_D_ST_rating) THEN
            INSERT IGNORE INTO Reccs VALUES ('D_ST', var_d_st_name, var_d_st_rating);
        END IF;
    END LOOP dstloop;
    CLOSE d_st_ratings_cur;

    OPEN notable_injuries_cur;
    injloop: LOOP
        FETCH notable_injuries_cur INTO injury_name, injury_rating;
        IF(exit_loop10) THEN
            LEAVE injloop;
        END IF;
        
        IF (injury_rating > 5) THEN
            INSERT IGNORE INTO Injured VALUES (injury_name, injury_rating);
        END IF;
    END LOOP injloop;
    CLOSE notable_injuries_cur;
    
END $$
DELIMITER ;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CODE FOR CALCULATING TEAM RATINGS
-- var User_RB1_rating = SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5) AS rb1_rating FROM NFL_Players_RB WHERE player_name = (SELECT player_name FROM NFL_Players_RB JOIN User_Team WHERE RB = player_name LIMIT 1) ;
-- var User_RB2_rating = SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5) AS rb2_rating FROM NFL_Players_RB WHERE player_name = (SELECT player_name FROM NFL_Players_RB JOIN User_Team WHERE RB2 = player_name LIMIT 1);
-- var User_QB_rating = SELECT (((0.04 * passing_yds) + (0.1 * rushing_yds) + (6 * rush_touchdowns) + (-2 * turnovers) + (4 * pass_touchdowns)) / 5) AS qb_rating FROM NFL_Players_QB WHERE player_name = (SELECT player_name FROM NFL_Players_QB JOIN User_Team WHERE QB = player_name LIMIT 1);
-- var User_WR1_rating = SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5) AS wr1_rating FROM NFL_Players_WR WHERE player_name = (SELECT player_name FROM NFL_Players_WR JOIN User_Team WHERE WR = player_name LIMIT 1);
-- var User_WR2_rating = SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5) AS wr2_rating FROM NFL_Players_WR WHERE player_name = (SELECT player_name FROM NFL_Players_WR JOIN User_Team WHERE WR2 = player_name LIMIT 1);
-- var User_TE_rating = SELECT (((0.1 * receiving_yds) + receptions + (-2 * fumbles) + (6 * touchdowns)) / 4) AS te_rating FROM NFL_Players_TE WHERE player_name = (SELECT player_name FROM NFL_Players_TE JOIN User_Team WHERE TE = player_name LIMIT 1);
-- var User_FLEX_rating = SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5) AS flex_rating FROM NFL_Players_WR WHERE player_name = (SELECT player_name FROM NFL_Players_WR JOIN User_Team WHERE FLEX = player_name LIMIT 1);
-- var User_K_rating = SELECT (((1 * extrapt_pt) + (-1 * extrapt_missed) + (-1 * fg_missed) + (3 * fg_made)) / 4) AS k_rating FROM NFL_Players_K WHERE player_name = (SELECT player_name FROM NFL_Players_K JOIN User_Team WHERE K = player_name LIMIT 1);
-- var User_D_ST_rating = SELECT (((2 * interceptions) + (1 * sacks) + (2 * fumbles) + (6 * touchdowns)) / 5) AS dst_rating FROM NFL_Players_D_ST WHERE team = (SELECT team FROM NFL_Players_D_ST JOIN User_Team WHERE D_ST = team LIMIT 1);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- STORED PROCEDURE TO CREATE QB RECOMMENDATIONS
DELIMITER $$
DROP PROCEDURE IF EXISTS QB_Reccs;
CREATE PROCEDURE QB_Reccs(IN User_QB_rating INT)
BEGIN
    DECLARE var_qb_name VARCHAR(255);
    DECLARE var_qb_rating INT;

    DECLARE exit_loop BOOLEAN DEFAULT FALSE;
    
    DECLARE qb_ratings_cur CURSOR FOR(
                                SELECT player_name, (((0.04 * passing_yds) + (0.1 * rushing_yds) + (6 * rush_touchdowns) + (-2 * turnovers) + (4 * pass_touchdowns)) / 5)
                                FROM NFL_Players_QB);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
    
    DROP TABLE IF EXISTS QB_Reccs;
    CREATE TABLE QB_Reccs(
        player_pos  VARCHAR(255) NOT NULL,
        player_name  VARCHAR(255) NOT NULL,
        rating INT NOT NULL
    );
    
    OPEN qb_ratings_cur;
    qbloop: LOOP
        FETCH qb_ratings_cur INTO var_qb_name, var_qb_rating;
        IF(exit_loop) THEN
            LEAVE qbloop;
        END IF;
        
        IF (var_qb_rating > User_QB_rating) THEN
            INSERT IGNORE INTO QB_Reccs VALUES ('QB', var_qb_name, var_qb_rating);
        END IF;
    END LOOP qbloop;
    CLOSE qb_ratings_cur;
    
END $$
DELIMITER ;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- STORED PROCEDURE TO CREATE RB RECOMMENDATIONS
DELIMITER $$
DROP PROCEDURE IF EXISTS RB_Reccs;
CREATE PROCEDURE RB_Reccs(IN User_RB_rating INT, IN User_RB2_rating INT)
BEGIN
    DECLARE var_rb_name VARCHAR(255);
    DECLARE var_rb_rating INT;

    DECLARE exit_loop BOOLEAN DEFAULT FALSE;

    DECLARE rb_ratings_cur CURSOR FOR(
                                SELECT player_name, (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_RB);
                                
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
    
    DROP TABLE IF EXISTS RB_Reccs;
    CREATE TABLE RB_Reccs(
        player_pos  VARCHAR(255) NOT NULL,
        player_name  VARCHAR(255) NOT NULL,
        rating INT NOT NULL
    );

    OPEN rb_ratings_cur;
    rbloop: LOOP
        FETCH rb_ratings_cur INTO var_rb_name, var_rb_rating;
        IF(exit_loop) THEN
            LEAVE rbloop;
        END IF;
        
        IF (var_rb_rating > User_RB_rating OR var_rb_rating > User_RB2_rating) THEN
            INSERT IGNORE INTO RB_Reccs VALUES ('RB', var_rb_name, var_rb_rating);
        END IF;
    END LOOP rbloop;
    CLOSE rb_ratings_cur;
    
END $$
DELIMITER ;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- STORED PROCEDURE TO CREATE WR RECOMMENDATIONS

DELIMITER $$
DROP PROCEDURE IF EXISTS WR_Reccs;
CREATE PROCEDURE WR_Reccs(IN User_WR_rating INT, IN User_WR2_rating INT)
BEGIN
    DECLARE var_wr_name VARCHAR(255);
    DECLARE var_wr_rating INT;

    DECLARE exit_loop BOOLEAN DEFAULT FALSE;

    DECLARE wr_ratings_cur CURSOR FOR(
                                SELECT player_name, (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_WR);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
    
    DROP TABLE IF EXISTS WR_Reccs;
    CREATE TABLE WR_Reccs(
        player_pos  VARCHAR(255) NOT NULL,
        player_name  VARCHAR(255) NOT NULL,
        rating INT NOT NULL
    );

    OPEN wr_ratings_cur;
    wrloop: LOOP
        FETCH wr_ratings_cur INTO var_wr_name, var_wr_rating;
        IF(exit_loop) THEN
            LEAVE wrloop;
        END IF;
        
        IF (var_wr_rating > User_WR_rating OR var_wr_rating > User_WR2_rating) THEN
            INSERT IGNORE INTO WR_Reccs VALUES ('WR', var_wr_name, var_wr_rating);
        END IF;
    END LOOP wrloop;
    CLOSE wr_ratings_cur;
    
END $$
DELIMITER ;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- STORED PROCEDURE TO CREATE TE RECOMMENDATIONS

DELIMITER $$
DROP PROCEDURE IF EXISTS TE_Reccs;
CREATE PROCEDURE TE_Reccs(IN User_TE_rating INT)
BEGIN
    DECLARE var_te_name VARCHAR(255);
    DECLARE var_te_rating INT;

    DECLARE exit_loop BOOLEAN DEFAULT FALSE;

    DECLARE te_ratings_cur CURSOR FOR(
                                SELECT player_name, (((0.1 * receiving_yds) + receptions + (-2 * fumbles) + (6 * touchdowns)) / 4)
                                FROM NFL_Players_TE);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
    
    DROP TABLE IF EXISTS TE_Reccs;
    CREATE TABLE TE_Reccs(
        player_pos  VARCHAR(255) NOT NULL,
        player_name  VARCHAR(255) NOT NULL,
        rating INT NOT NULL
    );
    
    OPEN te_ratings_cur;
    teloop: LOOP
        FETCH te_ratings_cur INTO var_te_name, var_te_rating;
        IF(exit_loop) THEN
            LEAVE teloop;
        END IF;
        
        IF (var_te_rating > User_TE_rating) THEN
            INSERT IGNORE INTO TE_Reccs VALUES ('TE', var_te_name, var_te_rating);
        END IF;
    END LOOP teloop;
    CLOSE te_ratings_cur;
    
END $$
DELIMITER ;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- STORED PROCEDURE TO CREATE K RECOMMENDATIONS

DELIMITER $$
DROP PROCEDURE IF EXISTS K_Reccs;
CREATE PROCEDURE K_Reccs(IN User_K_rating INT)
BEGIN
    DECLARE var_k_name VARCHAR(255);
    DECLARE var_k_rating INT;

    DECLARE exit_loop BOOLEAN DEFAULT FALSE;

    DECLARE k_ratings_cur CURSOR FOR(
                                SELECT player_name, (((1 * extrapt_made) + (-1 * extrapt_missed) + (-1 * fg_missed) + (3 * fg_made)) / 4)
                                FROM NFL_Players_K);
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
    
    DROP TABLE IF EXISTS K_Reccs;
    CREATE TABLE K_Reccs(
        player_pos  VARCHAR(255) NOT NULL,
        player_name  VARCHAR(255) NOT NULL,
        rating INT NOT NULL
    );
    
    OPEN k_ratings_cur;
    kloop: LOOP
        FETCH k_ratings_cur INTO var_k_name, var_k_rating;
        IF(exit_loop) THEN
            LEAVE kloop;
        END IF;
        
        IF (var_k_rating > User_K_rating) THEN
            INSERT IGNORE INTO K_Reccs VALUES ('K', var_k_name, var_k_rating);
        END IF;
    END LOOP kloop;
    CLOSE k_ratings_cur;
    
END $$
DELIMITER ;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

DELIMITER $$
DROP PROCEDURE IF EXISTS D_ST_Reccs;
CREATE PROCEDURE D_ST_Reccs(IN User_D_ST_rating INT)
BEGIN
    DECLARE var_d_st_name VARCHAR(255);
    DECLARE var_d_st_rating INT;

    DECLARE exit_loop BOOLEAN DEFAULT FALSE;
    
    DECLARE d_st_ratings_cur CURSOR FOR(
                                SELECT team, (((2 * interceptions) + (1 * sacks) + (2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_D_ST);

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
    
    DROP TABLE IF EXISTS D_ST_Reccs;
    CREATE TABLE D_ST_Reccs(
        player_pos  VARCHAR(255) NOT NULL,
        player_name  VARCHAR(255) NOT NULL,
        rating INT NOT NULL
    );

    OPEN d_st_ratings_cur;
    dstloop: LOOP
        FETCH d_st_ratings_cur INTO var_d_st_name, var_d_st_rating;
        IF(exit_loop) THEN
            LEAVE dstloop;
        END IF;
        
        IF (var_d_st_rating > User_D_ST_rating) THEN
            INSERT IGNORE INTO D_ST_Reccs VALUES ('D_ST', var_d_st_name, var_d_st_rating);
        END IF;
    END LOOP dstloop;
    CLOSE d_st_ratings_cur;

END $$
DELIMITER ;


----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- STORED PROCEDURE TO CREATE FLEX RECOMMENDATIONS

DELIMITER $$
DROP PROCEDURE IF EXISTS FLEX_Reccs;
CREATE PROCEDURE FLEX_Reccs(IN User_FLEX_rating INT)
BEGIN
    DECLARE var_flex_name VARCHAR(255);
    DECLARE var_flex_rating INT;

    DECLARE exit_loop BOOLEAN DEFAULT FALSE;

    DECLARE flex_ratings_cur CURSOR FOR(
                                SELECT player_name, (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_RB
                                WHERE rushing_yds >= (SELECT AVG(rushing_yds)
                                                      FROM NFL_Players_RB)
                                UNION
                                SELECT player_name, (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_WR
                                WHERE receiving_yds >= (SELECT AVG(receiving_yds)
                                                        FROM NFL_Players_WR));
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;
    
    DROP TABLE IF EXISTS FLEX_Reccs;
    CREATE TABLE FLEX_Reccs(
        player_pos  VARCHAR(255) NOT NULL,
        player_name  VARCHAR(255) NOT NULL,
        rating INT NOT NULL
    );

    OPEN flex_ratings_cur;
    flexloop: LOOP
        FETCH flex_ratings_cur INTO var_flex_name, var_flex_rating;
        IF(exit_loop) THEN
            LEAVE flexloop;
        END IF;
        
        IF (var_flex_rating > User_FLEX_rating) THEN
            INSERT IGNORE INTO FLEX_Reccs VALUES ('FLEX', var_flex_name, var_flex_rating);
        END IF;
    END LOOP flexloop;
    CLOSE flex_ratings_cur;
    
END $$
DELIMITER ;

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- STORED PROCEDURE TO CREATE INJURY RECOMMENDATIONS

DELIMITER $$
DROP PROCEDURE IF EXISTS Injury;
CREATE PROCEDURE Injury()
BEGIN
    DECLARE injury_name VARCHAR(255);
    DECLARE injury_rating INT;

    DECLARE exit_loop BOOLEAN DEFAULT FALSE;

    DECLARE notable_injuries_cur CURSOR FOR(
                                SELECT player_name, (((0.04 * passing_yds) + (0.1 * rushing_yds) + (6 * rush_touchdowns) + (-2 * turnovers) + (4 * pass_touchdowns)) / 5)  
                                FROM Injuries JOIN NFL_Players_QB USING (player_id)
                                WHERE pass_touchdowns >= (SELECT AVG(pass_touchdowns)
                                                          FROM NFL_Players_QB)
                                UNION
                                SELECT player_name, (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)  
                                FROM Injuries JOIN NFL_Players_RB USING (player_id)
                                WHERE touchdowns >= (SELECT AVG(touchdowns)
                                                     FROM NFL_Players_RB)
                                UNION
                                SELECT player_name, (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5) 
                                FROM Injuries JOIN NFL_Players_WR USING (player_id)
                                WHERE touchdowns >= (SELECT AVG(touchdowns)
                                                     FROM NFL_Players_WR)
                                UNION
                                SELECT player_name, (((0.1 * receiving_yds) + receptions + (-2 * fumbles) + (6 * touchdowns)) / 4) 
                                FROM Injuries JOIN NFL_Players_TE USING (player_id)
                                WHERE touchdowns >= (SELECT AVG(touchdowns)
                                                     FROM NFL_Players_TE));
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;

    DROP TABLE IF EXISTS Injured;
    CREATE TABLE Injured(
        player_name  VARCHAR(255) NOT NULL,
        rating INT NOT NULL
    );

    OPEN notable_injuries_cur;
    injloop: LOOP
        FETCH notable_injuries_cur INTO injury_name, injury_rating;
        IF(exit_loop) THEN
            LEAVE injloop;
        END IF;
        
        IF (injury_rating > 5) THEN
            INSERT IGNORE INTO Injured VALUES (injury_name, injury_rating);
        END IF;
    END LOOP injloop;
    CLOSE notable_injuries_cur;
    
END $$
DELIMITER ;