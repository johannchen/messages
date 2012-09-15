versesServices = angular.module 'versesApp.services', []
versesServices.value 'version', '0.1'
versesServices.factory 'idb', () ->
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
