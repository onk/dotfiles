Pry.hooks.add_hook(:before_eval, "display_start_time"){|code| puts "\001\e[0;90m\002Start:  #{Time.now}\001\e[0m\002" }
Pry.hooks.add_hook(:after_eval, "display_finish_time"){|result| puts "\001\e[0;90m\002Finish: #{Time.now}\001\e[0m\002" }
