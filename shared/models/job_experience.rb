class JobExperience < ActiveRecord::Base
  self.inheritance_column = nil

  enum type: [:practice, :full_time, :part_time, :freelance, :volunteering]

  belongs_to :collaborator
  belongs_to :reference, class_name: "Person"
  belongs_to :entity
  belongs_to :position

  accepts_nested_attributes_for :entity, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :reference, reject_if: :all_blank, allow_destroy: true

  has_attached_file :certificate
  validates_attachment_file_name :certificate, :matches => [/png\Z/, /jpe?g\Z/, /pdf\Z/]

end
