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
    song_params = {}
    artist_ids = []
    album_ids = ""
    excepts = []
    if api_v1_song_params[:artist_names].present?
      artist_ids = api_v1_song_params[:artist_names].map{|name| Artist.find_or_create_by(:name => name).id}
      excepts << "artist_names"
      excepts << "first_artist_id"
    end
    
    if api_v1_song_params[:artist_ids].present? 
      if api_v1_song_params[:first_artist_id] 
        artist_ids = api_v1_song_params[:artist_ids] + artist_ids
      else 
        artist_ids = artist_ids + api_v1_song_params[:artist_ids]
      end
      excepts << "artist_ids"
      excepts << "first_artist_id"
    end
    
    if api_v1_song_params[:album_names].present?
      @album = Album.create(:title => api_v1_song_params[:album_names], :artist_id => artist_ids.present? ? artist_ids[0]: @major_artist.id)
      @album.songs << @song
      @album.save
      album_ids = @album.id
      excepts << "album_names"
    end

    song_params = api_v1_song_params.except(:temp)
    excepts.map(&:to_sym).each do |e| 
      song_params = song_params.except(e)
    end

    if artist_ids.present?
      song_params[:artist_ids] = artist_ids
    end

    if album_ids.present?
      song_params[:album_ids] = album_ids
    end
    
    respond_to do |format|
      if @song.update(song_params)
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
      params.fetch(:song, {}).permit(:tag_list, :genre, :composers, :lyricists, :ISRC,
                                     :ownership, :duration, :release_date, :lyrics).tap do |whitelisted|
        if params[:artists].present?
          ids = params[:artists].map{|obj| obj["id"]}.compact
          new_names = params[:artists].map{|obj| obj["name"] if obj["id"].blank? }.compact
          if ids.present?
            whitelisted[:artist_ids] = ids
          end
          if new_names.present?
            whitelisted[:artist_names] = new_names
          end
          whitelisted[:first_artist_id] = (params[:artists].first)["id"]
        end
        if params[:album].present?
          if params[:album][:id].present?
            whitelisted[:album_ids] = params[:album][:id]
          end
          if params[:album][:id].blank? && params[:album][:name].present?
            whitelisted[:album_names] = params[:album][:name]
          end
        end
      end
    end
end
