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
      get :show, {user_id: user.id, id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the show template" do
      get :show, {user_id: user.id, id: my_wiki.id}
      expect(response).to render_template :show
    end
    it "assigns wiki to @wiki" do
      get :show, {user_id: user.id, id: my_wiki.id}
      expect(assigns(:wiki)).to eq(my_wiki)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, {user_id: user.id, id: my_wiki.id}
      expect(response).to have_http_status(:success)
    end
    it "renders the edit view" do
      get :edit, {user_id: user.id, id: my_wiki.id}
      expect(response).to render_template :edit
    end

    it "assigns wiki to be updated to @wiki" do
      get :edit, {user_id: user.id, id: my_wiki.id}
      wiki_instance = assigns(:wiki)
      expect(wiki_instance.id).to eq(my_wiki.id)
      expect(wiki_instance.title).to eq(my_wiki.title)
      expect(wiki_instance.body).to eq(my_wiki.body)
    end
  end

  describe "PUT #update" do
    new_title = Faker::Lorem.sentence
    new_body = Faker::Lorem.paragraph
    before do
      put :update, user_id: user.id, id: my_wiki.id, wiki: {title: new_title, body: new_body}
    end
    it "updates wiki with expected attributes" do
      updated_wiki = assigns(:wiki)
      expect(updated_wiki.id).to eq(my_wiki.id)
      expect(updated_wiki.title).to eq(new_title)
      expect(updated_wiki.body).to eq(new_body)
    end
    it "redirects to the updated wiki" do
      expect(response).to redirect_to([user, my_wiki])
    end
  end

  describe "DELETE #destroy" do
    it "deletes the wiki" do
      delete :destroy, {user_id: user.id, id: my_wiki.id}
      count = Wiki.where(id: my_wiki.id).size
      expect(count).to eq(0)
    end
    it "redirects to index" do
      delete :destroy, {user_id: user.id, id: my_wiki.id}
      expect(response).to redirect_to user_wikis_path
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, user_id: user.id
      expect(response).to have_http_status(:success)
    end
    it "renders the new view" do
      get :new, user_id: user.id
      expect(response).to render_template :new
    end
    it "instaniates @wiki" do
      get :new, user_id: user.id
      expect(assigns(:wiki)).not_to be_nil
    end
  end

  describe "POST #create" do
    it "increase the number of Wiki by 1" do
      expect{post :create, user_id: user.id, wiki: {title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph}}.to change(Wiki, :count).by(1)
    end
    it "assigns the new wiki to @wiki" do
      post :create, user_id: user.id, wiki: {title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph}
      expect(assigns(:wiki)).to eq(Wiki.last)
    end
    it "redirects to the new wiki" do
      post :create,user_id: user.id, wiki:{title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph}
      expect(response).to redirect_to([user, Wiki.last])
    end
  end

end
