json.array!(@messages) do |json, message|
  json.id message.id
  json.title message.title
  json.speaker_name message.speaker_name
  json.category_names message.category_names
  json.listened_on message.listened_on
  json.url message.url
  json.summary message.summary
end
