class LikesController < ApplicationController
  before_action :set_dog
  before_action :set_like, only: %i[destroy]

  def create
    @like = @dog.likes.where(user_id: current_user.id).first_or_create unless current_user.owner?(@dog)

    respond_to do |format|
      format.html { redirect_to @dog }
      format.js
    end
    authorize @like
  end

  def destroy
    if liked?
      @like.destroy
      respond_to do |format|
        format.html
        format.js
      end
    end
    authorize @like
  end

  private

  def set_dog
    @dog = Dog.find(params[:dog_id])
  end

  def set_like
    @like = @dog.likes.where(user_id: current_user.id).first
  end

  def liked?
    @dog.likes.where(user_id: current_user.id).exists?
  end
end
