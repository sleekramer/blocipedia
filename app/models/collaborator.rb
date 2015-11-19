class Collaborator < ActiveRecord::Base
  belongs_to :user
  belongs_to :wiki

  delegate :email, to: :user, prefix: true

  def self.update_collaborators(wiki, collaborators_string)
    return [] if collaborators_string.blank?
    new_collabos = collaborators_string.split(",").map(&:strip)
    wiki.collaborators.each {|c| c.destroy unless new_collabos.include?(c.user_email)}
    user_ids = User.where(email: new_collabos).pluck(:id)
    user_ids.map do |user_id|

      Collaborator.create(wiki_id: wiki.id, user_id: user_id)
    end
  end
end
