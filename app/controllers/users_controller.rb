class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def index
    @users = User.order("created_at DESC").all
    @user = User.new

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find_by_name_or_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
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
    @user = User.where(url_name: params[:user][:url_name]).first_or_initialize

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_path(@user.url_name), notice: 'User was successfully created.' }
      else
        format.html { redirect_to root_path }
      end
    end
  end
end
