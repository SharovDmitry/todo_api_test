json.data do
  json.comment do
    json.call(@comment, :id, :content)
    json.file_url @comment.image.url
  end
end