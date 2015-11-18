module WikisHelper
  def display_wiki_content?(wiki)
    (wiki.private && (wiki.user == current_user || current_user.admin? || wiki.users.include?(current_user))) || !wiki.private
  end

  def user_authorized_for_private?(wiki)
    ((wiki.user == current_user || !wiki.user) && current_user.premium?) || current_user.admin?
  end

  def display_in_index?(wiki)
    wiki.user != current_user && display_wiki_content?(wiki)
  end

  def display_collaborators(wiki)
    users = wiki.collaborators.pluck(:user_id)
    users.map{|user| User.find(user).email}
  end

  def user_wikis(wikis)
    wikis.select {|wiki| wiki[:user_id] == current_user.id}
  end
  def collab_authorized?(wiki)
    wiki.user == current_user || current_user.admin?
  end
end
