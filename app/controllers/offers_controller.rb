class OffersController < ApplicationController
  before_action :owner, only: %i[edit update]
  before_action :set_offer, only: %i[show edit update destroy]

  def index
    @offers = Offer.all
  end

  def show
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
    redirect_to root_path
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:title, :description, :date, :price)
  end

  def owner
    @offer = Offer.find(params[:id])
    return if @offer.user == current_user

    flash[:warning] = 'You are not authorized to edit this offer (not the owner).'
    redirect_to offers_path
  end
end
