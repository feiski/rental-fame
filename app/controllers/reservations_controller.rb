class ReservationsController < ApplicationController
  before_action :set_offer, only: %i[new create]

  def index
    @reservations = Reservation.where(user: current_user)
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.offer = @offer
    @reservation.user = current_user
    if @reservation.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def update
    @reservation = Reservation.find(params[:id])
    @reservation.accepted = true
    if @reservation.save!
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path, status: :see_other
  end

  private

  def set_offer
    @offer = Offer.find(params[:offer_id])
  end

  def reservation_params
    params.require(:reservation).permit(:comment, :accepted)
  end
end
