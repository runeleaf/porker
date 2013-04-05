class CardsController < ApplicationController
  before_action :current_plan
  before_action :set_card, only: [:show, :edit, :update, :destroy]

  # GET /cards
  # GET /cards.json
  def index
    @cards = @plan.cards
    @card = Card.new
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards
  # POST /cards.json
  def create
    response.headers["Content-Type"] = "text/javascript"
    @card = @plan.cards.new(card_params)
    @card.save
    $redis.publish('messages.create', @card.to_json)
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to plan_path(@plan), notice: 'Card was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
    respond_to do |format|
      format.html { redirect_to plan_path(@plan) }
      format.json { head :no_content }
    end
  end

=begin
  def events
    response.headers["Content-Type"] = "text/event-stream"
    3.times do |n|
      response.stream.write "data: #{n}...\n\n"
      sleep 2
    end

  end
=end

  def events
    response.headers["Content-Type"] = "text/event-stream"
    start = Time.zone.now
    5.times do |n|
      #@plan.cards.where(:created_at.gt => Time.zone.now).each do |card|
      str = {text: ""}
      @plan.cards.each do |card|
        str[:text] += "#{card.point}pt (#{card.note})\n"
        #response.stream.write "data: #{card.to_json}\n\n"
        #start = Time.zone.now
      end
      response.stream.write "data: #{str.to_json}\n\n"
      sleep 1
    end
  rescue IOError
    logger.info "Stream closed"
  ensure
    response.stream.close
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = @plan.cards.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_params
      params.require(:card).permit(:point, :note)
    end

    def current_plan
      @plan = params[:plan_id].blank? ? nil : Plan.find(params[:plan_id])
    end

end
