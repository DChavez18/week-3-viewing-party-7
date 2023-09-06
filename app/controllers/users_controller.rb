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
      flash[:error] = "Password and Password Confirmation do not match."
      redirect_to register_path
    else
      flash[:error] = "You must fill in all fields."
      redirect_to register_path
    end
  end

  def login_form

  end

  def login
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome!"
      redirect_to user_path(user)
    else
      flash[:error] = "Sorry, your credentials are bad."
      render :login_form
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private 

  def user_params 
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end 
end 