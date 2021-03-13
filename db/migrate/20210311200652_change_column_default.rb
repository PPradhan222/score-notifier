class ChangeColumnDefault < ActiveRecord::Migration[6.0]
  def change
    change_column_default :batting_player_innings, :runs_scored, from: nil, to: 0
    change_column_default :batting_player_innings, :balls_faced, from: nil, to: 0
    change_column_default :batting_player_innings, :fours, from: nil, to: 0
    change_column_default :batting_player_innings, :sixes, from: nil, to: 0
    change_column_default :batting_player_innings, :strike_rate, from: nil, to: 0.0
    change_column_default :batting_player_innings, :wicket_status, from: nil, to: 'not_batted'
    change_column_default :bowling_player_innings, :runs_conceded, from: nil, to: 0
    change_column_default :bowling_player_innings, :wickets_taken, from: nil, to: 0
    change_column_default :bowling_player_innings, :maiden_overs, from: nil, to: 0
    change_column_default :bowling_player_innings, :economy_rate, from: nil, to: 0.0
    change_column_default :bowling_player_innings, :overs, from: nil, to: 0.0
  end
end
