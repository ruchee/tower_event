# 首个用户
u1 = User.create(email: 'zhangsan@example.com', nickname: '张三', avatar: 'https://avatar.tower.im/dbc50dc94a73422cab94729d4fd9f8aa')

# 创建团队
t1 = Team.create(user_id: u1.id, name: '临时团队')

# 团队加人
u2 = User.create(email: 'lisi@example.com', nickname: '李四', avatar: 'https://avatar.tower.im/cd86329a6637421dbefa4ef0f7117bee')
u3 = User.create(email: 'wangwu@example.com', nickname: '王五', avatar: 'https://avatar.tower.im/cd86329a6637421dbefa4ef0f7117bee')
t1.add_member(u2.id)
t1.add_member(u3.id)

# 创建项目
p1 = t1.projects.create(user_id: u1.id, name: '第一个项目')
p2 = t1.projects.create(user_id: u2.id, name: '第二个项目')
p3 = t1.projects.create(user_id: u3.id, name: '第三个项目')

# 创建任务
3.times do |n|
  num = n + 1
  p1.todos.create(user_id: u1.id, name: "第一个项目下的第#{num}个任务")
  p2.todos.create(user_id: u2.id, name: "第二个项目下的第#{num}个任务")
  p3.todos.create(user_id: u1.id, name: "第三个项目下的第#{num}个任务")
end

#----------------------------------------------------------------------

# 任务相关处理公用方法
def todo_common(user, todo, action, update_info)
  Todo.transaction do
    todo.update(update_info)
    Event.create_new(uid: user.id, a: action, amodel: 'Todo', aid: todo.id, pid: todo.project_id,
                     tid: Project.find(todo.project_id)&.team_id)
  end
end

#----------------------------------------------------------------------

# 王五删除任务
todo_common(u3, Todo.last, 'destroy', status: Todo.statuses['deleted'])

# 李四完成任务
todo_common(u2, Todo.last, 'complete', status: Todo.statuses['done'])

# 张三把任务指派给王五
todo_common(u1, Todo.last, 'assign', assignee: u3.id)

# 张三修改任务完成者为李四
todo_common(u1, Todo.last, 'update_assignee', assignee: u2.id)

# 张三修改任务完成时间为七天后
todo_common(u1, Todo.last, 'update_due_date', due_date: Time.now + 7.days)

#----------------------------------------------------------------------

# 生成对任务的评论
todo_ids = Todo.ids
user_ids = User.ids

3.times do |n|
  num = n + 1
  parent_comment = Comment.create(subject_model: 'Todo', subject_id: todo_ids.sample, user_id: user_ids.sample, content: "第#{num}条评论")
  Comment.create(
    parent_id: parent_comment.id,
    subject_model: 'Todo',
    subject_id: parent_comment.subject_id,
    user_id: user_ids.sample,
    content: "第#{num}条评论的回复"
  )
end
