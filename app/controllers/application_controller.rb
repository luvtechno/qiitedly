# coding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :meta_data

  private
  def meta_data
    @meta_description = '毎日楽しくプログラミングをしよう！ あなたのQiitaデータから会社をオススメします'
  end
end
