name "database"
description "PostgreSQL database server"
run_list "recipe[ubuntu]",
         "recipe[snap::database]"
