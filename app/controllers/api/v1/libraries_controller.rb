class Api::V1::LibrariesController < ApplicationController
  before_action :set_library, only: [:show, :update, :destroy]

  # POST /api/v1/libraries
  # POST /api/v1/libraries.json
  def create
    @library = Library.new(library_params)
    respond_to do |format|
      if @library.save
        if params[:song_ids].present?
          songs = []
          params[:song_ids].each{|song_id| songs << Song.find_by(:id=>song_id)}
          songs = songs.compact.reject(&:nil?)
          songs.each{|song| song.library_assignments.create!(:library_id=>@library.id) }
        end
        
        if params[:demo_ids].present?
          demos = []
          params[:demo_ids].map{|demo_id| demos << Demo.find_by(:id=>demo_id) }
          demos.each{|demo| demo.library_assignments.create!(:library_id=>@library.id) }
        end

        format.json { render :show, status: :created, location: @api_v1_library }
      else
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /api/v1/libraries/1
  # GET /api/v1/libraries/1.json
  def show
    respond_to do |format|
        format.json { render :show, status: :ok, location: @api_v1_library }
    end
  end

  # PATCH/PUT /api/v1/libraries/1
  # PATCH/PUT /api/v1/libraries/1.json
  def update
    respond_to do |format|
      if @library.update(library_params)
        @library.library_assignments.destroy_all
        if params[:song_ids].present?
          songs = []
          params[:song_ids].each{|song_id| songs << Song.find_by(:id=>song_id)}
          songs = songs.compact.reject(&:nil?)
          songs.each do |song| 
            song.library_assignments.create!(:library_id=>@library.id)
          end
        end
        
        if params[:demo_ids].present?
          demos = []
          params[:demo_ids].map{|demo_id| demos << Demo.find_by(:id=>demo_id) }
          demos.each do |demo| 
            demo.library_assignments.create!(:library_id=>@library.id)
          end
        end
        format.json { render :show, status: :ok, location: @api_v1_library }
      else
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/libraries/1
  # DELETE /api/v1/libraries/1.json
  def destroy
    @library.library_assignments.destroy_all
    @library.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      @library = Library.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def library_params
      params.fetch(:library, {}).permit(:name)
    end
end
