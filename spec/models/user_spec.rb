require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user)}
  it { should have_many(:wikis)}
  it { should have_many(:collaborators) }
  describe "attributes" do
    it "responds to role" do
      expect(user).to respond_to(:role)
    end
    it "responds to #standard?" do
      expect(user).to respond_to(:standard?)
    end
    it "responds to #premium?" do
      expect(user).to respond_to(:premium?)
    end
    it "responds to #admin?" do
      expect(user).to respond_to(:admin?)
    end
  end
  describe "roles" do
    it "is standard by default" do
      expect(user.role).to eql("standard")
    end
    context "standard user" do
      it "returns true for #standard?" do
        expect(user.standard?).to be_truthy
      end
      it "returns false for #premium? and #admin?" do
        expect(user.premium?).to be_falsey
        expect(user.admin?).to be_falsey
      end
    end
    context "premium user" do
      before do
        user.premium!
      end
      it "returns true for #premium?" do
        expect(user.premium?).to be_truthy
      end
      it "returns false for #standard? and #admin?" do
        expect(user.standard?).to be_falsey
        expect(user.admin?).to be_falsey
      end
    end
    context "admin user" do
      before do
        user.admin!
      end
      it "returns true for #admin?" do
        expect(user.admin?).to be_truthy
      end
      it "returns false for #standard? and #premium?" do
        expect(user.standard?).to be_falsey
        expect(user.premium?).to be_falsey
      end
    end
  end
end
