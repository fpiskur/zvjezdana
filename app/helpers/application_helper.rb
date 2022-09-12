module ApplicationHelper

  def agent_mobile?
    request.user_agent =~ /Mobile|webOS/
  end
  
end
