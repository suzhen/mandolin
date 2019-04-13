class Api::V1::ContractsController < ApplicationController
  before_action :set_contract, only: [:show, :update, :destroy]

  # POST /api/v1/contracts
  # POST /api/v1/contracts.json
  def create
    @contract = Contract.new(contract_params)
    respond_to do |format|
      if @contract.save
        if params[:song_ids]
          songs = []
          params[:song_ids].each{|song_id| songs << Song.find_by(:id=>song_id)}
          songs = songs.compact.reject(&:nil?)
          songs.each{|song| song.contract_assignments.create!(:contract_id=>@contract.id) }
        end
        
        if params[:demo_ids]
          demos = []
          params[:demo_ids].map{|demo_id| demos << Demo.find_by(:id=>demo_id) }
          demos.each{|demo| demo.contract_assignments.create!(:contract_id=>@contract.id) }
        end

        if params[:library_ids]
            libraries = []
            params[:library_ids].map{|library_id| libraries << Library.find_by(:id=>library_id) }
            libraries.each{|library| library.contract_assignments.create!(:contract_id=>@contract.id) }
        end

        format.json { render :show, status: :created, location: @api_v1_contract }
      else
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /api/v1/contracts/1
  # GET /api/v1/contracts/1.json
  def show
    respond_to do |format|
        format.json { render :show, status: :ok, location: @api_v1_contract }
    end
  end

  # PATCH/PUT /api/v1/contracts/1
  # PATCH/PUT /api/v1/contracts/1.json
  def update
    respond_to do |format|
      if @contract.update(contract_params)
        @contract.contract_assignments.destroy_all
        if params[:song_ids]
          songs = []
          params[:song_ids].each{|song_id| songs << Song.find_by(:id=>song_id)}
          songs = songs.compact.reject(&:nil?)
          songs.each do |song| 
            song.contract_assignments.create!(:contract_id=>@contract.id)
          end
        end
        
        if params[:demo_ids]
          demos = []
          params[:demo_ids].map{|demo_id| demos << Demo.find_by(:id=>demo_id) }
          demos.each do |demo| 
            demo.contract_assignments.create!(:contract_id=>@contract.id)
          end
        end

        if params[:library_ids]
            libraries = []
            params[:library_ids].map{|library_id| libraries << Library.find_by(:id=>library_id) }
            demos.each do |demo| 
                demo.contract_assignments.create!(:contract_id=>@contract.id)
            end
        end
        format.json { render :show, status: :ok, location: @api_v1_contract }
      else
        format.json { render json: @contract.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/contracts/1
  # DELETE /api/v1/contracts/1.json
  def destroy
    @contract.contract_assignments.destroy_all
    @contract.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contract_params
      params.fetch(:contract, {}).permit(:auth_party, :op_type, :auth_fee, :auth_duration, :payment_type, :auth_platform, :auth_location, :op_content, :song_count, :list_type, :auth_type, :is_shared, :auth_bussiness, :extend_terms, :contract_type, :label)
    end
end
