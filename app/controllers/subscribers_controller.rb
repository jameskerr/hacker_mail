class SubscribersController < ApplicationController
  before_action :set_subscriber, only: [:show, :edit, :update, :destroy]

  # GET /subscribers/new
  def new
    @subscriber = Subscriber.new
  end

  def show
    if !@subscriber.confirmed?
      if @subscriber.update confirmed: true
        flash.now.notice = "Email Confirmed"
      end
    end
  end

  # GET /subscribers/1/edit
  def edit
  end

  # POST /subscribers
  # POST /subscribers.json
  def create
    @subscriber = Subscriber.find_by(email: create_params[:email]) ||
                  Subscriber.new(create_params)

    if @subscriber.confirmed?
      HackerMailer.with(subscriber: @subscriber).update_link.deliver_later
      render :confirmation_sent, status: :created
    else
      if @subscriber.save
        HackerMailer.with(subscriber: @subscriber).confirmation.deliver_later
        render :confirmation_sent, status: :created
      else
        render :new
      end
    end
  end

  # PATCH/PUT /subscribers/1
  # PATCH/PUT /subscribers/1.json
  def update
    if @subscriber.update(update_params)
      redirect_to @subscriber, notice: "Updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /subscribers/1
  # DELETE /subscribers/1.json
  def destroy
    @subscriber.destroy
    respond_to do |format|
      format.html { redirect_to new_subscriber_url, notice: "Subscriber was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_subscriber
    @subscriber = Subscriber.find_by!(key: params[:key])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def create_params
    params.require(:subscriber).permit(:email, :threshold)
  end

  def update_params
    params.require(:subscriber).permit(:threshold)
  end
end
