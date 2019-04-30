class Note < ApplicationRecord
  validates :content, :created_by, presence: true
end
