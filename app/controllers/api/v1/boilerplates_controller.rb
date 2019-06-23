class Api::V1::BoilerplatesController < Api::V1::BaseController
  before_action :set_boilerplate, only: [:update, :destroy]

  # POST /api/v1/boilerplates
  # POST /api/v1/boilerplates.json
  def create
    @current_user = User.find_by_id(session[:current_user_id])
    @boilerplate = Boilerplate.new(boilerplate_params)
    @boilerplate.loader = @current_user
    respond_to do |format|
      if @boilerplate.save
        format.json { render :show, status: :created, location: @api_v1_boilerplate }
      else
        format.json { render json: @boilerplate.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /api/v1/boilerplates/1
  # GET /api/v1/boilerplates/1.json
  # def show
  #   respond_to do |format|
  #     if @boilerplate.code == boilerplate_params[:shared_code] || @boilerplate.cypher == boilerplate_params[:shared_code]
        
  #       @boilerplate.shared_field =  @boilerplate.code == boilerplate_params[:shared_code] ? "code" : "cypher"
  #       format.json { render :show, status: :ok, location: @api_v1_boilerplate }
  #     else
  #       format.json { render json: @boilerplate.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # POST /api/v1/upboilerplate.json?id=1
  # POST /api/v1/upboilerplate.json?id=1
  # curl http://0.0.0.0:3050/api/v1/upboilerplate\?id\=1 -F "boilerplate=@/Users/suzhen/Music/网易云音乐/suzhen_test.mp3" -v
  def upload_file
    if params[:id].present?
      set_boilerplate
    else
      @boilerplate = Boilerplate.new(:name=>"未命名模板")
    end
    @boilerplate.download = params["boilerplate"]
    respond_to do |format|
      if @boilerplate.save
        format.json { render :show, status: :ok, location: @api_v1_boilerplate}
      else
        format.json { render json: @boilerplate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /api/v1/boilerplates/1
  # PATCH/PUT /api/v1/boilerplates/1.json
  def update
    respond_to do |format|
      if @boilerplate.update(boilerplate_params)
        format.json { render :show, status: :ok, location: @api_v1_boilerplate }
      else
        format.json { render json: @boilerplate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/boilerplates/1
  # DELETE /api/v1/boilerplates/1.json
  def destroy
    @boilerplate.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_boilerplate
      @boilerplate = Boilerplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def boilerplate_params
      params.fetch(:boilerplate, {}).permit(:name)
    end
end
