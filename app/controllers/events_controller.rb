class EventsController < ApplicationController
  before_action :set_current_info

  # 动态首页
  def index
    puts '-' * 20
    ap @current_team
    ap @current_user
    puts '-' * 20
  end

  private

  def set_current_info
    @current_team = current_team
    @current_user = current_user
  end

end
