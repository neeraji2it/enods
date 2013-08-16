class CausesController < ApplicationController
  before_filter :is_signin?
  def index
    @causes = Cause.paginate :page => params[:cause_page], :per_page => 20
  end
  
  def new
    @cause = Cause.new
  end

  def create
    @cause = Cause.new(params[:cause])
    if @cause.save
      flash[:notice] = "Successfully created the causes"
      redirect_to causes_path
    else
      flash[:error] = "Failed to create the Cause."
      render :action => 'new'
    end
  end
end
