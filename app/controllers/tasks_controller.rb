class TasksController < ApplicationController
  before_action :set_task, only: [:destroy, :update]

  # GET /tasks
  def index
    if params[:completed] == "true"
      @tasks = current_user.tasks.completed.by_due_date
    elsif params[:not_due] == "true"
      @tasks = current_user.tasks.incomplete.not_due.by_due_date
    elsif params[:due_soon] == "true"
      @tasks = current_user.tasks.incomplete.due_soon.by_due_date
    elsif params[:past_due] == "true"
      @tasks = current_user.tasks.incomplete.past_due.by_due_date
    elsif params[:due_later] == "true"
      @tasks = current_user.tasks.incomplete.due_later.by_due_date
    else
      @tasks = current_user.tasks.incomplete.by_due_date
    end
    @task = current_user.tasks.new
  end

  # POST /tasks
  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to tasks_path, notice: 'Task was successfully created.'
    else
      redirect_to tasks_path, notice: "Sorry, could not create task because #{@task.errors.full_messages.join(', ').downcase}."
    end
  end

  def update
    completed = @task.completed
    @task.update(task_params)
    redirect_back(fallback_location: root_path, notice: 'Task was successfully updated.')
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_task
    @task = current_user.tasks.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def task_params
    params.require(:task).permit(:description, :completed, :due_date)
  end
end
