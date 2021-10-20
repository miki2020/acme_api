class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: [:show, :update, :destroy]

  # GET /subscriptions
  def index
    @subscriptions = Subscription.all

    render json: @subscriptions
  end

  # GET /subscriptions/1
  def show
    render json: @subscription
  end

  # POST /subscriptions
  def create
    require "fakeapi"
    @amount = (Product.find(subscription_params[:product_id]).price * 100).to_i
    @payment = Fakeapi.post_payment(payment_params)
    render json: @payment, status: :unprocessable_entity and return unless @payment['success']

    @subscription = Subscription.new(subscription_params.merge( "payment_token" => "#{@payment['token']}" ))


    if @subscription.save
      render json: @subscription, status: :created, location: @subscription
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /subscriptions/1
  def update
    if @subscription.update(subscription_params)
      render json: @subscription
    else
      render json: @subscription.errors, status: :unprocessable_entity
    end
  end

  # DELETE /subscriptions/1
  def destroy
    @subscription.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subscription
      @subscription = Subscription.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def subscription_params
      params.require(:subscription).permit(:payment_token, :customer_id, :product_id)
    end

    def payment_by_token?
      subscription_params[:payment_token]
    end

    def payment_params
      @amount = (Product.find(subscription_params[:product_id]).price * 100).to_i

      return {"amount": "#{@amount}", "payment_token": "#{subscription_params[:payment_token]}"} if payment_by_token?

      zip_code = Customer.find(subscription_params[:customer_id]).zip_code
      card_params = params.slice(:card_number, :cvv, :expiration_month, :expiration_year).to_enum.to_h.merge({"zip_code"=> zip_code})
      {"amount"=>"#{@amount}"}.merge(card_params)
    end





end
