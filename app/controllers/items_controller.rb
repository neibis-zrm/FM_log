class ItemsController < ApplicationController
  before_action :items, only: [:show, :destroy, :show_image]
  before_action :move_to_index, except: [:index, :show]

  def index
    @items = Item.all
    @parents = Category.where(ancestry: nil)
  end

  def show
    @category = @items.category
    if @category.ancestry == nil
      @parent = @category
      @child = nil
      @grandchild = nil
    elsif @category.ancestry.include?("/") == false
      @parent = Category.find_by(id: @category.ancestry)
      @child = @category
      @grandchild = nil
    else
      @parent = Category.find_by(id: @category.ancestry.split("/")[0])
      @child = Category.find_by(id: @category.ancestry.split("/")[1])
      @grandchild = @category
    end
    @image = ItemImage.all
  end

  def destroy
    if @items.destroy
      redirect_to root_path
    else
      alert:"削除ができません"
    end
  end
  
  def show_image
    @image = @items.item_images
    send_data @image[0].image.file.read, :type => 'image.content_type', :disposition => 'inline'
  end
  

  def edit

  end

  def edit

  end

  private
  def items
    @items = Item.find(params[:id])
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end
