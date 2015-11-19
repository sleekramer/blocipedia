class WikiPolicy < ApplicationPolicy
  attr_reader  :user, :wiki

  def initialize(user, wiki)
    @user = user
    @wiki = wiki
  end

  def update?
    if wiki.private == true
      user.admin? || wiki.user == user || wiki.users.include?(user)
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

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.admin?
        wikis = scope.all
      else
        all_wikis = scope.all
        all_wikis.each do |wiki|
          if !wiki.private || wiki.user == user || wiki.users.include?(user)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end
end
