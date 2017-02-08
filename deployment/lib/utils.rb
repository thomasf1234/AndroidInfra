class Utils
  def self.between_quotes(string)
    string.match(/'.*'/).to_s.gsub("'", "")
  end

  def self.latest_version(versions)
    ascending_versions = versions.sort_by {|version| Gem::Version.new(version)}
    return ascending_versions.last
  end
end