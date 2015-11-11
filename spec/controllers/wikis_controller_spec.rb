require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:user) { create(:user) }
  let(:my_wiki) { create(:wiki, user: user)}
  before do
    sign_in :user, user
  end

  describe "GET #index" do

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
    it "renders the index view" do
      get :index
      expect(response).to render_template :index
    end
    it "assigns [my_wiki] to @wikis" do
      get :index
      expect(assigns(:wikis)).to eq([my_wiki])
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the show template" do
      get :show, {id: my_wiki.id}
      expect(response).to render_template :show
    end
    it "assigns my_wiki to @wiki" do
      get :show, {id: my_wiki.id}
      expect(assigns(:wiki)).to eq(my_wiki)
    end
  end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit, {id: my_wiki.id}
  #     expect(response).to have_http_status(:success)
  #   end
  #   it "renders the edit view" do
  #     get :edit, {id: my_wiki.id}
  #     expect(response).to render_template :edit
  #   end
  #   it ""
  # end

  # describe "PUT #update" do
  #   it "returns http success" do
  #     put :update
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  # describe "DELETE #destroy" do
  #   it "returns http success" do
  #     delete :destroy
  #     expect(response).to have_http_status(:success)
  #   end
  # end
  #
  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
    it "renders the new view" do
      get :new
      expect(response).to render_template :new
    end
    it "instaniates @wiki" do
      get :new
      expect(assigns(:wiki)).not_to be_nil
    end
  end

  describe "POST #create" do
    it "increase the number of Wiki by 1" do
      expect{post :create, user_id: user.id, wiki: {title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph}}.to change(Wiki.count).by(1)
    end
    it "assigns the new wiki to @wiki" do
      post :create, user_id: user.id, wiki: {title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph}
      expect(assigns(:wiki)).to eq(Wiki.last)
    end
    it "redirects to the new wiki" do
      post :create,user_id: user.id, wiki: {title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph}
      expect(response).to redirect_to(Wiki.last)
    end
  end

end
