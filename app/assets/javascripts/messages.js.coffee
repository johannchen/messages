messagesApp = angular.module 'messagesApp', ['ui', 'directives', 'filters', 'services']
# allow CSRF
messagesApp.config [ "$httpProvider", (provider) ->
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]

messagesApp.config ($routeProvider) ->
  $routeProvider.when('/',
    controller: 'MessageListCtrl'
    templateUrl: '/messages/list.html'
  ).when('/:messageId',
    controller: 'MessageShowCtrl'
    templateUrl: '/messages/show.html'
  ).when('/new',
    controller: 'MessageCreateCtrl'
    templateUrl: '/messages/form.html'
  ).when('/edit/:messageId',
    controller: 'MessageEditCtrl'
    templateUrl: '/messages/form.html'
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

  $("#message_note").cleditor()

