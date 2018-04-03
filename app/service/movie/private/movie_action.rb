module Movie::Private::MovieAction

  private 

  def process_add
    Movie.create(params)
  end

  def process_edit
    current_movie.update_attributes(params)
  end

  def process_delete
    current_movie.destroy
  end

end
