class User::UsersController < ApplicationController

  def mypage
    @user = current_user
  end

  def edit
    @user = current_user
    set_edit_option
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:mypage_edit] = "プロフィールが更新されました。"
      redirect_to my_page_path(@user)
    else
      # @user.errors.full_messages
      set_edit_option
      render 'edit'
    end
  end


  private
  
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
