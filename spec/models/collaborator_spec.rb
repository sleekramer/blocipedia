require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  let(:user) {create(:user)}
  let(:wiki) {create(:wiki, user: user)}
  it {should belong_to(:user)}
  it {should belong_to(:wiki)}

end
