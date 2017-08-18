json.data do
  json.tasks do
    json.array!(@tasks) do |task|
      json.call(task, :id, :name, :completed, :deadline, :position)
    end
  end
end