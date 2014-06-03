class UsersController < ApplicationController

  before_action :set_user, only: [:show, :edit, :update, :destroy]


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end


  def user_list
    users_array = User.get_user_list
    render :json => {data: users_array}
  end


  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    #100.times do |i|
    #  user_params = {user_name:"user_" + i.to_s,
    #                 user_email:"user_" + i.to_s + "@qq.com",
    #                 password:"user_" + i.to_s,
    #                 password_confirmation:"user_" + i.to_s,
    #
    #  }
    #  user = User.new(user_params)
    #  user.save
    #end

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy_users
    status, message = User.destroy_user_by_ids(params[:user_ids])
    render :json => {status: status, message: message}
  end


  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to life_posts_url }
      format.json { head :no_content }
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:user_name, :password, :user_email, :password_confirmation)
  end
end