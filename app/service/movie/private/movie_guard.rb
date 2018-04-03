module Movie::Private::MovieGuard

  private

  def can_add?
    return [false, 'movie is exist'] if movie_name?

    [true, '']
  end

  def can_edit?
    return [false, 'movie isn\'t exist'] unless movie_exist?

    [true, '']
  end

  def can_delete?
    return [false, 'movie isn\'t exist'] unless movie_exist?

    [true, '']
  end

  def movie_name?
    puts params[:name]
    Movie.find_by(name: params[:name])
  end

  def movie_exist?
    current_movie
  end

end