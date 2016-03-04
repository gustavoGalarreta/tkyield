@change_team_load = ->
  if ($('#user_team_id').val() != "")
    $("#team-leader-container").show()
  else
    $("#team-leader-container").hide()
  return

change_team = ->
  $('#user_team_id').change ->
    change_team_load()
  return
$(document).ready(change_team)
$(document).on('page:load', change_team)