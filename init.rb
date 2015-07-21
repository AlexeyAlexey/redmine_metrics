ActionDispatch::Callbacks.to_prepare do
  Rails.logger.info 'Starting RedmineMetrics plugin for RedMine'
  begin
  	path_to_logfile = File.dirname(__FILE__) + '/log/action_controller_view_logger.log'
	#action_controller_view_logger ||= Logger.new(path_to_logfile)
	action_controller_view_logger ||= Logger.new(path_to_logfile, 7, 1048576)

	action_controller_view_logger.formatter = proc do |severity, datetime, progname, msg|
      "#{msg}\n"
    end

	ActiveSupport::Notifications.subscribe "process_action.action_controller" do |*args|
	  event = ActiveSupport::Notifications::Event.new *args
	  #event.name      # => "process_action.action_controller"
	  #event.time      # => start time
	  #event.end       # => end time
	  #event.duration  # => 10 (in milliseconds)
	  #event.transaction_id
	  #event.payload   # => {:extra=>information}
	  current_user = ""
	  current_user_id = 0
	  begin
	  	current_user = User.current
	  	current_user_id = current_user.id
	  rescue 	  	
	  end
	
	  action_controller_view_logger.info "=>name=#{event.name}<==>transaction_id=#{event.transaction_id}<==>current_user=#{current_user}<==>user_id=#{current_user_id}<==>controller=#{event.payload[:controller]}<==>action=#{event.payload[:action]}<==>status=#{event.payload[:status]}<==>start_time=#{event.time.to_s(:db)}<==>end_time=#{event.end.to_s(:db)}<==>duration=#{event.duration}<==>view_runtime=#{event.payload[:view_runtime]}<==>db_runtime=#{event.payload[:db_runtime]}<==>payload=#{event.payload}<="
	    
	end
	  
	#action_view_logger ||= Logger.new("#{Rails.root}/log/action_view_logger.log")

	ActiveSupport::Notifications.subscribe "render_template.action_view" do |*args|
	  event = ActiveSupport::Notifications::Event.new *args
	  action_controller_view_logger.info "=>name=#{event.name}<==>transaction_id=#{event.transaction_id}<==>start_time=#{event.time.to_s(:db)}<==>end_time=#{event.end.to_s(:db)}<==>duration=#{event.duration}<==>payload=#{event.payload}<="
	end
  rescue Exception => e
  	Rails.logger.error "Error From RedmineMetrics plugin: #{e}"
  end
end
Redmine::Plugin.register :redmine_metrics do
  name 'Redmine Metrics plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
end
