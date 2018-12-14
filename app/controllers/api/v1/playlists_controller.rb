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
      if @playlist.code == playlist_params[:shared_code]
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
        format.json { render :show, status: :ok, location: @api_v1_playlist }
      else
        format.json { render json: @playlist.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/playlists/1
  # DELETE /api/v1/playlists/1.json
  def destroy
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
      params.fetch(:playlist, {}).permit(:name, :introduction).tap do |whitelisted|
        whitelisted[:song_ids] = params[:song_ids] if params[:song_ids]
        whitelisted[:shared_code] = params[:shared_code] if params[:shared_code]
      end
    end
end
