module WikisHelper 
  def display_wiki_content?(wiki)
    (wiki.private && (wiki.user == current_user || current_user.admin?)) || !wiki.private
  end
  def user_authorized_for_private?(wiki)
    ((wiki.user == current_user || !wiki.user) && current_user.premium?) || current_user.admin?
  end
  def display_in_index?(wiki)
    wiki.user != current_user && display_wiki_content?(wiki)
  end
end
