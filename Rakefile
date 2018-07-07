task :console do
  require 'irb'
  require 'irb/completion'
  require 'central_sports' # You know what to do.

  def reload!
    # Change 'my_gem' here too:
    files = $LOADED_FEATURES.select { |feat| feat =~ /\/my_gem\// }
    files.each { |file| load file }
  end

  ARGV.clear
  IRB.start
end

task :update_clubs  do
  require 'yaml'
  require 'central_sports'

  file_path = File.join('lib', 'data', 'clubs.yml')
  clubs = YAML::load(File.open(file_path)) || []
  [*0..1000].each do |n|
    begin
      next if clubs.any? { |c| c[:id] == n }
      c = CentralSports::Client.new(n)

      club = {
        id: n,
        name: c.schedule.club.name
      }

      clubs << club

      puts "Adding #{club[:name]}"

    rescue CentralSports::Client::ClubDoesNotExistError
      puts "nothing found for #{n} "
      next
    end
  end
  File.open(file_path, 'w') { |f| f.write(clubs.to_yaml) }
end

task :translate_club_names do
  require 'yaml'
  require 'central_sports'

  file_path = File.join('lib', 'data', 'clubs.yml')
  clubs = YAML::load(File.open(file_path)) || []

  clubs.each do |club|
    if club[:name_en].nil?
      puts club[:name]
      club[:name_en] = STDIN.gets.chomp
      File.open(file_path, 'w') { |f| f.write(clubs.to_yaml) }
    end
  end
end
