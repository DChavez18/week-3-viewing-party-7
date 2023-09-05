class UsersController <ApplicationController 
  def new 
    @user = User.new()
  end 

  def show 
    @user = User.find(params[:id])
  end 

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    elsif User.exists?(email: params[:user][:email])
      flash[:error] = "Email has already been taken"
      redirect_to register_path
    elsif params[:user][:password] != params[:user][:password_confirmation]
      flash[:error] = "Password and Password Confirmation does not match."
      redirect_to register_path
    else
      flash[:error] = "You must fill in all fields."
      redirect_to register_path
    end
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 