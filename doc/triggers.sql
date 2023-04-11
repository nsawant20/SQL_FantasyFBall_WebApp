-- TRIGGER ON INSERT
DELIMITER $$
DROP TRIGGER IF EXISTS User_Team_Ratings;
CREATE TRIGGER User_Team_Ratings 
    AFTER INSERT 
    ON User_Team FOR EACH ROW

    BEGIN 
        DECLARE username VARCHAR(255);
        DECLARE QB_rating INT;
        DECLARE RB_rating INT;
        DECLARE RB2_rating INT;
        DECLARE WR_rating INT;
        DECLARE WR2_rating INT;
        DECLARE TE_rating INT;
        DECLARE D_ST_rating INT;
        DECLARE K_rating INT;
        DECLARE Flex_rating INT;

        SET @username = (SELECT new.username FROM User_Team LIMIT 1);

        SET @QB_rating = (SELECT (((0.04 * passing_yds) + (0.1 * rushing_yds) + (6 * rush_touchdowns) + (-2 * turnovers) + (4 * pass_touchdowns)) / 5)
                                FROM NFL_Players_QB
                                WHERE player_name = new.QB);

        SET @RB_rating = (SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_RB
                                WHERE player_name = new.RB);

        SET @RB2_rating = (SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_RB
                                WHERE player_name = new.RB2);

        SET @WR_rating = (SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_WR
                                WHERE player_name = new.WR);

        SET @WR2_rating = (SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_WR
                                WHERE player_name = new.WR2);  

        SET @TE_rating = (SELECT (((0.1 * receiving_yds) + receptions + (-2 * fumbles) + (6 * touchdowns)) / 4)
                                FROM NFL_Players_TE
                                WHERE player_name = new.TE);

        SET @D_ST_rating = (SELECT (((2 * interceptions) + (1 * sacks) + (2 * fumbles) + (2 * safety) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_D_ST
                                WHERE team = new.D_ST);

        SET @K_rating = (SELECT (((1 * extrapt_made) + (-1 * extrapt_missed) + (-1 * fg_missed) + (3 * fg_made)) / 4)
                                FROM NFL_Players_K
                                WHERE player_name = new.K);

        SET @Flex_rating = (SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_WR
                                WHERE player_name = new.FLEX);

        IF @username IS NOT NULL AND @QB_rating IS NOT NULL AND @RB_rating IS NOT NULL AND @RB2_rating IS NOT NULL AND @WR_rating IS NOT NULL AND @WR2_rating IS NOT NULL AND @TE_rating IS NOT NULL AND @D_ST_rating IS NOT NULL AND @K_rating IS NOT NULL AND @Flex_rating IS NOT NULL THEN
            INSERT INTO User_Team_Ratings(username, qb_rating, rb_rating, rb2_rating, wr_rating, wr2_rating, te_rating, D_ST_rating, K_rating, Flex_rating)
                VALUES(new.username, @QB_rating, @RB_rating, @RB2_rating, @WR_rating, @WR2_rating, @TE_rating, @D_ST_rating, @K_rating, @Flex_rating);

        END IF;


    END$$
DELIMITER ;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TRIGGER ON UPDATE
DELIMITER $$
DROP TRIGGER IF EXISTS User_Team_RatingsUpdate;
CREATE TRIGGER User_Team_RatingsUpdate 
    AFTER UPDATE 
    ON User_Team FOR EACH ROW

    BEGIN 
        DECLARE username VARCHAR(255);
        DECLARE QB_rating INT;
        DECLARE RB_rating INT;
        DECLARE RB2_rating INT;
        DECLARE WR_rating INT;
        DECLARE WR2_rating INT;
        DECLARE TE_rating INT;
        DECLARE D_ST_rating INT;
        DECLARE K_rating INT;
        DECLARE Flex_rating INT;

        SET @username = (SELECT new.username FROM User_Team LIMIT 1);

        SET @QB_rating = (SELECT (((0.04 * passing_yds) + (0.1 * rushing_yds) + (6 * rush_touchdowns) + (-2 * turnovers) + (4 * pass_touchdowns)) / 5)
                                FROM NFL_Players_QB
                                WHERE player_name = new.QB);

        SET @RB_rating = (SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_RB
                                WHERE player_name = new.RB);

        SET @RB2_rating = (SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_RB
                                WHERE player_name = new.RB2);

        SET @WR_rating = (SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_WR
                                WHERE player_name = new.WR);

        SET @WR2_rating = (SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_WR
                                WHERE player_name = new.WR2);  

        SET @TE_rating = (SELECT (((0.1 * receiving_yds) + receptions + (-2 * fumbles) + (6 * touchdowns)) / 4)
                                FROM NFL_Players_TE
                                WHERE player_name = new.TE);

        SET @D_ST_rating = (SELECT (((2 * interceptions) + (1 * sacks) + (2 * fumbles) + (2 * safety) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_D_ST
                                WHERE team = new.D_ST);

        SET @K_rating = (SELECT (((1 * extrapt_made) + (-1 * extrapt_missed) + (-1 * fg_missed) + (3 * fg_made)) / 4)
                                FROM NFL_Players_K
                                WHERE player_name = new.K);

        SET @Flex_rating = (SELECT (((0.1 * rushing_yds) + receptions + (0.1 * receiving_yds) + (-2 * fumbles) + (6 * touchdowns)) / 5)
                                FROM NFL_Players_WR
                                WHERE player_name = new.FLEX);

        IF @username IS NOT NULL AND @QB_rating IS NOT NULL AND @RB_rating IS NOT NULL AND @RB2_rating IS NOT NULL AND @WR_rating IS NOT NULL AND @WR2_rating IS NOT NULL AND @TE_rating IS NOT NULL AND @D_ST_rating IS NOT NULL AND @K_rating IS NOT NULL AND @Flex_rating IS NOT NULL THEN
            UPDATE User_Team_Ratings
            SET username = new.username, qb_rating = @QB_rating, rb_rating =  @RB_rating, rb2_rating = @RB2_rating, wr_rating = @WR_rating, wr2_rating = @WR2_rating, te_rating = @TE_rating, D_ST_rating = @D_ST_rating, K_rating = @K_rating, Flex_rating = @Flex_rating
            WHERE username = new.username;

        END IF;


    END$$
DELIMITER ;