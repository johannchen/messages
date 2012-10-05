serviceModule = angular.module 'services', ['ngResource']
serviceModule.value 'version', '0.1'

serviceModule.factory 'Calendar', ($resource) ->
  $resource '/messages/calendar.json'

serviceModule.factory 'Messages', ($resource) ->
  $resource 'messages.json'

serviceModule.factory 'Message', ($resource) ->
  $resource '/messages/:message_id.json', {message_id:'@id'},
    update: { method: 'PUT' }

serviceModule.factory 'Speakers', ($resource) ->
  $resource 'speakers.json'

serviceModule.factory 'Speaker', ($resource) ->
  $resource '/speakers/:speaker_id.json', {speaker_id:'@id'},
    update: { method: 'PUT' }

serviceModule.factory 'Verses', ($resource) ->
  $resource 'verses.json'

serviceModule.factory 'Verse', ($resource) ->
  $resource '/verses/:verse_id.json', {verse_id:'@id'},
    update: { method: 'PUT' }

serviceModule.factory 'ESV', ($resource) ->
  $resource '/verses/api/:ref.json', {ref:'@ref'}


serviceModule.factory 'Categories', ($resource) ->
  $resource 'categories.json'

serviceModule.factory 'Category', ($resource) ->
  $resource '/categories/:category_id.json', {category_id:'@id'},
    update: { method: 'PUT' }

serviceModule.factory 'idb', () ->
  dbName = "Messages"
  $.indexedDB(dbName,
    schema:
      1: (transaction) ->
        store = transaction.createObjectStore("tags",
          keyPath: "id"
          autoIncrement: true
        )
        store.createIndex "name"
  ).done(->
      console.log "store setup"
  ).fail ->
      console.log "cannot setup store"
  
  return {
    add: (table, value) ->
      $.indexedDB(dbName).objectStore(table).add(value)
    delete: (table, key) ->
      $.indexedDB(dbName).objectStore(table).delete(key)
    put: (table, value, key) ->
      $.indexedDB(dbName).objectStore(table).put(value, key)
    count: (table) ->
      $.indexedDB(dbName).objectStore(table).count()
    clear: (table) ->
      $.indexedDB(dbName).objectStore(table).clear()
    all: (table) ->
      data = []
      promise = $.indexedDB(dbName).objectStore(table).each (elem) ->
        # time race, array push is slower than iteration
        data.push(elem.value)
        console.log(elem.value)
      data
  }
