class MatchesController << ApplicationController

  def index

  end

  def create
    if session[:matches]
      session[:matches] << @images_facade.photos.shift
    else
      session[:matches] = [ @images_facade.photos.shift ]
    end
    redirect_to images_path
  end

end