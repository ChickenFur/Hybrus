Meteor.startup ->
  if Activities.find().count() is 0
    Activities.insert
      title: "Awesome Activity Here"
      details: "Going on over there"