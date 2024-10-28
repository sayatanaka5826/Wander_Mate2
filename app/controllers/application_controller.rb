class ApplicationController < ActionController::Base
  before_action :check_admin_session

  private

  def check_admin_session
    if admin_signed_in? && user_signed_in?
      reset_session
    end
  end

end
