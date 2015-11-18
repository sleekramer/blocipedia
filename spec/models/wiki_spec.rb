require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:user) { create(:user)}
  let(:wiki) { create(:wiki, user: user)}

  it {should belong_to(:user) }
  it {should have_many(:collaborators) }
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
