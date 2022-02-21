class Book < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.search(keyword)
  where(["title like? OR body like?", "%#{keyword}%", "%#{keyword}%"])
  end
  
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("body LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("body LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("body LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("body LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

end
