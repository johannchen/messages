json.(@message, :id, :title, :summary, :listened_on, :speaker_name, :category_names, :verse_refs)

json.verses @message.verses, :id, :ref, :content
