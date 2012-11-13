json.array!(@verses) do |json, verse|
  json.id verse.id
  json.ref verse.ref
  if verse.content.nil?
    json.content verse.esv_passage
  else
    json.content verse.content
  end
  json.favorite verse.favorite
  json.memorized verse.memorized
  json.last_memorized_at verse.last_memorized_at
  json.created_at verse.created_at
  json.category_names verse.category_names
end
