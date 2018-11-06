class UsersController < ApplicationController
  def index
  	# @users = User.all
    if current_user
      @users = User.all
    else 
      flash[:warning] = "Inscris-toi"
      redirect_to login_path
    end 
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	
    if @user.save
      log_in @user
      flash[:success] = "Bienvenu au club"
      redirect_to @user
    else
      render 'new'
    end

  end 

  def show
  	# @user = User.find(params[:id])
    if current_user == User.find(params[:id])
      @user = current_user
    else 
      flash[:warning] = "Erreur"
      redirect_to root_path
    end 
  end

  def edit
  	# @user = User.find(params[:id])
    if current_user == User.find(params[:id])
      @user = current_user
    else 
      flash[:warning] = "Erreur"
      redirect_to root_path
    end 
  end

  def update
  	@user = User.find(params[:id])
  	@user = User.update(user_params)
  	redirect_to users_path
  end 

  def destroy
  	@user = User.find(params[:id])
  	@user.destroy
  	redirect_to users_path
  end 


  private

  def user_params
  	params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end 
end
