@Pages = new Meteor.Collection 'pages'
if Meteor.isClient
  UI.body.events
    'click .lessons-toggle': ->
      $('.sidebar').sidebar('toggle')

#lessonsMenu
  Template.lessonsMenu.lessons= ->
      Pages.find()

  Template.lessonsMenu.events
    'click a.item': (evt, tmp)->
      Session.set 'currentLesson', evt.target.text

#lesson
  Template.lesson.content= ->
    Pages.findOne({title: Session.get('currentLesson')}).content

if Meteor.isServer
  fs = Npm.require('fs')
  files =  fs.readdirSync('../server/assets/app')
  for filename in files
    content = Assets.getText(filename)
    title = filename.split('.')[0]
    Pages.upsert({title: title}, {title: title, content: content})
