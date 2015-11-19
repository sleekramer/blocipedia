class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki

  def self.update_collaborators(wiki, collaborators_string)
    return [] if collaborators_string.blank?

    collaborators_string.split(",").map do |collaborator|
      Collaborator.find_or_create_by(wiki_id: wiki.id, user_id: collaborator)
    end
  end
end
