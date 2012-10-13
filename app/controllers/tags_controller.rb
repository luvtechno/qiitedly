class TagsController < ApplicationController
  def show
    @tag = Tag.find_by_name_or_id(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
end
