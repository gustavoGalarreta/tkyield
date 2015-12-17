tekton_account = Account.create(company_name: "Tekton Labs", subdomain: "tektonlabs", company_url: "http://tektonlabs.com", company_phone: "")
Client.all.each	{ |c| c.update_attributes(account_id: tekton_account.id) }
Task.all.each	{ |t| t.update_attributes(account_id: tekton_account.id) }
Project.all.each{ |p| p.update_attributes(account_id: tekton_account.id) }
Team.all.each	{ |t| t.update_attributes(account_id: tekton_account.id) }

User.create([{ :email=>"eduardo.arenas@tektonlabs.com",
              :first_name=>"Eduardo",
              :last_name=>"Arenas",
              :password=>"tektonlabs",
              :role_id=> 3,
              :qr_code=>"8101371523207616324516662529569",
              :account_id=>1,
              :team_leader=>true},

              { :email=>"gustavo.galarreta@tektonlabs.com",
              :first_name=>"Gustavo",
              :last_name=>"Galarreta",
              :password=>"password",
              :role_id=> 3,
              :qr_code=>"8101374221285219106828435331562",
              :account_id=>1},

              { :email=>"jorge.calvo@tektonlabs.com",
              :first_name=>"Jorgito",
              :last_name=>"Cavo",
              :password=>"password",
              :role_id=> 3,
              :qr_code=>"8101374221285219106828435331562",
              :account_id=>1},
              
              { :email=>"john.pacco@tektonlabs.com",
              :first_name=>"Bryam",
              :last_name=>"Pacco",
              :password=>"password",
              :role_id=> 2,
              :qr_code=>"8101374221285219106828435331562",
              :account_id=>1}  ])

