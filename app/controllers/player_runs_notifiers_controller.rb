class PlayerRunsNotifiersController < ApplicationController
  before_action :set_player_runs_notifier, only: %i[ show edit update destroy ]

  # GET /player_runs_notifiers or /player_runs_notifiers.json
  def index
    @player_runs_notifiers = PlayerRunsNotifier.all
  end

  # GET /player_runs_notifiers/1 or /player_runs_notifiers/1.json
  def show
  end

  # GET /player_runs_notifiers/new
  def new
    @player_runs_notifier = PlayerRunsNotifier.new
  end

  # GET /player_runs_notifiers/1/edit
  def edit
  end

  # POST /player_runs_notifiers or /player_runs_notifiers.json
  def create
    @player_runs_notifier = PlayerRunsNotifier.new(player_runs_notifier_params)

    respond_to do |format|
      if @player_runs_notifier.save
        format.html { redirect_to @player_runs_notifier, notice: "Player runs notifier was successfully created." }
        format.json { render :show, status: :created, location: @player_runs_notifier }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @player_runs_notifier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /player_runs_notifiers/1 or /player_runs_notifiers/1.json
  def update
    respond_to do |format|
      if @player_runs_notifier.update(player_runs_notifier_params)
        format.html { redirect_to @player_runs_notifier, notice: "Player runs notifier was successfully updated." }
        format.json { render :show, status: :ok, location: @player_runs_notifier }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @player_runs_notifier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /player_runs_notifiers/1 or /player_runs_notifiers/1.json
  def destroy
    @player_runs_notifier.destroy
    respond_to do |format|
      format.html { redirect_to player_runs_notifiers_url, notice: "Player runs notifier was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player_runs_notifier
      @player_runs_notifier = PlayerRunsNotifier.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def player_runs_notifier_params
      params.require(:player_runs_notifier).permit(:user_id, :team_squad_member_id, :runs)
    end
end
