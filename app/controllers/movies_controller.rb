class MoviesController < ApplicationController
  def index
    @sort=params[:title] || session[:sort]
    @all_ratings=['G', 'P', 'PG-13','R', 'NC-17']
    
    if params[:commit]
      
      if params[:ratings]
        @selection=params[:ratings].keys
        session[:filter]=params[:ratings]
       
      else
        @selection=@all_ratings
        session.delete(:filter)
        session[:filter]=Hash.new
        @all_ratings.each do |x|
          session[:filter][x]=1
          
        end
        
        
      end
      
      
    else
      if session[:filter]
        @selection=session[:filter].keys
      else
        @selection=@all_ratings
        session.delete(:filter)
        session[:filter]=Hash.new
        @all_ratings.each do |x|
          session[:filter][x]=1
          
        end
      end
    end
    
    
    
    
    
    
    
    
    case @sort
    when 'title_header'
      @ordering=:title
      @hilite_title='hilite'
      session[:sort]=@sort
    when  'release_date_header'
      @ordering=:release_date
      @hilite_release_date='hilite'
      session[:sort]=@sort
    end
    
    
    
    @movies=Movie.where({rating:@selection}).order(@ordering)
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