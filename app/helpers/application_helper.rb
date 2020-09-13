module ApplicationHelper
  def sidebar_classes(controller)
    'active' if controller_name == controller
  end

  def alert_class(key)
    case key
    when 'success'
      'success'
    when 'error'
      'danger'
    when 'alert'
      'warning'
    when 'notice'
      'info'
    end
  end
end
