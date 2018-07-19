require_relative 'artist'

# Class for working with Battles and Artist class
class Handler
  attr_reader :rappers
  def initialize
    @rappers = battlers
  end

  def sort_top_rappers(number)
    rappers.values.sort_by { |item| - item.count_bad_words }.first(number)
  end

  private

  def battlers
    Dir.glob('./battles2/*').each_with_object({}) do |file_name, rappers|
      next unless File.file?(file_name)
      rapper_name = find_artist_by_name(file_name)
      rappers[rapper_name] ||= Artist.new(rapper_name)
      rappers[rapper_name].add_battles(file_name)
    end
  end

  def find_artist_by_name(file_name)
    rappers.class.equal?(Hash)
    file_name.split(/#|против|vs|VS|aka/) \
             .first.split('/').last.strip
  end
end