class CreditCardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_credit_card, only: %i[show edit update destroy move]

  # GET /credit_cards or /credit_cards.json
  def index
    @credit_cards = current_user.credit_cards.order(:created_at)
  end

  # GET /credit_cards/1 or /credit_cards/1.json
  def show; end

  # GET /credit_cards/new
  def new
    @credit_card = current_user.credit_cards.new
    @credit_card.credit_card_image = CreditCardImage.new(card_image: CardImage.blank_card)
  end

  # GET /credit_cards/1/edit
  def edit; end

  # POST /credit_cards or /credit_cards.json
  def create
    @credit_card = current_user.credit_cards.new(credit_card_params)

    respond_to do |format|
      if @credit_card.save
        format.html { redirect_to credit_cards_path, notice: 'Credit card was successfully created.' }
        format.json { render :show, status: :created, location: @credit_card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @credit_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /credit_cards/1 or /credit_cards/1.json
  def update
    respond_to do |format|
      if @credit_card.update(credit_card_params)
        format.html { redirect_to credit_cards_path, notice: 'Credit card was successfully updated.' }
        format.json { render :show, status: :ok, location: @credit_card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @credit_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credit_cards/1 or /credit_cards/1.json
  def destroy
    @credit_card.destroy

    respond_to do |format|
      format.html { redirect_to credit_cards_url, notice: 'Credit card was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # PATCH /credit_cards/:id/move
  def move
    @credit_card.insert_at(params[:position].to_i)
    head :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_credit_card
    @credit_card = current_user.credit_cards.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def credit_card_params
    params.require(:credit_card).permit(:name, :position,
                                        credit_card_image_attributes: [:card_image_id]).with_defaults(user: current_user)
  end
end
