class TasksController < ApplicationController


  get "/tasks/new" do
    unauthorized_redirect
    erb :"/tasks/new.html"
  end

 
  post "/tasks" do
    unauthorized_redirect
    @project = Project.find_by_id(params[:project_id])
    @task = Task.new(
      :user => current_user,
      :project => @project,
      :content => params[:content],
      :doneness => 0
    )
    if @task.valid?
      @task.save
      redirect "/projects/#{params[:project_id]}"
    
    else
      session[:errors] = Hash(@task.errors)
      redirect back
    end
  end

  
  get "/tasks/:id/edit" do
    unauthorized_redirect
    @task = Task.find_by_id(params[:id])
    erb :"/tasks/edit.html"
  end

  
  patch "/tasks/:id" do
    unauthorized_redirect
    @task = Task.find_by_id(params[:id])
    @task.update(params[:task])

    if @task.valid?
      redirect "/projects/#{@task.project.id}"
    else
      session[:errors] = Hash(@task.errors)
      redirect back
    end
  end

  
  patch "/tasks/:id/move-up" do
    unauthorized_redirect
    @task = Task.find_by_id(params[:id])
    current_stage = @task.doneness.to_i
    if @task.doneness.to_i < 2
      @task.update(:doneness => current_stage += 1)
      redirect back
    else
      redirect back
    end
  end

 
  delete "/tasks/:id/delete" do
    unauthorized_redirect
    @task = Task.find_by_id(params[:id])
    @task.destroy
    redirect back
  end
end