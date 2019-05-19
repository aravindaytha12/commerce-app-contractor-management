module ApplicationHelper
  def page_title
    content_for(:title) || 'Contractor Management'
  end
  
  def state_options
    States::OPTIONS
  end
end
