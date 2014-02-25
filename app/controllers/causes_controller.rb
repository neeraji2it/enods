class CausesController < ApplicationController
  before_filter :is_signin?, :except => ['show']
  def index
    @causes = Cause.paginate :page => params[:cause_page], :per_page => 20
  end
  
  def new
    @cause = Cause.new
  end

  def create
    @cause = Cause.new(params[:cause])
    if @cause.save
      flash[:success] = "Successfully created the causes"
      redirect_to causes_path
    else
      flash[:error] = "Failed to create the Cause."
      render :action => 'new'
    end
  end
  
  def edit
    @cause = Cause.find(params[:id])
  end
  
  def show
    @cause = Cause.find(params[:id])
    @products = Product.where("cause_id = #{@cause.id}")
  end
  
  def update
    @cause = Cause.find(params[:id])
    if @cause.update_attributes(params[:cause])
      flash[:success] = "Successfully updated the causes"
      redirect_to causes_path
    else
      flash[:error] = "Failed to update the Cause."
      render :action => 'edit'  
    end
  end
  
  def destroy
    @cause = Cause.find(params[:id])
    @cause.destroy
    redirect_to causes_path
  end
end
