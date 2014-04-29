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
  
  def like
    @cause = Cause.find(params[:id])
    @like = CauseFan.find_by_user_id_and_cause_id(current_user.id,@cause.id)
    if !@like.present?
      CauseFan.create(:cause_id => @cause.id, :user_id => current_user.id, :status => params[:status])
    else
      @like.update_attribute(:status, params[:status])
    end
    redirect_to cause_path(@cause)
  end
  
  def edit
    @cause = Cause.find(params[:id])
  end
  
  def show
    @cause = Cause.find(params[:id])
    @cause.update_attribute(:count, @cause.count + 1)
    @products = Product.where("(cause_id = #{@cause.id} and status = 'confirmed') or non_profit_cause = 'Any'")
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
