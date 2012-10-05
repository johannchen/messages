directiveModule = angular.module('directives', [])
directiveModule.directive 'appVersion', ['version', (version) ->
    (scope, element, attrs) ->
      element.text(version)
  ]

directiveModule.directive 'jcEnter', ->
  (scope, elm, attrs) ->
    elm.bind 'keypress', (e) ->
      scope.$apply(attrs.jcEnter) if e.charCode == 13

directiveModule.directive 'bibleAutocomplete', ->
  bible = ["Genesis", "Exodus", "Leviticus", "Numbers", "Deuteronomy", "Joshua", "Judges", "Ruth", "1 Samuel", "2 Samuel", "1 Kings", "2 Kings", "1 Chronicles", "2 Chronicles", "Ezra", "Nehemiah", "Esther", "Job", "Psalm", "Proverbs", "Ecclesiastes", "Song of Songs", "Isaiah", "Jeremiah", "Lamentations", "Ezekiel", "Daniel", "Hosea", "Joel", "Amos", "Obadiah", "Jonah", "Micah", "Nahum", "Habakkuk", "Zephaniah", "Haggai", "Zechariah", "Malachi", "Matthew", "Mark", "Luke", "John", "Acts", "Romans", "1 Corinthians", "2 Corinthians", "Galatians", "Ephesians", "Philippians", "Colossians", "1 Thessalonians", "2 Thessalonians", "1 Timothy", "2 Timothy", "Titus", "Philemon", "Hebrews", "James", "1 Peter", "2 Peter", "1 John", "2 John", "3 John", "Jude", "Revelation"]
  restrict: "A"
  link: (scope, element, attrs) ->
    element.autocomplete source: bible

directiveModule.directive 'fullCalendar', ->
  restrict: 'A'
  replace: true
  transclude: true
  #scope: { events: '=' }
  template: "<div id=\"calendar\"></div>"
  link: (scope, element, attrs) ->
    console.log(scope.events)
    element.fullCalendar
      header:
        left: 'prev,next today'
        center: 'title'
        right: 'month,basicWeek'
      defaultView: 'month'
      editable: false
      height: 500
      #loading: (bool) -> 
      #if bool then $("#loading").show() else $("#loading").hide()
      #events: '/messages/calendar.json' 
      events: scope.events
      #events: [{title: 'all day event', start: new Date(), allDay: true}] 
      eventClick: (event) ->
        window.location = '#/show/' + event.id
        false

#
#*  Implementation of JQuery FullCalendar 
#*  inspired by http://arshaw.com/fullcalendar/ 
#*  
#*  Basic Calendar Directive that takes in live events as the ng-model and then calls fullCalendar(options) to render the events correctly. 
#*  
#*  Authors
#*  @andyjoslin
#*  @joshkurz
#
directiveModule.directive "devCalendar", ["ui.config", "$parse", (uiConfig, $parse) ->
  uiConfig.devCalendar = uiConfig.devCalendar or {}
  
  #returns the calendar
  require: "ngModel"
  restrict: "A"
  scope:
    eventChanged: "=changed"
    events: "=ngModel"

  link: (scope, elm, $attrs) ->
    
    #update the calendar with the correct options
    update = ->
      
      #IF the calendar has options added then render them.
      expression = undefined
      options =
        header:
          left: "prev,next today"
          center: "title"
          right: "month,agendaWeek,agendaDay"

        
        # add event name to title attribute on mouseover. 
        eventMouseover: (event, jsEvent, view) ->
          $(jsEvent.target).attr "title", event.title  if view.name isnt "agendaDay"

        
        # Calling the events from the scope through the ng-model binding attribute. 
        events: scope.events
        # jc customized
        eventClick: (event) ->
          window.location = '#/show/' + event.id
          false

      if $attrs.devCalendar
        expression = scope.$eval($attrs.devCalendar)
      else
        expression = {}
      
      #Set the options from the directive's configuration
      angular.extend options, uiConfig.devCalendar, expression
      elm.html("").fullCalendar options
    ngModel = $parse($attrs.ngModel)
    editEvents = []
    update()
    
    #
    #            *
    #            *    This is where I get confused. Not sure why you can only watch events.length to update the scope accordingly. If events is watched The console blows to shreds and nothing happens. 
    #            *    
    #            *
    #            
    scope.$watch "events.length", ((newVal, oldVal) ->
      console.log "model changed:", newVal, oldVal
      update()
    ), true
]
