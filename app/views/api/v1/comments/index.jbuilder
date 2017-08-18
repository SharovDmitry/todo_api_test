json.data do
  json.comments do
    json.array!(@comments) do |comment|
      json.call(comment, :id, :content)
      json.file_url comment.image.url
    end
  end
end