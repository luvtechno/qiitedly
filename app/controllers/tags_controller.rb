# coding: utf-8

class TagsController < ApplicationController
  before_filter :find_tag, only: [:show]
  before_filter :meta_data, only: [:show]

  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  private
  def find_tag
    @tag = Tag.find_by_name_or_id(params[:id])
  end

  def meta_data
    @meta_description = "#{@tag.name}好きプログラマにオススメのウォンテッド求人・会社"
  end
end
