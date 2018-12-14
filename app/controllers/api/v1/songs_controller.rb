class Api::V1::SongsController < Api::V1::BaseController
  before_action :set_song, only: [:update, :show]

  # # GET /api/v1/songs
  # # GET /api/v1/songs.json
  # def index
  #   @api_v1_songs = Song.all
  # end

  # # GET /api/v1/songs/1
  # # GET /api/v1/songs/1.json
  # def show
  # end

  # # GET /api/v1/songs/new
  # def new
  #   @api_v1_song = Song.new
  # end

  # # GET /api/v1/songs/1/edit
  # def edit
  # end

  # # POST /api/v1/songs
  # # POST /api/v1/songs.json
  # def create
  #   @api_v1_song = Api::V1::Song.new(api_v1_song_params)

  #   respond_to do |format|
  #     if @api_v1_song.save
  #       format.html { redirect_to @api_v1_song, notice: 'Song was successfully created.' }
  #       format.json { render :show, status: :created, location: @api_v1_song }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @api_v1_song.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /api/v1/songs/1
  # PATCH/PUT /api/v1/songs/1.json
  def update
    respond_to do |format|
      if @song.update(api_v1_song_params)
        format.json { render :show, status: :ok, location: @api_v1_song }
      else
        format.json { render json: @api_v1_song.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /api/v1/songs/1
  # # DELETE /api/v1/songs/1.json
  # def destroy
  #   @api_v1_song.destroy
  #   respond_to do |format|
  #     format.html { redirect_to api_v1_songs_url, notice: 'Song was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_song_params
      params.fetch(:song, {}).permit(:tag_list,:genre,:composers,:lyricists,:ISRC,:ownership,:duration,:release_date,:lyrics)
      #.tap do |whitelisted|
        # whitelisted[:artists] = params[:artists] if params[:artists]
        # whitelisted[:shared_code] = params[:shared_code] if params[:shared_code]
      # end
    end
end
