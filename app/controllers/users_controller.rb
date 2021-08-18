class UsersController < ApplicationController

  def new
  end

  def create
    if params[:password] == params[:password_confirmation]
      @user = User.new(
        name: params[:name],
        email: params[:email],
        password: params[:password]
      )
      @user.save
      redirect_to('/users/new')
    else
      render('/users/new')
    end
  end

  def login_form
  end

  def login
    if @user = User.find_by(email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect_to('/todoes/new')
    else
      redirect_to('/login')
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to('/login')
  end
end
