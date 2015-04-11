tekton_account = Account.create(company_name: "Tekton Labs", subdomain: "tektonlabs", company_url: "http://tektonlabs.com", company_phone: "")
User.all.each	{ |u| u.update_attributes(account_id: tekton_account.id) }
Client.all.each	{ |c| c.update_attributes(account_id: tekton_account.id) }
Task.all.each	{ |t| t.update_attributes(account_id: tekton_account.id) }
Project.all.each{ |p| p.update_attributes(account_id: tekton_account.id) }
Team.all.each	{ |t| t.update_attributes(account_id: tekton_account.id) }