angular.module('versesApp', ['ui', 'filters', 'services', 'directives']
).config ['$httpProvider', ($httpProvider) ->
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]
