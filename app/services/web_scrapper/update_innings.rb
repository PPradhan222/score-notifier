module WebScrapper
  class UpdateInnings
    attr_reader :innings

    def initialize(innings, match, match_result)
      match.update(result: match_result)
      create_or_update_innings(innings, match)
      @innings = innings
    end

    def call
      innings.each do |inning|
        inning[:batting_card].each do |batsman|
          ActiveRecord::Base.transaction do
            player = Player.find_or_create_by(web_profile_id: batsman[:profile_url]&.split("/")&.dig(-2))
            profile_url = batsman.delete(:profile_url)
            player&.update(web_profile_url: profile_url) unless player&.web_profile_url
            inning[:object]&.batting_player_innings&.find_or_create_by(player_id: player.id)&.update(batsman)
          end
        end
        inning[:bowling_card].each do |bowler|
          ActiveRecord::Base.transaction do
            player = Player.find_or_create_by(web_profile_id: bowler[:profile_url]&.split("/")&.dig(-2))
            profile_url = bowler.delete(:profile_url)
            player&.update(web_profile_url: profile_url) unless player&.web_profile_url
            inning[:object]&.bowling_player_innings&.find_or_create_by(player_id: player.id)&.update(bowler)
          end
        end
      end
    end

    private

    def create_or_update_innings(innings, match)
      innings.each do |inning|
        inning[:object] = match&.innings&.find_or_create_by(inning_number: inning[:inning_number])
        inning[:object]&.update(name: inning[:name], runs: inning[:runs], wickets: inning[:wickets], overs: inning[:overs])
      end
    end
  end
end