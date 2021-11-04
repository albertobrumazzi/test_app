class Note < ApplicationRecord
  belongs_to :user

  enum priority: [:low, :medium, :high]

  validates :title, :description, presence: true
  
  

  def priority_to_s
    I18n.t("model.note.priority_enum.#{priority.to_s}")
  end
  def self.priority_to_a
    pr={}
    Note.priorities.each do |i, j|
      pr[I18n.t("model.note.priority_enum.#{i}")]= i
    end
    pr
  end
end
