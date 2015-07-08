tekton_account = Account.create(company_name: "Tekton Labs", subdomain: "tektonlabs", company_url: "http://tektonlabs.com", company_phone: "")
Client.all.each	{ |c| c.update_attributes(account_id: tekton_account.id) }
Task.all.each	{ |t| t.update_attributes(account_id: tekton_account.id) }
Project.all.each{ |p| p.update_attributes(account_id: tekton_account.id) }
Team.all.each	{ |t| t.update_attributes(account_id: tekton_account.id) }

User.create([{ :email=>"alonso.alvarez@tektonlabs.com",
              :first_name=>"Pedro",
              :last_name=>"Castillo",
              :password=>"tektonlabs",
              :role_id=> 1,
              :qr_code=>"8101371523207616324516662529569",
              :account_id=>1},
              { :email=>"billy.tandaypan@tektonlabs.com",
              :first_name=>"Billy",
              :last_name=>"Tandaypan",
              :password=>"tektonlabs",
              :role_id=> 2,
              :qr_code=>"8101374221285219106828435331562",
              :account_id=>1} ])