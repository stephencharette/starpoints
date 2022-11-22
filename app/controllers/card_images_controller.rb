class CardImagesController < ApplicationController
  before_action :authenticate_admin
  before_action :set_card_image, only: %i[show edit update]

  def index
    @card_images = CardImage.all
  end

  def show; end

  def new
    @card_image = CardImage.new
  end

  def edit; end

  def create
    respond_to do |format|
      ActiveRecord::Base.transaction do
        card_image_params[:images].drop(1).each do |image|
          card_image = CardImage.new
          card_image.image.attach(image)
          card_image.save!
        end

        format.html { redirect_to card_images_path, notice: 'Card Images were successfully created.' }
      rescue StandardError
        format.html { redirect_to card_images_path, notice: 'Card Images could not be created.' }
      end
    end
  end

  def update
    respond_to do |format|
      if @card_image.update(card_image_params)
        format.html { redirect_to card_images_path, notice: 'Card Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @card_image }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card_image.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_card_image
    @card_image = CardImage.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def card_image_params
    params.require(:card_image).permit(:name, images: [])
  end
end
