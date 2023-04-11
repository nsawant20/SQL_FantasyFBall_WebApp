import http.client
import json
import csv
import time

conn = http.client.HTTPSConnection("api.sportradar.us")
key = "q7yh2uahwqsqsbkgwybgtjsb"

# schedule
# conn.request("GET", "/nfl/official/trial/v7/en/games/2022/reg/schedule.json?api_key=" + key)

# injuries
# conn.request("GET", "/nfl/official/trial/v7/en/seasons/2022/REG/1/injuries.json?api_key=" + key)

# league
# conn.request("GET", "/nfl/official/trial/v7/en/league/hierarchy.json?api_key=" + key)


# schedule NOT USED
# file_sched = open('teams_schedule.csv', 'w')
# writer_sched = csv.writer(file_sched)
# writer_sched.writerow(["home", "away", "week_#", "wins", "losses"])   
# res = conn.getresponse()
# schedule_data = res.read()
# schedule_data = json.loads(schedule_data)
# for i in range(len(schedule_data["weeks"])):
#     for game in schedule_data["weeks"][i]["games"]:
#         home = game["home"]["alias"]
#         away = game["away"]["alias"]
#         curr = [home, away, i + 1]
#         writer_sched.writerow(curr)
# file_sched.close()

# teams schedule
# file_sched = open('nfl_teams.csv', 'w')
# writer_sched = csv.writer(file_sched)
# writer_sched.writerow(["team_id", "team", "wins", "losses", "ties", "points_for", "points_against", "strength_of_schedule", "strength_of_victory"])   
# path = "/nfl/official/trial/v7/en/seasons/2022/REG/standings/season.json?api_key=" + key
# conn.request("GET", path)
# res = conn.getresponse()
# sched_data = res.read()
# sched_data = json.loads(sched_data)
# for conference in sched_data["conferences"]:
#     for division in conference["divisions"]:
#         for team in division["teams"]:
#             curr = [team["id"], team["alias"], team["wins"], team["losses"], team["ties"], team["points_for"], team["points_against"], team["strength_of_schedule"]["sos"], team["strength_of_victory"]["sov"]]
#             writer_sched.writerow(curr)
# file_sched.close()


# injuries
file_injuries = open('injuries.csv', 'w')
writer_injuries = csv.writer(file_injuries)
writer_injuries.writerow(["player_id", "player", "team", "position", "injury", "week_injured"])   
for i in range(1, 8):
    time.sleep(1)
    path = "/nfl/official/trial/v7/en/seasons/2022/REG/" + str(i) + "/injuries.json?api_key=" + key
    conn.request("GET", path)
    res = conn.getresponse()
    inj_data = res.read()
    inj_data = json.loads(inj_data)
    print(i)
    for team in inj_data["teams"]:
        for player in team["players"]:
            for injury in player["injuries"]:
                injury_name = ""
                if "primary" in injury:
                    injury_name = injury["primary"]
                curr = [player["id"], player["name"], team["alias"], player["position"], injury_name, i]
                writer_injuries.writerow(curr)

# players
# team_IDs = []
# for conference in data["conferences"]:
#     for division in conference["divisions"]:
#         for team in division["teams"]:
#             team_IDs.append(team["id"])
# print(team_IDs)

# team roster
# filewr = open('players_wr.csv', 'w')
# writer_wr = csv.writer(filewr)
# writer_wr.writerow(["player_id", "player_name", "team", "rushing_yds", "receptions", "receiving_yds", "fumbles", "touchdowns"])   

# filerb = open('players_rb.csv', 'w')
# writer_rb = csv.writer(filerb)
# writer_rb.writerow(["player_id", "player_name", "team", "rushing_yds", "receptions", "receiving_yds", "fumbles", "touchdowns"]) 

# fileqb = open('players_qb.csv', 'w')
# writer_qb = csv.writer(fileqb)
# writer_qb.writerow(["player_id", "player_name", "team", "passing_yds", "rushing_yds", "turnovers", "pass_touchdowns", "rush_touchdowns"]) 

# filete = open('players_te.csv', 'w')
# writer_te = csv.writer(filete)
# writer_te.writerow(["player_id", "player_name", "team", "receiving_yds", "receptions", "fumbles", "touchdowns"]) 

# filek = open('players_k.csv', 'w')
# writer_k = csv.writer(filek)
# writer_k.writerow(["player_id", "player_name", "team", "extrapt_made", "extrapt_missed", "fg_made", "fg_missed"]) 

# filedst = open('teams_dst.csv', 'w')
# writer_dst = csv.writer(filedst)
# writer_dst.writerow(["team_id", "team", "interceptions", "sacks", "fumbles", "safety", "touchdowns"]) 

# for team in team_IDs:
# team = team_IDs[0]
    # time.sleep(1)
    # conn = http.client.HTTPSConnection("api.sportradar.us")
    # path = "/nfl/official/trial/v7/en/teams/" + team + "/full_roster.json?api_key=" + key

    # for d/st
    # print(team)
    # path = "/nfl/official/trial/v7/en/seasons/2022/REG/teams/" + team + "/statistics.json?api_key=" + key
    # conn.request("GET", path)
    # res = conn.getresponse()
    # team_data = res.read()
    # team_data = json.loads(team_data)
    # fumbles = 0
    # interceptions = 0
    # sacks = 0
    # safety = 0
    # touchdowns = 0

    # touchdowns = team_data["record"]["touchdowns"]["total_return"]

    # safety = team_data["record"]["defense"]["safeties"]

    # sacks = team_data["record"]["defense"]["sacks"]
    # interceptions = team_data["record"]["defense"]["interceptions"]

    # fumbles = team_data["record"]["defense"]["fumble_recoveries"]


    # curr = [team, team_data["alias"], interceptions, sacks, fumbles, safety, touchdowns]
    # writer_dst.writerow(curr)    
    
    # for player in data["players"]:
        # if player["position"] == "WR":
            # time.sleep(1)
            # path = "/nfl/official/trial/v7/en/players/" + player["id"] + "/profile.json?api_key=" + key
            # conn.request("GET", path)
            # res = conn.getresponse()
            # wr_data = res.read()
            # wr_data = json.loads(wr_data)
            # if len(wr_data["seasons"]) != 0:
            #     fumbles = 0
            #     receiving_yds = 0
            #     receiving_recs = 0
            #     rushing = 0
            #     touchdowns = 0
            #     print(player["id"])
            #     if "rushing" in wr_data["seasons"][-1]["teams"][-1]["statistics"]:
            #         rushing = wr_data["seasons"][-1]["teams"][-1]["statistics"]["rushing"]["yards"]
            #     if "receiving" in wr_data["seasons"][-1]["teams"][-1]["statistics"]:
            #         receiving_recs = wr_data["seasons"][-1]["teams"][-1]["statistics"]["receiving"]["receptions"]
            #         receiving_yds = wr_data["seasons"][-1]["teams"][-1]["statistics"]["receiving"]["yards"]
            #     if "fumbles" in wr_data["seasons"][-1]["teams"][-1]["statistics"]:
            #         fumbles = wr_data["seasons"][-1]["teams"][-1]["statistics"]["fumbles"]["fumbles"]
            #     if rushing != 0:
            #         touchdowns += wr_data["seasons"][-1]["teams"][-1]["statistics"]["rushing"]["touchdowns"]
            #     if receiving_yds != 0 or receiving_recs != 0:
            #         touchdowns += wr_data["seasons"][-1]["teams"][-1]["statistics"]["receiving"]["touchdowns"]
            #     curr = [player["id"], player["name"], data["alias"], rushing, receiving_recs, receiving_yds, fumbles, touchdowns]
            #     writer_wr.writerow(curr)        

        
        # if player["position"] == "RB":
        #     writer_rb = csv.writer(filerb)
        #     time.sleep(1)
        #     path = "/nfl/official/trial/v7/en/players/" + player["id"] + "/profile.json?api_key=" + key
        #     conn.request("GET", path)
        #     res = conn.getresponse()
        #     rb_data = res.read()
        #     rb_data = json.loads(rb_data)
        #     if len(rb_data["seasons"]) != 0:
        #         fumbles = 0
        #         receiving_yds = 0
        #         receiving_recs = 0
        #         rushing = 0
        #         touchdowns = 0
        #         print(player["id"])
        #         if "rushing" in rb_data["seasons"][-1]["teams"][-1]["statistics"]:
        #             rushing = rb_data["seasons"][-1]["teams"][-1]["statistics"]["rushing"]["yards"]
        #         if "receiving" in rb_data["seasons"][-1]["teams"][-1]["statistics"]:
        #             receiving_recs = rb_data["seasons"][-1]["teams"][-1]["statistics"]["receiving"]["receptions"]
        #             receiving_yds = rb_data["seasons"][-1]["teams"][-1]["statistics"]["receiving"]["yards"]
        #         if "fumbles" in rb_data["seasons"][-1]["teams"][-1]["statistics"]:
        #             fumbles = rb_data["seasons"][-1]["teams"][-1]["statistics"]["fumbles"]["fumbles"]
        #         if rushing != 0:
        #             touchdowns += rb_data["seasons"][-1]["teams"][-1]["statistics"]["rushing"]["touchdowns"]
        #         if receiving_yds != 0 or receiving_recs != 0:
        #             touchdowns += rb_data["seasons"][-1]["teams"][-1]["statistics"]["receiving"]["touchdowns"]
        #         curr = [player["id"], player["name"], data["alias"], rushing, receiving_recs, receiving_yds, fumbles, touchdowns]
        #         writer_rb.writerow(curr)    
        
        # if player["position"] == "QB":
        #     writer_qb = csv.writer(fileqb)
        #     time.sleep(1)
        #     path = "/nfl/official/trial/v7/en/players/" + player["id"] + "/profile.json?api_key=" + key
        #     conn.request("GET", path)
        #     res = conn.getresponse()
        #     qb_data = res.read()
        #     qb_data = json.loads(qb_data)
        #     if len(qb_data["seasons"]) != 0:
        #         turnovers = 0
        #         passing_yds = 0
        #         rushing_yds = 0
        #         rushing_tds = 0
        #         passing_tds = 0
        #         print(player["id"])
        #         if "rushing" in qb_data["seasons"][-1]["teams"][-1]["statistics"]:
        #             rushing_yds = qb_data["seasons"][-1]["teams"][-1]["statistics"]["rushing"]["yards"]
        #             rushing_tds = qb_data["seasons"][-1]["teams"][-1]["statistics"]["rushing"]["touchdowns"]
        #         if "passing" in qb_data["seasons"][-1]["teams"][-1]["statistics"]:
        #             passing_tds = qb_data["seasons"][-1]["teams"][-1]["statistics"]["passing"]["touchdowns"]
        #             passing_yds = qb_data["seasons"][-1]["teams"][-1]["statistics"]["passing"]["yards"]
        #             turnovers += qb_data["seasons"][-1]["teams"][-1]["statistics"]["passing"]["interceptions"]
        #         if "fumbles" in qb_data["seasons"][-1]["teams"][-1]["statistics"]:
        #             turnovers += qb_data["seasons"][-1]["teams"][-1]["statistics"]["fumbles"]["fumbles"]
        #         curr = [player["id"], player["name"], data["alias"], passing_yds, rushing_yds, turnovers, passing_tds, rushing_tds]
        #         writer_qb.writerow(curr)   
        
        # if player["position"] == "TE":
        #     writer_te = csv.writer(filete)
        #     time.sleep(1)
        #     print(player["id"])
        #     path = "/nfl/official/trial/v7/en/players/" + player["id"] + "/profile.json?api_key=" + key
        #     conn.request("GET", path)
        #     res = conn.getresponse()
        #     rb_data = res.read()
        #     rb_data = json.loads(rb_data)
        #     if len(rb_data["seasons"]) != 0:
        #         fumbles = 0
        #         receiving_yds = 0
        #         receiving_recs = 0
        #         rushing = 0
        #         touchdowns = 0
        #         if "receiving" in rb_data["seasons"][-1]["teams"][-1]["statistics"]:
        #             receiving_recs = rb_data["seasons"][-1]["teams"][-1]["statistics"]["receiving"]["receptions"]
        #             receiving_yds = rb_data["seasons"][-1]["teams"][-1]["statistics"]["receiving"]["yards"]
        #             touchdowns = rb_data["seasons"][-1]["teams"][-1]["statistics"]["receiving"]["touchdowns"]
        #         if "fumbles" in rb_data["seasons"][-1]["teams"][-1]["statistics"]:
        #             fumbles = rb_data["seasons"][-1]["teams"][-1]["statistics"]["fumbles"]["fumbles"]
        #         curr = [player["id"], player["name"], data["alias"], receiving_yds, receiving_recs, fumbles, touchdowns]
        #         writer_te.writerow(curr)    
        
        # if player["position"] == "K":
        #     print(player["id"])
        #     writer_k = csv.writer(filek)
        #     time.sleep(1)
        #     path = "/nfl/official/trial/v7/en/players/" + player["id"] + "/profile.json?api_key=" + key
        #     conn.request("GET", path)
        #     res = conn.getresponse()
        #     rb_data = res.read()
        #     rb_data = json.loads(rb_data)
        #     if len(rb_data["seasons"]) != 0:
        #         extrapt_made = 0
        #         extrapt_missed = 0
        #         fg_made = 0
        #         fg_missed = 0
        #         if "field_goals" in rb_data["seasons"][-1]["teams"][-1]["statistics"]:
        #             fg_made = rb_data["seasons"][-1]["teams"][-1]["statistics"]["field_goals"]["made"]
        #             fg_missed = rb_data["seasons"][-1]["teams"][-1]["statistics"]["field_goals"]["attempts"] - fg_made
        #         if "extra_points" in rb_data["seasons"][-1]["teams"][-1]["statistics"]:
        #             extrapt_made = rb_data["seasons"][-1]["teams"][-1]["statistics"]["extra_points"]["made"]
        #             extrapt_missed = rb_data["seasons"][-1]["teams"][-1]["statistics"]["extra_points"]["attempts"] - extrapt_made
        #         curr = [player["id"], player["name"], data["alias"], extrapt_made, extrapt_missed, fg_made, fg_missed] 
        #         writer_k.writerow(curr)   
        

# filewr.close()
# filerb.close()
# fileqb.close()
# filete.close()
# filek.close()
# filedst.close()

