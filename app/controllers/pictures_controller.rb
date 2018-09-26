class PicturesController < ApplicationController
  before_action :set_picture, only: [:show,:edit,:update,:destroy]
  before_action :require_logged_in!, only: [:new, :edit, :show, :destroy]

  def index
    @page = params[:page].to_i
    @page = 0 if @page == nil
    @page_num = 6
    @record_count = Picture.where("id > 0").count
    @results = Picture.where("id > 0").order("id DESC")
                       .offset(@page * @page_num).limit(@page_num)
  end

  def new
    if params[:back]
      @picture = Picture.new(picture_params)
    else
      @picture = Picture.new
    end
  end

  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    binding.pry
    if @picture.save
      #ContactMailer.picture_create_mail(@picture).deliver
      redirect_to pictures_path, notice: "create"
    else
      render 'new'
    end
  end

  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    render 'new' if @picture.invalid?
  end

  def show
    @favorite = current_user.favorites.find_by(picture_id: @picture.id)
    @user = User.find_by(id: @picture.user_id)
  end

  def edit
  end

  def update
    if @picture.update(picture_params)
      redirect_to pictures_path, notice:"update"
    else
      render 'edit'
    end
  end

  def destroy
    @picture.destroy
    redirect_to pictures_path, notice:"delete"
  end

  private
  def picture_params
    params.require(:picture).permit(:image, :image_cache, :content)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end


end
