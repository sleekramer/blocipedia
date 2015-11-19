class WikisController < ApplicationController
  include WikisHelper
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @wikis = policy_scope(Wiki.all)
  end

  def show
    @wiki = Wiki.find(params[:id])
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update_attributes(wiki_params)
      @wiki.collaborators = Collaborator.update_collaborators(@wiki, params[:wiki][:collaborators]) if collab_authorized?(@wiki)
      redirect_to [@wiki.user, @wiki], notice: "Wiki updated"
    else
      flash[:alert] = "Unable to update wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.destroy
      redirect_to user_wikis_path, notice: "Wiki deleted"
    else
      flash[:alert] = "Unable to delete wiki. Try again."
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
    authorize @wiki if @wiki.private == true
    if @wiki.save
      redirect_to [@user,@wiki] , notice: "Wiki created"
    else
      flash[:alert] = "There was a problem creating the wiki. Please try again."
      render :new
    end
  end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action"
    redirect_to(request.referer || root_path)
  end

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

end
