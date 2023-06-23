class OffersController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :owner, only: %i[edit update destroy]
  before_action :set_offer, only: %i[show edit update destroy]

  def index
    if params[:show_owned]
      @offers = current_user.offers
    elsif params[:query].present?
      sql_query = "title ILIKE :query OR description ILIKE :query"
      @offers = Offer.where(sql_query, query: "%#{params[:query]}%")
    else
      @offers = Offer.all
    end
  end

  def show
    @offer = Offer.find(params[:id])
    @reservations = @offer.reservations
    @reserved = false
    @reservations.each do |reservation|
      @reserved = true if reservation.user == current_user
    end
  end

  def new
    @offer = Offer.new
  end

  def create
    # Need to use "current_user.offers.build to assign the user_id to the offer"
    @offer = current_user.offers.build(offer_params)
    if @offer.save
      redirect_to offer_path(@offer)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @offer.update(offer_params)
      redirect_to offer_path(@offer)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @offer.destroy
    redirect_to offers_path(show_owned: true)
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:title, :description, :date, :price, :photo)
  end

  def owner
    @offer = Offer.find(params[:id])
    return if @offer.user == current_user

    flash[:warning] = 'You are not authorized to edit/delete this offer (not the owner).'
    redirect_to offers_path
  end
end
