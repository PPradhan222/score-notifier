module ApplicationHelper
  # def abbreviate(phrase)
  #   if(phrase.split(" ").length )
  #   phrase.gsub('-', ' ')
  #         .scan(/(\A\w|(?<=\s)\w)/)
  #         .flatten
  #         .join.upcase
  #    end     
  # end

  def match_number(match)
    match.split(",").drop(1).join(", ")
  end

  def match_name(match)
    match.split(",").first
  end
end
