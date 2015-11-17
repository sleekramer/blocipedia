class WikiPolicy < ApplicationPolicy
  attr_reader  :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def update?
    user.present?
  end
  def destroy?
    user == wiki.user || user.admin?
  end
end
