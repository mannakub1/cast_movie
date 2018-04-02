require 'open-uri'

class Crawler::TestCrawler
  
  def initialize(option = {})

  end

  def caller_web
    file_writter(File.open("caller_web.txt",'r').read)
    # file_writter(Nokogiri::HTML(open("https://www.rottentomatoes.com/m/Captain_America_Civil_War")).to_s)
    
  end

  def get_cast_list(doc)
    # get_cast(doc[doc.index('<div class="cast-item media inlineBlock ">')..doc.index('<a href="javascript:void(0)"')])
  end

  def get_cast(doc)
    docc = Nokogiri::HTML(File.open("caller_web.txt"))
    puts docc.css('span')[0].children.to_s.strip
    puts docc.css('span')[1].children.to_s.strip.gsub('<br>','')
    
  end


  def file_writter(doc)
    # file = File.open("caller_web.txt", 'w')
    # file.write(get_cast_list(doc))
    # file.close()
    get_cast_list(doc)
  end

end
 