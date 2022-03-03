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
