versesApp = angular.module 'versesApp', ['ui', 'versesApp.filters', 'versesApp.services', 'versesApp.directives']
# allow CSRF
versesApp.config [ "$httpProvider", (provider) ->
  provider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')
]
