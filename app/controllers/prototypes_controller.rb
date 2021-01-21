class PrototypesController < ApplicationController
  before_action :authenticate_user!, only:[:new ,:edit, :derete]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end
  
  def create
    @prototype = Prototype.create(prototype_params)
      if @prototype.save
        redirect_to root_path
      else
        render :new
      end
  end

  def show
    @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
      unless user_signed_in? && current_user.id == @prototype.user_id
        redirect_to action: :index
      end
  end

  def update
    prototypes = Prototype.find(params[:id])
    prototypes.update(prototype_params)
    if prototypes.save
      redirect_to prototype_path
    else
      render :edit
    end
 end

 def destroy
  prototypes = Prototype.find(params[:id])
  prototypes.destroy
  redirect_to root_path
end

  private

  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

end
