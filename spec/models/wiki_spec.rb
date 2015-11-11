require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) { User.create!(email:'blocipedia@bloc.com',password:'blocipedia')}
  let(:wiki) { user.wikis.create!(title:'Test wiki',body:'This will be the test body')}
  sign_in(user.email, user.password)
  it {should belong_to(:user) }

  describe "attributes" do
    it "responds to title" do
      expect(wiki).to respond_to :title
    end
    it "responds to body" do
      expect(wiki).to respond_to :body
    end
    it "responds to private" do
      expect(wiki).to respond_to :private
    end
    it "responds to user" do
      expect(wiki).to respond_to :user
    end
  end
end
