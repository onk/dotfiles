Pry.config.color = true

Pry.config.prompt = proc do |obj, nest_level, _pry_|
version = ''
version << "Rails#{Rails.version}" if defined? Rails
version << "\001\e[0;31m\002"
version << "#{RUBY_VERSION}"
version << "\001\e[0m\002"

"#{version} #{Pry.config.prompt_name}(#{Pry.view_clip(obj)})> "
end
Pry.hooks.add_hook(:before_eval, "display_start_time"){|code| puts "\001\e[0;90m\002Start:  #{Time.now}\001\e[0m\002" }
Pry.hooks.add_hook(:after_eval, "display_finish_time"){|result| puts "\001\e[0;90m\002Finish: #{Time.now}\001\e[0m\002" }
