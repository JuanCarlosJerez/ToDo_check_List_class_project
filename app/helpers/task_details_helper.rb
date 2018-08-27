module TaskDetailsHelper

  def display_description(task_detail)
    if task_detail.completed
      "<s>#{task_detail.description}</s>".html_safe
    else
      task_detail.description
    end
  end

end
