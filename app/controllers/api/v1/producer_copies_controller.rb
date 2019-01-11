class Api::V1::ProducerCopiesController < ApplicationController
    before_action :set_song, only: [:create, :update, :destroy]
    before_action :set_producer_copy, only: [:update, :destroy]

    # POST /api/v1/songs/:song_id/producer_copies
    def create
        @producer_copy = ProducerCopy.new(api_v1_song_producer_copy_params)
        @song.producer_copies << @producer_copy
        respond_to do |format|
            if @song.save
                format.json { render :show, status: :created, location: @api_v1_song_producer_copy }
            else
                format.json { render json: @song.errors, status: :unprocessable_entity }
            end
        end
    end

    # POST /api/v1/songs/:song_id/producer_copies/:id.json
    def update
        respond_to do |format|
            if @producer_copy.update(api_v1_song_producer_copy_params)
              format.json { render :show, status: :ok, location: @api_v1_playlist }
            else
              format.json { render json: @playlist.errors, status: :unprocessable_entity }
            end
        end
    end 

    # DELETE /api/v1/songs/:song_id/producer_copies/:id.json
    def destroy
        @producer_copy.destroy
        respond_to do |format|
          format.json { head :no_content }
        end
    end 

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_song
        @song = Song.find(params[:song_id])
    end

    def set_producer_copy
        @producer_copy = @song.producer_copies.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_song_producer_copy_params
        params.fetch(:producer_copy, {}).permit(:name, :share, :begin_date, :end_date, :disctrict, :agreement_number)
    end
end
