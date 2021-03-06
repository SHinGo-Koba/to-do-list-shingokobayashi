class UsersController < ApplicationController
  before_action :correct_user, only: [:show, :edit, :update, :destroy]

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @post = Post.new
    @posts = Post.where(user_id: current_user.id).order(due: :asc)
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        log_in @user
        format.html { redirect_to @user }
        format.json { render :show, status: :created, location: @user }
        flash[:success] = "User was successfully created"
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        @user.errors.full_messages.each { |m| puts m }
        flash.now[:danger] = "Sign up failed"
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
    
    def correct_user
      @user = User.find_by(id: params[:id])
      if !correct_user? @user
        flash[:danger] = "Invalid access"
        redirect_to login_path
      end
    end
end
