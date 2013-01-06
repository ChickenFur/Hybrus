ActivitiesRouter = Backbone.Router.Extend(
  routes:
    ":activity_id" : "main"
    main: (activity_id) ->
      Session.set "activity_id", activity_id

    setActivity: (activity_id) ->
      @navigate(activity_id, true)

)

Router = new ActivitiesRouter

Meteor.startup ->
  BackBone.history.start pushState: true

Template.activityList.activities = ->
  Activities.find({},
    sort:
      name: 1
  )

Template.activityList.events =
  'click #newActivity' :(e) ->
        title = $('#newActivityTitle').val()
        newDetails = $('#newActivityDetails').val()
        if title
          Activities.insert(
            title: title
            details: newDetails
          )
Template.activity.events = 
  'click #deleteButton' : (e) ->
    Activities.remove(@_id)
  'click #editButton' : (e) ->
    Router.setActicity(@_id)

Template.activity.selected = ->
  if Session.equals("activity_id", @_id) then "selected" else ""

Template.activityView.selectedActivity = ->
  activity_id = Session.get("activity_id")
  Activities.findOne(
    _id: activity_id
    )
Template.activityView.events = 
  'keyup #activityDetail': (e) ->
    sel = _id : Session.get("activity_id")
    mod = $set: text $('#activityDetail').val()
    Activities.update(sel, mod)