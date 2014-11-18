class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:start_timer, :stop_timer, :show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /time_entries
  # GET /time_entries.json
  def index
    @time_entries = TimeEntry.all.includes(task: :project).order("time_entries.id")
    @total = TimeEntry.new
    @total.seconds = @time_entries.map(&:elapsed_time).reduce(&:+)
    @time_entry = TimeEntry.new
  end

  # GET /time_entries/1
  # GET /time_entries/1.json
  def show
  end

  # GET /time_entries/new
  def new
    @time_entry = TimeEntry.new
    @tasks = Task.all.includes(project: :customer).order("customers.name, projects.name")
  end

  # GET /time_entries/1/edit
  def edit
    @tasks = Task.all.includes(project: :customer).order("customers.name, projects.name")
  end

  def start_timer
    @time_entry.start! and redirect_to :back
  end

  def stop_timer
    @time_entry.stop! and redirect_to :back
  end

  # POST /time_entries
  # POST /time_entries.json
  def create
    @time_entry = TimeEntry.new(time_entry_params)

    respond_to do |format|
      if @time_entry.save
        format.html { redirect_to @time_entry, notice: 'Time entry was successfully created.' }
        format.json { render :show, status: :created, location: @time_entry }
      else
        format.html { render :new }
        format.json { render json: @time_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /time_entries/1
  # PATCH/PUT /time_entries/1.json
  def update
    respond_to do |format|
      if @time_entry.update(time_entry_params)
        format.html { redirect_to @time_entry, notice: 'Time entry was successfully updated.' }
        format.json { render :show, status: :ok, location: @time_entry }
      else
        format.html { render :edit }
        format.json { render json: @time_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /time_entries/get_times.json
  def get_times
    entries = TimeEntry.where(user_id: current_user.id).all
    @total = TimeEntry.new
    @total.seconds = entries.map(&:elapsed_time).reduce(&:+)
    times = entries.each_with_object({}) { |entry, hash| hash[entry.id] = entry.display_time }
    times["total"] = @total.display_time
    render json: times, status: :ok
  end

  # DELETE /time_entries/1
  # DELETE /time_entries/1.json
  def destroy
    @time_entry.destroy
    respond_to do |format|
      format.html { redirect_to time_entries_url, notice: 'Time entry was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  require 'csv'

  def export_csv
    @time_entries = TimeEntry.all.includes(task: :project).order("time_entries.id")
    @total = TimeEntry.new
    @total.seconds = @time_entries.map(&:elapsed_time).reduce(&:+)

    csv_output = CSV.generate do |csv|
      csv << ["Task", "User", "Description", "Time", "Worked on"]
      @time_entries.each do |entry|
        csv << [entry.task.fully_qualified_name, entry.user.full_name, entry.description, entry.display_time, entry.worked_on]
      end
      csv << ["Total", "", "", @total.display_time,""]
    end

    render text: csv_output.inspect
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_entry
      @time_entry = TimeEntry.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def time_entry_params
      params.require(:time_entry).permit(:user_id, :task_id, :description, :seconds, :worked_on)
    end
end
