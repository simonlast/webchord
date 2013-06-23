require './finger.coffee'

class Node
  # Define members in constructor such that
  # we can declare private and priviledged 
  # members.
  # For details: http://javascript.crockford.com/private.html
  constructor: () ->
    finger = new Finger
    