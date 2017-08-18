json.data do
  json.projects do
    json.array!(@projects) do |project|
      json.call(project, :id, :name)
    end
  end
end