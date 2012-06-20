class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  has_many :replies, dependent: :destroy

  validates :user_id, presence: true

  default_scope order: 'microposts.reply_cnt DESC'

  def self.search(search)
    if search
      find(:all, :conditions => ['content LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

end