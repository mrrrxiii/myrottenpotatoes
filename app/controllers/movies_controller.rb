class MoviesController < ApplicationController
  def index
    @movies=Movie.all
  end
  
  def show
    id = params[:id] #retrievw movie ID from URI route
    @movie=Movie.find(id)
    # will render app / views / movies / show . html . haml by default
  end
  
  
  def new 
    @movie=Movie.new
  end
  
  def create
    params.require(:movie)
    newmovie=params[:movie].permit(:title, :rating, :release_date)
    
    @movie=Movie.create!(newmovie)
    flash[:notice]="#{@movie.title} was successfully created!"
    redirect_to movies_path
  end
  
  def edit
    @movie=Movie.find params[:id]
  end
  
  def update
    @movie=Movie.find params[:id]
    editmovie=params[:movie].permit(:title, :rating, :release_date)
    @movie.update_attributes!(editmovie)
    flash[:notice]="#{@movie.title} was successfully updated!"
    redirect_to movies_path(@movie)
  end
  
  def destroy
    @movie=Movie.find(params[:id])
    @movie.destroy
    flash[:notice]="Movie #{@movie.title} deleted !"
    redirect_to movies_path
  end
end