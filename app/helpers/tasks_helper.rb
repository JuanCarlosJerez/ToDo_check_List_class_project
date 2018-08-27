module TasksHelper

  def badge_class_for(task)
    if task.due_date.nil?
      ""
    elsif task.due_date < Date.today
      "badge badge-danger"
    elsif task.due_date <= 3.days.from_now.to_date
      "badge badge-warning"
    else
      "badge badge-success"
    end
  end

end
