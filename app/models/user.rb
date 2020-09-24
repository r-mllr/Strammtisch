class User < ApplicationRecord
  has_and_belongs_to_many :events

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable

  validates :name, presence: true

end
