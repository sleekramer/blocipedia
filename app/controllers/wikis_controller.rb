class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def new
    @wiki = Wiki.new

  end

  def create
    @user = User.find(params[:user_id])
    @wiki = @user.wikis.build(wiki_params)

    if @wiki.save
      redirect_to @wiki, flash[:notice] = "Wiki created"
    else
      flash[:error] = "There was a problem creating the wiki. Please try again."
      render :new
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end
end
