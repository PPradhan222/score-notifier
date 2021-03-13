module WebScrapper
  class UpdateInnings
    attr_reader :innings

    def initialize(innings, match)
      create_innings(innings, match)
      @innings = innings
    end

    def call
      innings.each do |inning|
        inning[:batting_card].each do |batsman|
          ActiveRecord::Base.transaction do
            profile_url = batsman[:profile_url]
            player = Player.find_or_create_by(web_profile_id: profile_url.split("/")[-2])
            batsman.delete(:profile_url)
            batsman[:player_id] = player.id
            inning[:object].batting_player_innings.find_or_create_by(batsman)
          end
        end
        inning[:bowling_card].each do |bowler|
          ActiveRecord::Base.transaction do
            profile_url = bowler[:profile_url]
            player = Player.find_or_create_by(web_profile_id: profile_url.split("/")[-2])
            bowler.delete(:profile_url)
            bowler[:player_id] = player.id
            inning[:object].bowling_player_innings.find_or_create_by(bowler)
          end
        end
      end
    end

    def create_innings(innings, match)
      innings.each do |inning|
        inning[:object] = match.innings.find_or_create_by(inning_number: inning[:inning_number], name: inning[:name], runs: inning[:runs], wickets: inning[:wickets], overs: inning[:overs])
      end
    end
  end
end