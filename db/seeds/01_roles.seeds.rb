	role_man = Role.find_or_initialize_by(id: Role::MANAGER_ID)
role_man.name = "Manager"
role_man.save
role_col = Role.find_or_initialize_by(id: Role::COLLABORATOR_ID)
role_col.name = "Collaborator"
role_col.save
role_adm = Role.find_or_initialize_by(id: Role::ADMINISTRATOR_ID)
role_adm.name = "Administrator"
role_adm.save