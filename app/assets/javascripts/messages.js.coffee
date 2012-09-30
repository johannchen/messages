messagesApp = angular.module 'messagesApp', ['filters', 'services']
# allow CSRF
messagesApp.config [ "$httpProvider", (provider) ->
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]

messagesApp.config ($routeProvider) ->
  $routeProvider.when('/',
    controller: 'MessageListCtrl'
    templateUrl: '/messages/list.html'
  ).when('/new',
    controller: 'MessageCreateCtrl'
    templateUrl: '/messages/new.html'
  ).otherwise redirectTo: '/'

jQuery ->
  $("#calendar").fullCalendar
    header:
      left: 'prev,next today'
      center: 'title'
      right: 'month,basicWeek'
    defaultView: 'month'
    editable: false
    height: 500
    loading: (bool) -> 
      if bool then $("#loading").show() else $("#loading").hide()
    events: "/messages/calendar"
    eventClick: (event) ->
      window.location = '/messages/' + event.id
      false

  $("#message_mdate").datepicker dateFormat: 'yy-mm-dd'
  $("#message_listened_on").datepicker dateFormat: 'yy-mm-dd'
  $("#message_speaker_name").autocomplete source: "/speakers"
  $("#message_note").cleditor()

  books = [
    "Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy"
    "Joshua", "Judges", "Ruth", "1 Samuel", "2 Samuel"
    "1 Kings", "2 Kings", "1 Chronicles", "2 Chronicles"
    "Ezra", "Nehemiah", "Esther"
    "Job", "Psalms", "Proverbs", "Ecclesiastes", "Song of Songs"
    "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel"
    "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah"
    "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi"
    "Matthew", "Mark", "Luke", "John", "Acts"
    "Romans", "1 Corinthians", "2 Corinthians", "Galatians", "Ephesians"
    "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians"
    "1 Timothy", "2 Timothy", "Titus", "Philemon"
    "Hebrews", "James", "1 Peter", "2 Peter"
    "1 John", "2 John", "3 John", "Jude", "Revelation"
  ]
  
  $("#verse_ref").autocomplete source: books

