$ ->
	accountSubdomain = $("#account_subdomain")
	customSubdomain = $("#custom-subdomain")
	customSubdomain.html(window.location.host)
	$("#account_subdomain").bind 'keypress keyup', (e) ->
		key = e.which
		if !((key >= 65 && key <= 90) || (key >= 95 && key <= 122))
			return false
		s = accountSubdomain.val();
		customSubdomain.html(s + "." + window.location.host)