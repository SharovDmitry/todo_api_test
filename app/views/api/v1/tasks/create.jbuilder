json.data do
  json.task do
    json.call(@task, :id, :name, :completed, :deadline, :position)
  end
end