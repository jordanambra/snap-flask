name "web"
description "Nginx Web Server + uwsgi"
run_list "recipe[ubuntu]",
         "recipe[nginx]",
         "recipe[supervisor]",
         "recipe[python]",
         "recipe[snap::web]"
