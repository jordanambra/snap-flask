name "balancer"
description "Nginx-based Load Balancer"
run_list "recipe[ubuntu]",
         "recipe[nginx]",
         "recipe[snap::balancer]"
