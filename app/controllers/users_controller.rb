class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update]

  def show
    @user = User.find(params[:id])
    @users = @user.books
    @books = @user.books
    @book = Book.new

    #フォローに関して
    @following_users = @user.following_user #@userがフォローしている人達
    @follower_users = @user.follower_user #@userをフォローしている人達

    #過去７日分
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @two_days_ago_book = @books.created_two_days_ago
    @three_days_ago_book = @books.created_three_days_ago
    @four_days_ago_book = @books.created_four_days_ago
    @five_days_ago_book = @books.created_five_days_ago
    @six_days_ago_book = @books.created_six_days_ago

    #過去１週間分
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
  end

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
    @following_users = @user.following_user #@userがフォローしている人達
    @follower_users = @user.follower_user #@userをフォローしている人達
  end


  def edit
    @user = User.find(params[:id])
    if @user != current_user
    redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end

  def follows
    @user = User.find(params[:id])
    @users = @user.following_user.all
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.follower_user.all
  end
  
  #非同期での検索
  def search
  @user = User.find(params[:user_id])
  @books = @user.books 
  @book = Book.new
  if params[:created_at] == ""
    @search_book = "日付を選択してください"
  else
    create_at = params[:created_at]
    @search_book = @books.where(['created_at LIKE ? ', "#{create_at}%"]).count
  end
 
  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
  end
end
