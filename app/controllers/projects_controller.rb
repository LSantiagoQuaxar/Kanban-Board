class ProjectsController < ApplicationController
  
  
  get "/projects/new" do
    unauthorized_redirect
    erb :"/projects/new.html"
  end
  
 
  get "/projects" do
    unauthorized_redirect
    @user = current_user
    erb :"/projects/index.html"
  end
  
 
  post "/projects" do
    unauthorized_redirect
    
    @project = Project.new(
      :title => params[:title],
      :description => params[:description],
      :user => current_user
      )

    if @project.valid?
      @project.save
      redirect "/projects/#{@project.id}"

    else
      session[:errors] = Hash(@project.errors)
      redirect back

    end
  end
  
  
  get "/projects/:id" do
    unauthorized_redirect
    @project = Project.find_by_id(params[:id])
    erb :"/projects/show.html"
  end
  
  
  get "/projects/:id/edit" do
    unauthorized_redirect
    @project = Project.find_by_id(params[:id])
    erb :"/projects/edit.html"
  end
  
 
  patch "/projects/:id" do
    unauthorized_redirect
    @project = Project.find_by_id(params[:id])
    @project.update(:title => params[:title], :description => params[:description])

    if @project.valid?
      redirect "/projects/#{@project.id}"
    else
      session[:errors] = @project.errors
      redirect back
    end 
  end
  
 
  delete "/projects/:id/delete" do
    unauthorized_redirect
    @project = Project.find_by_id(params[:id])
    @project.destroy
    redirect "/"
  end
end
