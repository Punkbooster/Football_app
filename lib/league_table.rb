class Team
  attr_accessor :name, :wins, :loses, :goals, :points, :draws, :conceeded

  def initialize(name)
    self.name = name
    self.wins = 0
    self.loses = 0
    self.goals = 0
    self.conceeded = 0
    self.points = 0
    self.draws = 0
  end
end

class LeagueTable
  attr_accessor :teams, :error

  def initialize
    self.teams = {}
    self.error = 'Error: wrong name'
  end

  def add_match(match)
    strings = match.split('-')
    team1 = strings[0]
    score1 = parse_score team1
    name1 = team1.slice(0, team1.index(score1.to_s)).strip

    team2 = strings[1]
    score2 = parse_score team2
    name2 = team2.slice(team2.index(score2.to_s) + 2, team2.length - 1).strip

    teams[name1] = Team.new name1 unless teams[name1]

    teams[name2] = Team.new name2 unless teams[name2]

    if score1 > score2
      teams[name1].wins += 1
      teams[name2].loses += 1
      teams[name1].points += 3
    elsif score1 < score2
      teams[name2].wins += 1
      teams[name1].loses += 1
      teams[name2].points += 3
    elsif score1 == score2
      teams[name1].drawes += 1
      teams[name2].drawes += 1
      teams[name1].points += 1
      teams[name2].points += 1
    end

    teams[name1].goals += score1
    teams[name1].conceeded += score2

    teams[name2].goals += score2
    teams[name2].conceeded += score1
    # puts teams
  end

  def parse_score(str)
    (str.scan(/\d/).join'').to_i
  end

  def get_points(team_name) # Returns the no. of points a team has, 0 by default
    if teams[team_name]
      teams[team_name].points
    else puts error
    end
  end

  def get_goals_for(team_name) # Returns the no. of goals a team has scored
    if teams[team_name]
      teams[team_name].goals
    else puts error
    end
  end

  def get_goals_against(team_name)
    # Returns the no. of goals a team has conceeded (had scored against them)
    if teams[team_name]
      teams[team_name].conceeded
    else puts error
    end
  end

  def get_goal_difference(team_name)
    # Return the difference of scored and conceeded goals
    if teams[team_name]
      teams[team_name].goals - teams[team_name].conceeded
    else puts error # raise NameError, error (doesn't work with tests)
    end
  end

  def get_wins(team_name) # Return the no. of wins a team has, 0 by default
    if teams[team_name]
      teams[team_name].wins
    else puts error # raise NameError, error (doesn't work with tests)
    end
  end

  def get_draws(team_name) # Return the no. of draws a team has, 0 by default
    if teams[team_name]
      teams[team_name].draws
    else puts error # raise NameError, error (doesn't work with tests)
    end
  end

  def get_losses(team_name) # Return the no. of losses a team has, 0 by default
    if teams[team_name]
      teams[team_name].loses
    else puts error # raise NameError, error (doesn't work with tests)
    end
  end
end

# lt = LeagueTable.new
# lt.add_match("Man Utd 3 - 1 Liverpool")
# lt.add_match("Man Utd 1 - 0 Arsenal")
# puts "Wins: #{lt.get_wins("Man Utd")}"
# puts "Points: #{lt.get_points("Arsenal")}"
