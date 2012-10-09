angular.module('messagesApp', ['ui', 'directives', 'filters', 'services']
).config(['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]).config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when('/',
    controller: 'MessageListCtrl'
    templateUrl: '/messages/list.html'
  ).when('/show/:messageId',
    controller: 'MessageShowCtrl'
    templateUrl: '/messages/show.html'
  ).when('/new',
    controller: 'MessageCreateCtrl'
    templateUrl: '/messages/form.html'
  ).when('/edit/:messageId',
    controller: 'MessageEditCtrl'
    templateUrl: '/messages/form.html'
  ).otherwise redirectTo: '/'
])
