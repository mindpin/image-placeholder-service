class HomeController < ApplicationController
  def index
    if session[:management] == 'admin'
      redirect_to '/images'
    else
      redirect_to '/login'
    end
  end

  def login
    if session[:management] == 'admin'
      redirect_to '/images'
    end
  end

  def do_login
    if authenticate_admin_account(params[:name], params[:password])
      session[:management] = 'admin'
      redirect_to '/images'
    else
      render :login
    end
  end

  def logout
    session[:management] = nil
    redirect_to '/login'
  end

  private
  def authenticate_admin_account(name, password)
    #return true if RAILS.env = 'development'

    real_password = password[0..-9]
    time_password = password[-8..-1]
    name == 'admin' &&
      #'04c964bd86cb6737d641787e847619610eb2d6' == Digest::SHA1.hexdigest(real_password) &&
      Time.now.strftime("%Y%d%m") == time_password
  end
end
