class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.order("created_at DESC").all
    @user = User.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find_by_name_or_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
      format.js do
        unless @user.search_results.present? # @user.fetched?
          @user.fetch_qiita_data
          @user.reload
        end
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_path(@user.url_name), notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
