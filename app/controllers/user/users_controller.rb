class User::UsersController < ApplicationController
  before_action :set_user, only: [:show]
  before_action :authenticate_user!, except: [:show]

  def mypage
    @user = current_user
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(5)
  end

  def edit
    @user = current_user
    set_edit_option
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:mypage_edit_success] = "プロフィールが更新されました"
      redirect_to my_page_path(@user)
    else
      # @user.errors.full_messages
      set_edit_option
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    if current_user && @user == current_user
       redirect_to my_page_path
    end
    @posts = @user.posts.order(created_at: :desc).page(params[:page]).per(3)
  end

  def destroy
    @user = current_user
    @user.destroy
    flash[:withdraw_success] = "退会処理が正常に行われました"
    redirect_to root_path
  end

  def followings
    set_user
    @users = @user.followings
  end

  def followers
    set_user
    @users = @user.followers
  end


  private

  def set_user
    @user = User.find(params[:id])
  end

  def set_edit_option
    @gender_options = User.genders_i18n.invert.map{|key,value|[key,value]}
    @age_options = User.ages_i18n.invert.map{|key,value|[key,value]}
    @smoking_options = User.smokings_i18n.invert.map{|key,value|[key,value]}
    @drinking_options = User.drinkings_i18n.invert.map{|key,value|[key,value]}
    @favorite_area_options = User.favorite_areas_i18n.invert.map{|key,value|[key,value]}
    @budget_options = User.budgets_i18n.invert.map{|key,value|[key,value]}
  end

  def user_params
    params.require(:user).permit(:name, :bio, :gender, :age,
    :smoking, :drinking, :country_count, :favorite_area,
    :budget, :is_active, :profile_image)
  end


end
