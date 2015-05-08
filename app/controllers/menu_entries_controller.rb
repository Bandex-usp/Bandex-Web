class MenuEntriesController < ApplicationController
  before_action :set_menu_entry, only: [:show, :edit, :update, :destroy]

  # GET /menu_entries
  # GET /menu_entries.json
  def index
    set_restaurant if params[:restaurant_id] != nil
    if @restaurant != nil
      @menu_entries = @restaurant.menu_entries
    else
      @menu_entries = MenuEntry.all
    end
  end

  # GET /menu_entries/1
  # GET /menu_entries/1.json
  def show
  end

  # GET /menu_entries/new
  def new
    @menu_entry = MenuEntry.new
  end

  # GET /menu_entries/1/edit
  def edit
  end

  # POST /menu_entries
  # POST /menu_entries.json
  def create
    @menu_entry = MenuEntry.new(menu_entry_params)

    respond_to do |format|
      if @menu_entry.save
        format.html { redirect_to @menu_entry, notice: 'Menu entry was successfully created.' }
        format.json { render :show, status: :created, location: @menu_entry }
      else
        format.html { render :new }
        format.json { render json: @menu_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menu_entries/1
  # PATCH/PUT /menu_entries/1.json
  def update
    respond_to do |format|
      if @menu_entry.update(menu_entry_params)
        format.html { redirect_to @menu_entry, notice: 'Menu entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @menu_entry }
      else
        format.html { render :edit }
        format.json { render json: @menu_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_entries/1
  # DELETE /menu_entries/1.json
  def destroy
    @menu_entry.destroy
    respond_to do |format|
      format.html { redirect_to menu_entries_url, notice: 'Menu entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_entry
      @menu_entry = MenuEntry.find(params[:id])
    end

    def set_restaurant
      @restaurant = Restaurant.find(params[:restaurant_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_entry_params
      params.require(:menu_entry).permit(:entry_date, :period, :restaurant_id, :main, :meat, :second, :salad, :optional, :desert)
    end
end
