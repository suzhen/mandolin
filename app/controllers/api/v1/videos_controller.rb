class Api::V1::VideosController < Api::V1::BaseController
  before_action :set_video, only: [:update, :show, :destroy, :upload_media_file]

  # # GET /api/v1/videos
  # # GET /api/v1/videos.json
  # def index
  #   @api_v1_videos = Video.all
  # end

  # # GET /api/v1/videos/1
  # # GET /api/v1/videos/1.json
  # def show
  # end

  # # GET /api/v1/videos/new
  # def new
  #   @api_v1_video = Video.new
  # end

  # # GET /api/v1/videos/1/edit
  # def edit
  # end

  # POST /api/v1/videos
  # POST /api/v1/videos.json
  def create
    @video = Video.new(api_v1_video_params)
    respond_to do |format|
      if @video.save
        format.json { render :show, status: :created, location: @api_v1_video }
      else
        format.json { render json: @api_v1_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # POST /api/v1/upvideo.json?id=9723
  # curl http://0.0.0.0:3050/api/v1/upvideo\?id\=9723 -F "media_file=@/Users/suzhen/Music/网易云音乐/suzhen_test.mp3" -v
  def upload_media_file
    @video.media_file = params["media_file"]
    respond_to do |format|
      if @video.save
        format.json { render :show, status: :ok, location: @api_v1_video }
      else
        format.json { render json: @api_v1_video.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /api/v1/videos/1
  # PATCH/PUT /api/v1/videos/1.json
  def update
    respond_to do |format|
      if @video.update(api_v1_video_params)
        format.json { render :show, status: :ok, location: @api_v1_video }
      else
        format.json { render json: @api_v1_video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/videos/1
  # DELETE /api/v1/videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_video_params
      params.fetch(:video, {}).permit(:version, :grouping, :copyright, :producer, :release_date,:recording_date,
                                      :duration, :district, :definition, :copyright_company,
                                      :origin_copyright, :ISRC, :priority, :song_id)
    end
end



