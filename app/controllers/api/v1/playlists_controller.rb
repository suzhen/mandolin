class Api::V1::PlaylistsController < Api::V1::BaseController
  before_action :set_playlist, only: [:show, :update, :destroy]

  # POST /api/v1/playlists
  # POST /api/v1/playlists.json
  def create
    @current_user = User.find_by_id(session[:current_user_id])
    @playlist = Playlist.new(playlist_params)
    @playlist.creator = @current_user
    respond_to do |format|
      if @playlist.save
        if params[:song_ids]
          songs = []
          params[:song_ids].each{|song_id| songs << Song.find_by(:id=>song_id)}
          songs = songs.compact.reject(&:nil?)
          songs.each{|song| song.playlist_assignments.create!(:playlist_id=>@playlist.id) }
        end
        
        if params[:demo_ids]
          demos = []
          params[:demo_ids].map{|demo_id| demos << Demo.find_by(:id=>demo_id) }
          demos.each{|demo| demo.playlist_assignments.create!(:playlist_id=>@playlist.id) }
        end

        if params[:allow_download]
          @playlist.allow_download = nil
          @playlist.save
        end
        
        if params[:has_password]
          @playlist.has_password = nil
          @playlist.save
        end

        if params[:expire_at]
          @playlist.expire = DateTime.parse(params[:expire_at])
          @playlist.save
        end

        format.json { render :show, status: :created, location: @api_v1_playlist }
      else
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /api/v1/playlists/1
  # GET /api/v1/playlists/1.json
  def show
    respond_to do |format|
      if @playlist.expire && DateTime.now > @playlist.expire
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
      if @playlist.has_password.nil?
        format.json { render :show, status: :ok, location: @api_v1_playlist }
      end
      if @playlist.has_password && (@playlist.code == playlist_params[:shared_code] || @playlist.cypher == playlist_params[:shared_code]) 
        @playlist.shared_field =  @playlist.code == playlist_params[:shared_code] ? "code" : "cypher"
        format.json { render :show, status: :ok, location: @api_v1_playlist }
      else
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/v1/playlists/1
  # PATCH/PUT /api/v1/playlists/1.json
  def update
    respond_to do |format|
      if @playlist.update(playlist_params)
        @playlist.playlist_assignments.destroy_all
        if params[:song_ids]
          songs = []
          params[:song_ids].each{|song_id| songs << Song.find_by(:id=>song_id)}
          songs = songs.compact.reject(&:nil?)
          songs.each do |song| 
            song.playlist_assignments.create!(:playlist_id=>@playlist.id)
          end
        end
        
        if params[:demo_ids]
          demos = []
          params[:demo_ids].map{|demo_id| demos << Demo.find_by(:id=>demo_id) }
          demos.each do |demo| 
            demo.playlist_assignments.create!(:playlist_id=>@playlist.id)
          end
        end

        if params[:allow_download]
          @playlist.allow_download = params[:allow_download]=="1" ? 1 : nil
          @playlist.save
        end
        
        if params[:has_password]
          @playlist.has_password = params[:has_password]=="1" ? 1 : nil
          @playlist.save
        end

        if params[:expire_at]
          @playlist.expire = DateTime.parse(params[:expire_at])
          @playlist.save
        else
          @playlist.expire = nil
          @playlist.save
        end

        format.json { render :show, status: :ok, location: @api_v1_playlist }
      else
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/playlists/1
  # DELETE /api/v1/playlists/1.json
  def destroy
    @playlist.playlist_assignments.destroy_all
    @playlist.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_playlist
      @playlist = Playlist.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def playlist_params
      params.fetch(:playlist, {}).permit(:name, :introduction, :allow_download, :has_password).tap do |whitelisted|
        whitelisted[:shared_code] = params[:shared_code] if params[:shared_code]
      end
    end
end
