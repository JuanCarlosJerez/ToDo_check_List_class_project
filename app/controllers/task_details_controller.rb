class TaskDetailsController < ApplicationController
  before_action :set_task, only: [:index, :create]
  before_action :set_task_detail, only: [:update, :destroy]

  def create
    @task_detail = @task.task_details.new(task_detail_params)
    if @task_detail.save
      redirect_to task_task_details_path(@task), notice: "Task detail successfully created!"
    else
      redirect_to task_task_details_path(@task), notice: "Sorry, could not create task detail because #{@task_detail.errors.full_messages.join(', ').downcase}."
    end
  end

  def update
    @task_detail.update(task_detail_params)
    redirect_to task_task_details_path(@task_detail.task),
      notice: "Task detail successfully updated."
  end

  def index
    @task_detail = TaskDetail.new
  end

  def destroy
    @task_detail.destroy
    redirect_to task_task_details_path(@task_detail.task),
    notice: "Task detail successfully destroyed"
  end

  private

  def set_task
    @task = current_user.tasks.find(params[:task_id])
  end

  def set_task_detail
    @task_detail = TaskDetail.find(params[:id])
    redirect_to root_path unless @task_detail.task.user == current_user
  end

  def task_detail_params
    params.require(:task_detail).permit(:description, :completed)
  end

end
