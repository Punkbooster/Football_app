require 'spec_helper'
require 'league_table'
require 'pry'

describe LeagueTable do
  before :each do
    @league = LeagueTable.new
    @league.add_match('Man Utd 3 - 1 Liverpool')
  end

  it 'should respond to teams' do
    expect(@league).to respond_to(:teams)
  end

  it 'should respond to error' do
    expect(@league).to respond_to(:error)
  end

  describe '#add_match' do
    it 'should extract proper names from string' do
      # binding.pry
      expect(@league.teams).to have_key('Man Utd')
      expect(@league.teams).to have_key('Liverpool')
    end

    it 'all values should be properly assigned' do
      expect(@league.teams['Man Utd'].name).to eq('Man Utd')
      expect(@league.teams['Man Utd'].wins).to eq(1)
      expect(@league.teams['Man Utd'].loses).to eq(0)
      expect(@league.teams['Man Utd'].goals).to eq(3)
      expect(@league.teams['Man Utd'].points).to eq(3)
      expect(@league.teams['Man Utd'].conceeded).to eq(1)
      expect(@league.teams['Man Utd'].draws).to eq(0)
      expect(@league.teams['Liverpool'].goals).to eq(1)
      expect(@league.teams['Liverpool'].loses).to eq(1)
    end

    it 'after another match with the same team all values should be updated' do
      @league.add_match('Chelsea 5 - 2 Man Utd')
      expect(@league.teams['Man Utd'].wins).to eq(1)
      expect(@league.teams['Man Utd'].loses).to eq(1)
      expect(@league.teams['Man Utd'].goals).to eq(5)
      expect(@league.teams['Man Utd'].points).to eq(3)
      expect(@league.teams['Man Utd'].conceeded).to eq(6)
      expect(@league.teams['Man Utd'].draws).to eq(0)
      expect(@league.teams['Chelsea'].goals).to eq(5)
      expect(@league.teams['Chelsea'].loses).to eq(0)
    end
  end

  describe '#get_points' do
    it 'should return proper amount of points' do
      expect(@league.get_points('Man Utd')).to eq(3)
      expect(@league.get_points('Liverpool')).to eq(0)
    end

    it 'should return nil if team does not exist in the database' do
      # binding.pry
      # expect(@league.get_points('No team')).to raise_error(NameError) #no idea
      expect(@league.get_points('No team')).to eq(nil)
    end
  end

  describe '#get_goals_for' do
    it 'should return proper amount of goals' do
      expect(@league.get_goals_for('Man Utd')).to eq(3)
      expect(@league.get_goals_for('Liverpool')).to eq(1)
    end
  end

  describe '#get_goals_against' do
    it 'should return proper amount of goals that team has conceeded' do
      expect(@league.get_goals_against('Man Utd')).to eq(1)
      expect(@league.get_goals_against('Liverpool')).to eq(3)
    end
  end

  describe '#get_goal_difference' do
    it 'should return proper difference of scored and conceeded' do
      expect(@league.get_goal_difference('Man Utd')).to eq(2)
      expect(@league.get_goal_difference('Liverpool')).to eq(-2)
    end
  end

  describe '#get_wins' do
    it 'should return proper amount of wins' do
      expect(@league.get_wins('Man Utd')).to eq(1)
      expect(@league.get_wins('Liverpool')).to eq(0)
    end
  end

  describe '#get_draws' do
    it 'should return proper amount of draws' do
      expect(@league.get_draws('Man Utd')).to eq(0)
      expect(@league.get_draws('Liverpool')).to eq(0)
    end
  end

  describe '#get_losses' do
    it 'should return proper amount of draws' do
      expect(@league.get_losses('Man Utd')).to eq(0)
      expect(@league.get_losses('Liverpool')).to eq(1)
    end
  end
end
