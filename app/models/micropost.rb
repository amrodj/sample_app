class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  has_many :replies, dependent: :destroy

  validates :user_id, presence: true

  default_scope order: 'microposts.created_at DESC'
end