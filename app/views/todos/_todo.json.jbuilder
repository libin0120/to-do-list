json.extract! todo, :id, :task, :deadline, :completed, :details, :created_at, :updated_at
json.url todo_url(todo, format: :json)
