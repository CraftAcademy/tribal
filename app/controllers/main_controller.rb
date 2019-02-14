# frozen_string_literal: true

class MainController < ApplicationController
  layout 'application'
  before_action :get_and_update_price_on_sessions
  before_action :get_channel_name

  def index
    if user_signed_in?
      my_sessions = current_user.coach? ? current_user.organised_sessions : current_user.sessions 
    end
    @main_props = { sessions: @sessions,
                    user: current_user,
                    mysessions: my_sessions,
                    channel_name: @channel_name }
   end

  private

  def get_and_update_price_on_sessions
    @sessions = Session.includes(:users)
    @sessions.each do |session|
      price = SessionPriceService.get_price(session)
      session.update_attribute(:price, price)
    end
    @sessions.to_json(include: :users)
  end

  def get_channel_name
    @channel_name = Session.find_by(id: params[:sessionId]).channel_name if params[:sessionId]
  end
end
