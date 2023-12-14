class Task < ApplicationRecord
  belongs_to :user, dependent: :destroy, optional: true
  belongs_to :status, dependent: :destroy, optional: true
end
