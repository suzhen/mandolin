class Api::V1::LyricCopiesController < ApplicationController
    before_action :set_song, only: [:create, :update, :destroy]
    before_action :set_lyric_copy, only: [:update, :destroy]

    # POST /api/v1/songs/:song_id/lyric_copies
    def create
        @lyric_copy = LyricCopy.new(api_v1_song_lyric_copy_params)
        @song.lyric_copies << @lyric_copy
        respond_to do |format|
            if @song.save
                format.json { render :show, status: :created, location: @api_v1_song_lyric_copy }
            else
                format.json { render json: @song.errors, status: :unprocessable_entity }
            end
        end
    end

    # POST /api/v1/songs/:song_id/lyric_copies/:id.json
    def update
        respond_to do |format|
            if @lyric_copy.update(api_v1_song_lyric_copy_params)
              format.json { render :show, status: :ok, location: @api_v1_playlist }
            else
              format.json { render json: @playlist.errors, status: :unprocessable_entity }
            end
        end
    end 

    # DELETE /api/v1/songs/:song_id/lyric_copies/:id.json
    def destroy
        @lyric_copy.destroy
        respond_to do |format|
          format.json { head :no_content }
        end
    end 

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
        @song = Song.find(params[:song_id])
    end

    def set_lyric_copy
        @lyric_copy = @song.lyric_copies.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_song_lyric_copy_params
        params.fetch(:lyric_copy, {}).permit(:name, :share, :rights_type, :end_date, :disctrict, :agreement_number)
    end
end
