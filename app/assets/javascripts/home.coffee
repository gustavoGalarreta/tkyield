ready = ->
	accountSubdomain = $("#account_subdomain")
	customSubdomain = $("#custom-subdomain")
	customSubdomain.html("http://" + window.location.host)
	$("#account_subdomain").bind 'keypress keyup', (e) ->
		key = e.which
		if !((key >= 65 && key <= 90) || (key >= 95 && key <= 122))
			return false
		s = accountSubdomain.val();
		customSubdomain.html("http://" + window.location.host + "/" + s)

$(document).ready(ready)
$(document).on('page:load', ready)