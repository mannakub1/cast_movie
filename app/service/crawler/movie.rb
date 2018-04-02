require 'open-uri'

class Crawler::Movie
  
  include Crawler::Private::Get

  attr_reader :file_name, :source_path_html, :source_path_content

  def initialize(option = {})
    @source_path_html = "source/movie/html/"
    @source_path_content = "source/movie/content/"
  end

  def crawler_web
    File.open("source/year_list.txt", 'r').each do |movie|
      begin
        @file_name = file_named(movie)
        file_writter(File.open("source/movie/html/#{@file_name}.txt", 'r').read)
        # file_writter(Nokogiri::HTML(open("https://www.rottentomatoes.com/top/bestofrt/?year=#{@file_name}")).to_s)
        puts "sucess: #{@file_name}"
      rescue 
        puts "not scuess: #{@file_name}"
      end
    end
  
  end

  def start_word
    '<td class="bold">1.</td>'
  end

  def end_word
    '</table>'
  end

  def file_writter(doc)
    file_html = File.open("#{@source_path_html}#{@file_name}.txt", 'w')
    file_content = File.open("#{@source_path_content}#{@file_name}.txt", 'w')
    
    file_html.write(doc)
    file_content.write(get_content_movie(doc))
    
    file_html.close()
    file_content.close()
  end
end
