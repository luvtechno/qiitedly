# coding: utf-8

class UsersController < ApplicationController
  before_filter :find_user, only: [:show]
  before_filter :meta_data

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

  private
  def find_user
    @user = User.find_by_name_or_id(params[:id])
  end

  def meta_data
    if @user
      @meta_description = "#{@user.name_displayed}さんにおすすめのウォンテッド求人・会社"
    else
      @meta_description = '毎日楽しくプログラミングをしよう！ あなたのQiitaデータから会社をオススメします'
    end
  end
end
