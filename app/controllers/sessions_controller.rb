class SessionsController < ApplicationController
  include SessionsHelper

  def create #post
    user = User.find_by(email: login_params[:email].downcase)
    if user && user.authenticate(login_params[:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember_user(user) : forget_user(user)
      flash= {:info => "欢迎回来: #{user.name} :)"}
    else
      flash= {:danger => '账号或密码错误'}
    end
      redirect_to courses_url, :flash => flash  #老师和学生
      # redirect_to root_url, :flash => flash
  end
  
  def new #get

  end
  
  def admincreate #post
    user = User.find_by(email: login_params[:email].downcase)
    if user && user.authenticate(login_params[:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember_user(user) : forget_user(user)
      flash= {:info => "欢迎回来: #{user.name} :)"}
    else
      flash= {:danger => '账号或密码错误'}
    end
      redirect_to rails_admin_url, :flash => flash  #管理员
      # redirect_to root_url, :flash => flash
  end
  
  def admin #get
    
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
  def login_params
    params.require(:session).permit(:email, :password)
  end
end
