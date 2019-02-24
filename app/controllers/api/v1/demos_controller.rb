class Api::V1::DemosController < ApplicationController
  before_action :set_demo, only: [:update, :show]
  # PATCH/PUT /api/v1/demos/1
  # PATCH/PUT /api/v1/demos/1.json
  def update
    puts api_v1_demo_params[:genres]
    respond_to do |format|
      if @demo.update(api_v1_demo_params)
        format.json { render :show, status: :ok, location: @api_v1_demo }
      else
        format.json { render json: @api_v1_demo.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /api/v1/demos/1
  # # DELETE /api/v1/demos/1.json
  # def destroy
  #   @api_v1_demo.destroy
  #   respond_to do |format|
  #     format.html { redirect_to api_v1_demos_url, notice: 'demo was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_demo
      @demo = Demo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_demo_params
        params.fetch(:demo, {}).permit(:title, :tag_list, :genres, :source, :writers, :year,
                                     :mfd, :notes, :bpm, :pitched_artists, :hold_by, :cut_by).tap do |whitelisted|
            if params[:genres].present?
                whitelisted[:genres] = params[:genres].split(",").map{|cg| Genre.find_by(:chinese_name=>cg).code}.join(",")  
            end
        end                                
    end
end
