require 'open-uri'

class Crawler::Cast

  include Crawler::Private::Get
  
  attr_reader :file_name, :source_path_html, :source_path_cast

  def initialize(option = {})
    @source_path_html = "source/cast/html/"
    @source_path_content = "source/cast/content/"
  end

  def crawler_web
    File.open("source/year_list.txt", 'r').each do |year|
      @year = year.gsub("\n","")
      puts @year
      File.open("source/movie/content/#{@year}.txt", 'r').each_with_index do |movie, index|
        if index % 2 == 0
          @file_name = file_named(movie)
        else
          begin
            @url = movie.gsub("\n", "")
            # puts "#{@file_name}"
            file_writter(Nokogiri::HTML(open("https://www.rottentomatoes.com#{@url}")).to_s)
            puts "sucess: #{@file_name}"
          rescue 
            puts "not scuess: #{@file_name}"
          #   puts "https://www.rottentomatoes.com#{@url}"
          end
        end
      end
    end
  end

  def start_word
    '<h2 class="panel-heading">Cast</h2>'
  end

  def end_word
    '<section id="newsSection"'
  end

  def file_writter(doc)
    file_html = File.open("#{@source_path_html}#{@file_name}.txt", 'w')
    file_content = File.open("#{@source_path_content}#{@file_name}.txt", 'w')
    
    file_html.write(doc)
    file_content.write(get_content_cast(doc))
    
    file_html.close()
    file_content.close()
  end

end
