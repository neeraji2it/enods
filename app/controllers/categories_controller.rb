class CategoriesController < ApplicationController
  before_filter :is_signin?, :is_admin?

  def index
    @categories = Category.where("parent_id IS NULL")
  end
  
  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:success] = "Success"
      redirect_to categories_path
    else
      render :action => 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:success] = "Success"
      redirect_to categories_path
    else
      render :action => 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to categories_path
  end
end
