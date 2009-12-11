class PortalsController < ApplicationController
  def index
    @portals = Portal.all
  end
  
  def show
    @portal = Portal.find(params[:id])
  end
  
  def new
    @portal = Portal.new
  end
  
  def create
    @portal = Portal.new(params[:portal])
    if @portal.save
      flash[:notice] = "Successfully created portal."
      redirect_to @portal
    else
      render :action => 'new'
    end
  end
  
  def edit
    @portal = Portal.find(params[:id])
  end
  
  def update
    @portal = Portal.find(params[:id])
    if @portal.update_attributes(params[:portal])
      flash[:notice] = "Successfully updated portal."
      redirect_to @portal
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @portal = Portal.find(params[:id])
    @portal.destroy
    flash[:notice] = "Successfully destroyed portal."
    redirect_to portals_url
  end
end
