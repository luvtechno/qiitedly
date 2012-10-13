class TagsController < ApplicationController
  def index
    @user = User.find_by_name_or_id(params[:user_id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end
end
