module ApplicationHelper
  def blizzardize(string)
    string.delete("'").gsub(/\s/, '-').downcase
  end
end
