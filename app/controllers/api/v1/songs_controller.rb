require "mp3info"
class Api::V1::SongsController < Api::V1::BaseController
  before_action :set_song, only: [:update, :show, :destroy, :upload_audio_file, :upload_cert_file, :upload_licence_file]

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
  #   @api_v1_song = Song.new(api_v1_song_params)
    # respond_to do |format|
    #   if @api_v1_song.save
    #     format.html { redirect_to @api_v1_song, notice: 'Song was successfully created.' }
    #     format.json { render :show, status: :created, location: @api_v1_song }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @api_v1_song.errors, status: :unprocessable_entity }
    #   end
    # end
  # end

  # POST /api/v1/upsong.json?id=9723
  # curl http://0.0.0.0:3050/api/v1/upsong\?id\=9723 -F "audio_file=@/Users/suzhen/Music/网易云音乐/suzhen_test.mp3" -v
  def upload_audio_file
    @song.audio_file = params["audio_file"]
    path = Rails.root.join('public').to_s + @song.audio_file.to_s
    @song.fill_out_info_from_file(path)
    respond_to do |format|
      if @song.save
        format.json { render :show, status: :ok, location: @api_v1_song }
      else
        format.json { render json: @api_v1_song.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /api/v1/upcert.json?id=478
  # curl http://0.0.0.0:3050/api/v1/upcert\?id\=478 -F "composer_cert=@/Users/suzhen/Desktop/ESLPod_0001_Guide.pdf" -v
  # curl http://0.0.0.0:3050/api/v1/upcert\?id\=478 -F "lyricist_cert=@/Users/suzhen/Desktop/ESLPod_0001_Guide.pdf" -v
  # curl http://0.0.0.0:3050/api/v1/upcert\?id\=478 -F "performer_cert=@/Users/suzhen/Desktop/ESLPod_0001_Guide.pdf" -v
  # curl http://0.0.0.0:3050/api/v1/upcert\?id\=478 -F "producer_cert=@/Users/suzhen/Desktop/ESLPod_0001_Guide.pdf" -v
  def upload_cert_file
    if params["composer_cert"].present?
        @song.composer_cert = params["composer_cert"]
    end
    if params["lyricist_cert"].present?
        @song.lyricist_cert = params["lyricist_cert"]
    end
    if params["performer_cert"].present?
        @song.performer_cert = params["performer_cert"]
    end
    if params["producer_cert"].present?
        @song.producer_cert = params["producer_cert"]
    end
    respond_to do |format|
      if @song.save
        format.json { render :show, status: :ok, location: @api_v1_song }
      else
        format.json { render json: @api_v1_song.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /api/v1/uplicence.json?id=9723
  # curl http://0.0.0.0:3050/api/v1/uplicence\?id\=478 -F "licence=@/Users/suzhen/Desktop/ESLPod_0001_Guide.pdf" -v
  def upload_licence_file
    @song.licence = params["licence"]
    respond_to do |format|
      if @song.save
        format.json { render :show, status: :ok, location: @api_v1_song }
      else
        format.json { render json: @api_v1_song.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/v1/songs/1
  # PATCH/PUT /api/v1/songs/1.json
  def update
    song_params = {}
    artist_ids = []
    album_ids = ""
    isbn = ""
    album_release_date = ""
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

    if api_v1_song_params[:ISBN].present?
      isbn = api_v1_song_params[:ISBN]
      excepts << "ISBN"
    end

    if api_v1_song_params[:album_release_date].present?
      album_release_date = api_v1_song_params[:album_release_date]
      excepts << "album_release_date"
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

    if song_params[:genre].present?
      @genre = Genre.find_by(:chinese_name=>song_params[:genre])
      song_params[:genre] = @genre.code
    end
    
    if !song_params[:lyric_copies_attributes].nil?
      @song.lyric_copies.destroy_all
    end

    if !song_params[:melody_copies_attributes].nil?
      @song.melody_copies.destroy_all
    end

    if !song_params[:producer_copies_attributes].nil?
      @song.producer_copies.destroy_all
    end
    
    if !song_params[:recording_copies_attributes].nil?
      @song.recording_copies.destroy_all
    end


    respond_to do |format|
      if isbn.present?
        @album = @song.albums.first
        @album.update(:ISBN => isbn)
        @album.update(:release_date => album_release_date)
      end
      if @song.update(song_params)
        format.json { render :show, status: :ok, location: @api_v1_song }
      else
        format.json { render json: @api_v1_song.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/songs/1
  # DELETE /api/v1/songs/1.json
  def destroy
    @song.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
      @song = Song.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_song_params
      params.fetch(:song, {}).permit(:tag_list, :genre, :composers, :lyricists, :ISRC,
                                     :ownership, :duration, :release_date, :lyrics, :title,
                                     :record_company, :publisher, :library_name, :language, :producer, 
                                     :recording_room, :mixer, :designer, :ar, :UPC, :arranger, :business,
                                     melody_copies_attributes: [:name, :share, :begin_date, :end_date, :district, :agreement_number],
                                     lyric_copies_attributes: [:name, :share, :begin_date, :end_date, :district, :agreement_number],
                                     producer_copies_attributes: [:name, :share, :begin_date, :end_date, :district, :agreement_number],
                                     recording_copies_attributes: [:name, :share, :begin_date, :end_date, :district, :agreement_number],
                                     other_info_attributes: [:publish_platform, :priority, :remark]).tap do |whitelisted|
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
        whitelisted[:ISBN] = params[:ISBN] if params[:ISBN].present?
        whitelisted[:album_release_date] = params[:album_release_date] if params[:album_release_date].present?
      end
    end
end
