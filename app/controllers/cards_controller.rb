class CardsController < ApplicationController
  before_action :set_card, only: [:update, :destroy, :move ]

  def move
    @card.update(card_params)
    render 'show.json'
  end

  def create
    @card = Card.new(card_params)

    respond_to do |format|
      if @card.save
        format.html { redirect_to card_url(@card), notice: "Card was successfully created." }
        format.json { render :show, status: :created, location: @card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @card.update(card_params)
        ActionCable.server.broadcast("board", {commit: 'REPLACE_CARD', payload: render_to_string(:show, format: :json)})
        format.html { redirect_to card_url(@card), notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url, notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_card
      @card = Card.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:name, :list_id, :position)
    end
end
