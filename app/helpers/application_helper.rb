module ApplicationHelper

  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

  def display_datetime(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end

    dt.strftime("at %m/%d/%Y %l:%M%P %Z") # 03/14/2013 9:09pm
  end

  def create_or_update(ivar)
    ivar.new_record? ? 'Create' : 'Update'
  end

end

