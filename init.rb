ActionDispatch::Callbacks.to_prepare do
  begin
	action_controller_view_logger ||= Logger.new("#{Rails.root}/log/action_controller_view_logger.log")

	ActiveSupport::Notifications.subscribe "process_action.action_controller" do |*args|
	  event = ActiveSupport::Notifications::Event.new *args
	  #event.name      # => "process_action.action_controller"
	  #event.time      # => start time
	  #event.end       # => end time
	  #event.duration  # => 10 (in milliseconds)
	  #event.transaction_id
	  #event.payload   # => {:extra=>information}
	
	  action_controller_view_logger.info "=>name=#{event.name}<==>transaction_id=#{event.transaction_id}<==>start_time=#{event.time}<==>end_time=#{event.end}<==>duration=#{event.duration}<==>view_runtime=#{event.payload[:view_runtime]}<==>db_runtime=#{event.payload[:db_runtime]}<==>payload=#{event.payload}<="
	    
	end
	  
	#action_view_logger ||= Logger.new("#{Rails.root}/log/action_view_logger.log")

	ActiveSupport::Notifications.subscribe "render_template.action_view" do |*args|
	  event = ActiveSupport::Notifications::Event.new *args
	  action_controller_view_logger.info "=>name=#{event.name}<==>transaction_id=#{event.transaction_id}<==>start_time=#{event.time}<==>end_time=#{event.end}<==>duration=#{event.duration}<==>payload=#{event.payload}<="
	end
  rescue Exception => e
  		
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
