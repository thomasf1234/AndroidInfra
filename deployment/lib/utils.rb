class Utils
  def self.between_quotes(string)
    string.match(/'.*'/).to_s.gsub("'", "")
  end
end