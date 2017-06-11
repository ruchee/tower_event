class EventsController < ApplicationController
  before_action :set_current_info

  # 动态首页
  def index
    @data = common(1)
  end

  # 加载更多
  def more
    @data = common(params[:page])
    render layout: false
  end

  private

  def set_current_info
    @current_team = current_team
    @current_user = current_user
  end

  def action_list
    {
      create: '创建',
      destroy: '删除',
      complete: '完成',
      comment: '回复'
    }
  end

  def model_list
    {
      Team: '团队',
      Project: '项目',
      Todo: '任务'
    }
  end

  def calc_action_text(event)
    action = event.action
    return event.content if action.in? %w[ assign update_assignee update_due_date ]
    text = "#{action_list[action.to_sym]}了#{model_list[event.action_model.to_sym]}"
    text << '任务' if event.action_model == 'Comment'
    text
  end

  def calc_body(event)
    bname = event.action_name
    if event.action_model == 'Comment'
      comment = Comment.find(event.action_id)
      parent_item = comment.subject_model.constantize.find(comment.subject_id)
      burl = "/#{comment.subject_model.downcase}s/#{parent_item.id}"
      bcontent = comment.content
    else
      burl = "/#{event.action_model.downcase}s/#{event.action_id}"
      bcontent = nil
    end
    { bname: bname, burl: burl, bcontent: bcontent }
  end

  def calc_show_date(time)
    return '今' if time.today?
    <<-HEREDOC
    <span class="date">#{time.month}/#{time.day}</span><span class="day">周#{time.wday}</span>
    HEREDOC
  end

  def common(page = 1)
    data = []

    events = Event.includes(:user).order(created_at: :desc).page(page).per(50)
    events.each do |event|
      project = event.project_id ? Project.find(event.project_id) : nil
      user = event.user
      time = event.created_at

      item = {
        uid: user.id,
        uname: user.nickname,
        avatar: user.avatar,
        action: calc_action_text(event),
        pid: project&.id,
        pname: project&.name,
        date: "#{time.year}#{time.month}#{time.day}",
        time: "#{time.hour}:#{time.min}",
        show_date: calc_show_date(time)
      }
      item.merge!(calc_body(event))

      data << item
    end

    data
  end

end
