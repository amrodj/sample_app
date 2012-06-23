class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user
  has_many :replies, dependent: :destroy

  validates :user_id, presence: true

  default_scope order: 'microposts.reply_cnt DESC'

  def self.search(search)
    if search
      begin
        #Lookup on posts and comments, could have also used reg expressions in a loop
        @userid = User.connection.execute("select u.id from users u where u.name like '%"+search+"%'")
        @searchid = []
        @userid.each do |j|
          @searchid[0] = j["id"]
        end
        if @searchid[0]
          begin
            @results = Micropost.connection.execute("select m.id from microposts m where m.user_id = #{@searchid[0]}")
          end
        else
          @results = Micropost.connection.execute("select m.id from microposts m where m.content like '%"+search+"%'")
        end
      @postid = []
      @results.each do |i|
        @postid << i["id"]
      end
      find(:all, :conditions => ['id in (?)', @postid])
    end
    else
      find(:all)
    end
  end
end




  #def self.search(search)
   # if search
    #  find(:all, :conditions => ['content LIKE ?', "%#{search}%"])
    #else
     # find(:all)
    #end
  #end
  #end