class ReviewsController < ApplicationController
  before_action :_set_review, only: [:show, :edit, :update, :destroy]
  layout "dashboard.html"

  # GET /reviews
  # GET /reviews.json
  def index
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @order = Order.find(@review.order_id)
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render json: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    if @review.update_attribute(:text, params[:text])
      render json: { notice: "Review was edited successfully"}
    else
      render json: { alert: "Please, try again", errors: @review.errors }
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def _set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:owner, :rider_id, :driver_id, :order_id, :stars, :text)
    end
end
