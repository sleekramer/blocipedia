class WikisController < ApplicationController
  def index
    @wikis = Wiki.all
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])


    if @wiki.update_attributes(wiki_params)
      redirect_to [@wiki.user, @wiki], notice: "Wiki updated"
    else
      flash[:error] = "Unable to update wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])

    if @wiki.destroy
      redirect_to user_wikis_path, notice: "Wiki deleted"
    else
      flash[:error] = "Unable to delete wiki. Try again."
      render :show
    end
  end

  def new
    @user = User.find(params[:user_id])
    @wiki = Wiki.new
  end

  def create
    @user = User.find(params[:user_id])
    @wiki = @user.wikis.build(wiki_params)

    if @wiki.save
      redirect_to [@user,@wiki] , notice: "Wiki created"
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
