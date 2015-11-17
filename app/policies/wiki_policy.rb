class WikiPolicy < ApplicationPolicy
  attr_reader  :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def update?
    if wiki.private == true
      user.premium? || user.admin?
    else
      user.present?
    end
  end

  def create?
    user.premium? || user.admin?
  end

  def destroy?
    user == wiki.user || user.admin?
  end
end
