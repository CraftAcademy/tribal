# frozen_string_literal: true

class SessionsController < ApplicationController
  layout 'application'

  def show
    user = current_user if user_signed_in?
    session = Session.find(params[:id])
    price = SessionPriceService.get_price(session)
    channel_name = session.channel_name
    @session_props = { session: session,
                      coach: session.coach,
                      members: session.users,
                      user: user,
                      price: price,
                      channel_name: channel_name }
    end

  def create
    pt = PriceTable.find_by(price_point: params[:session][:price_point])
    @session = current_user.organised_sessions.create(session_params.merge(price_table: pt))
    if @session.persisted?
      @session.set_channel_name
      @session.save
      redirect_to root_path
    else
      render json: { errors: 'Every field needs to be filled in!' }
    end
  end

  private

  def session_params
    params.require(:session).permit(:title, :start_date)
  end
end
