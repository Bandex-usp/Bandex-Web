class LineStatusesController < ApplicationController
  before_action :set_line_status, only: [:show, :edit, :update, :destroy]

  def line_status
    @rest_count = Restaurant.count
    @lastSubmitDate = Array.new(@rest_count) { DateTime.new }
    weight_total = Array.new(@rest_count, 0)
    @currentLineStatus = Array.new(@rest_count, 0)

    start_time = 45.minutes.ago
    end_time = Time.current

    line_statuses = LineStatus.where('submit_date BETWEEN ? AND ?', start_time, end_time).all

    line_statuses.each do |line_status|
        restaurant_id = line_status['restaurant_id'] - 1
        status = line_status['status']
        submit_date = line_status['submit_date'].in_time_zone("Brasilia")
        weight = calculate_weight(end_time - submit_date)
        weight_total[restaurant_id] += weight
        @currentLineStatus[restaurant_id] += weight * status.to_f
        @lastSubmitDate[restaurant_id] = submit_date if submit_date > @lastSubmitDate[restaurant_id]
    end

    (0...@rest_count).each do |id|
        if (weight_total[id] != 0)
            @currentLineStatus[id] = @currentLineStatus[id] / weight_total[id]
        end
    end
  end

  def calculate_weight interval
    interval = interval / 45.minutes
    Math.exp(-(interval**2)*6) * 0.9 + 0.1
  end

  # GET /line_statuses
  # GET /line_statuses.json
  def index
    @line_statuses = LineStatus.all.reverse_order
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
    start_time = Restaurant.openning(period(Time.current)) - 30.minutes
    end_time = Restaurant.closing(period(Time.current))
    # unless Time.current.between?(start_time, end_time)
    #   render :nothing => true, :status => 403, :content_type => 'application/json'
    #   return
    # end
    params = line_status_params
    params['restaurant_id'] = params['restaurant_id'].to_i + 1
    @line_status = LineStatus.new(params)

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
