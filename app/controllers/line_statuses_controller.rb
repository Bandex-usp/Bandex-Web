class LineStatusesController < ApplicationController
  before_action :set_line_status, only: [:show, :edit, :update, :destroy]

  # GET /line_statuses
  # GET /line_statuses.json
  def index
    @line_statuses = LineStatus.all
  end

  # GET /line_statuses/1
  # GET /line_statuses/1.json
  def show
  end

  # GET /line_statuses/new
  def new
    @line_status = LineStatus.new
  end

  # GET /line_statuses/1/edit
  def edit
  end

  # POST /line_statuses
  # POST /line_statuses.json
  def create
    @line_status = LineStatus.new(line_status_params)

    respond_to do |format|
      if @line_status.save
        format.html { redirect_to @line_status, notice: 'Line status was successfully created.' }
        format.json { render :show, status: :created, location: @line_status }
      else
        format.html { render :new }
        format.json { render json: @line_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_statuses/1
  # PATCH/PUT /line_statuses/1.json
  def update
    respond_to do |format|
      if @line_status.update(line_status_params)
        format.html { redirect_to @line_status, notice: 'Line status was successfully updated.' }
        format.json { render :show, status: :ok, location: @line_status }
      else
        format.html { render :edit }
        format.json { render json: @line_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_statuses/1
  # DELETE /line_statuses/1.json
  def destroy
    @line_status.destroy
    respond_to do |format|
      format.html { redirect_to line_statuses_url, notice: 'Line status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_status
      @line_status = LineStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_status_params
      params.require(:line_status).permit(:submit_date, :status, :restaurant_id)
    end
end
