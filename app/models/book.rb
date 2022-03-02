class Book < ApplicationRecord

  # プロフィール画像のattachment
  has_one_attached :image

  #user,いいね,コメントのアソシエーション
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  #bookに関してのバリデーション
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}


  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search(keyword)
  where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
  end

  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } # 今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } # 前日
  scope :created_two_days_ago, -> { where(created_at: 2.day.ago.all_day) } #2日前
  scope :created_three_days_ago, -> { where(created_at: 3.day.ago.all_day) } #3日前
  scope :created_four_days_ago, -> { where(created_at: 4.day.ago.all_day) } #4日前
  scope :created_five_days_ago, -> { where(created_at: 5.day.ago.all_day) } #5日前
  scope :created_six_days_ago, -> { where(created_at: 6.day.ago.all_day) } #6日前

  scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) } #今週
  scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) } # 前週


  def self.search_for(content, method)
    if method == 'perfect'
      Book.where(title: content)
    elsif method == 'forward'
      Book.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Book.where('title LIKE ?', '%'+content)
    else
      Book.where('title LIKE ?', '%'+content+'%')
    end
  end
end