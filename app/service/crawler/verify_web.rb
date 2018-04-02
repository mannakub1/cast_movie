require 'open-uri'

class Crawler::VerifyWeb

  include Crawler::Private::Get
  attr_reader :file_name, :source_path_html, :source_path_cast

  def initialize(option = {})
    @source_path_html = "source/cast/html/"
    @source_path_content = "source/cast/content/"
  end

  def validation
    
    File.open("source/year_list.txt", 'r').each do |year|
      @year = year.gsub("\n","")
      puts @year
      str = ""
      File.open("source/movie/content/#{@year}.txt", 'r').each do |movie|
        begin
          @file_name = file_named(movie)
          t = Nokogiri::HTML(open("https://www.rottentomatoes.com/m/#{@file_name}"))
          str += "#{movie}" + "\n"
          puts "sucess: #{@file_name}"
        rescue 
          puts "not scuess: #{@file_name}"
          str += "#{movie}" + " 2017\n"
        end
      end
      f = File.open("source/movie/content/#{@year}.txt",'w')
      f.write(str)
      f.close()
    end
  end


end
