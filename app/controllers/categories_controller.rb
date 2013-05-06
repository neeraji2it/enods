class CategoriesController < ApplicationController
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = "Success"
      redirect_to products_path
    else
      render :action => 'new'
    end
  end
end
