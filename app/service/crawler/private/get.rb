module Crawler::Private::Get
  private
  require 'open-uri'

 
  def get_content_cast(doc)
    content_cast(Nokogiri::HTML(get_sentence(doc)))
  end

  def get_content_movie(doc)
    content_movie(Nokogiri::HTML(get_sentence(doc)))
  end

  def content_cast(doc)
    str_sum = ""
    if doc.css('span').size > 0
      doc.css('span').each_with_index { |x, index| if index % 2 == 0 then str_sum += x.children.to_s.strip+" " else str_sum += x.children.to_s.strip.gsub('<br>','')+"\n" end }
    end
    # puts "5"
    str_sum
  end

  def content_movie(doc)
    str_sum = ""
    scores, num_reviews = [], []
    doc.css('span').each{ |x| if x.css("span").children.to_s.size >1 then scores << x.css("span").children.to_s[1..4] end }
    doc.css("td").each { |x| if x['class'] == "right hidden-xs" then num_reviews << x.children.to_s end}
    doc.css('a').each_with_index{ |x, index| str_sum += x.children.to_s.gsub("(", "").gsub(")", "").strip+"\n"+ x['href']+" " + scores[index]+" " + num_reviews[index] +"\n" }
    # puts scores.size
    # puts str_sum.split("\n").size
    str_sum
  end

  def content_movie_test(doc)
    str_sum = ""
    doc.css('a').each{ |x| str_sum += x.children.to_s[0..x.children.to_s.index("(")-2].strip+"\n"+ x['href'] +"\n"}
    str_sum
  end

  def get_sentence(doc)
    doc[doc.index(start_word)..doc.index(end_word, doc.index(start_word))]
  end

  def file_named(file)
    file.downcase.gsub(/[^a-z0-9\s]/i, " ").gsub("  ", " ").gsub(" ","_").strip
  end

end
