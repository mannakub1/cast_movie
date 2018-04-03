class Movie::MovieAction

  include Movie::Private::MovieGuard
  include Movie::Private::MovieAction

  attr_reader :params

  def initialize(option = {})
    @movie_id = option[:movie_id]
  end

  def add(params)
    @params = params

    can_add, message = can_add?
    fail message unless can_add

    process_add
  end

  def edit(params)
    @params = params

    can_edit, message = can_edit?
    fail message unless can_edit

    process_edit
  end

  def delete
    can_delete, message = can_delete?
    fail message unless can_delete

    process_delete 
  end 

  def read_file

    name = ""
    Dir.entries("#{path_source}").each do |file|
      if file.size == 8
          File.open("#{path_source}#{file}",'r').each_with_index do |x, index|
            if index % 2 == 0 
              name = x.gsub("\n","")
              puts name
            else 
              detail = x.split(" ")
              Movie::MovieAction.new.add(name: name, href: detail[0], score: detail[1], num_review: detail[2], file_name: file_named(name), year: file[0..3], key: name+" "+detail[1]+" "+ detail[2])
            end
          end
      end
    end
  end

  def file_named(file)
    file.downcase.gsub(/[^a-z0-9\s]/i, " ").gsub("  ", " ").gsub(" ","_").strip
  end

  def path_source
    "source/movie/content/"
  end

  def current_movie
    Movie.find_by(id: @movie_id)
  end
end