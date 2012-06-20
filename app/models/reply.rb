class Reply < ActiveRecord::Base
  attr_accessible :content
  belongs_to :micropost
end
