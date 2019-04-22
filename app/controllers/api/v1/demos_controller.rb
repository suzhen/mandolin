class Api::V1::DemosController < ApplicationController
  before_action :set_demo, only: [:update, :show, :destroy]
    
  # PATCH/PUT /api/v1/demos/1
  # PATCH/PUT /api/v1/demos/1.json
  def update
    demo_params = {}
    hold_by_ids = []
    cut_by_ids = []
    writer_ids = []
    pitched_artist_ids = []
    excepts = []
    if api_v1_demo_params[:artist_names].present?
      new_names = []
      api_v1_demo_params[:artist_names].map{|obj| new_names+=obj[:names] }
      new_names.uniq!
      new_names.map!{|name| Artist.find_or_create_by(:name => name)}
    
      api_v1_demo_params[:artist_names].each do |obj|
          if obj[:related_type] == "HOLD"
            obj[:names].each do |name|
              hold_by_ids << (new_names.detect {|artist| artist.name == name}).id
            end
          end
          if obj[:related_type] == "CUT"
            obj[:names].each do |name|
              cut_by_ids << (new_names.detect {|artist| artist.name == name}).id
            end
          end
          if obj[:related_type] == "WRITER"
            obj[:names].each do |name|
              writer_ids << (new_names.detect {|artist| artist.name == name}).id
            end
          end
          if obj[:related_type] == "PITCHED"
            obj[:names].each do |name|
              pitched_artist_ids << (new_names.detect {|artist| artist.name == name}).id
            end
          end
      end
      excepts << "artist_names"
    end
    
    if api_v1_demo_params[:hold_by_ids].present? 
      hold_by_ids = hold_by_ids + api_v1_demo_params[:hold_by_ids]
      excepts << "hold_by_ids"
    end

    if api_v1_demo_params[:cut_by_ids].present? 
      cut_by_ids = cut_by_ids + api_v1_demo_params[:cut_by_ids]
      excepts << "cut_by_ids"
    end

    if api_v1_demo_params[:writer_ids].present? 
      writer_ids = writer_ids + api_v1_demo_params[:writer_ids]
      excepts << "writer_ids"
    end

    if api_v1_demo_params[:pitched_artist_ids].present? 
      pitched_artist_ids = pitched_artist_ids + api_v1_demo_params[:pitched_artist_ids]
      excepts << "pitched_artist_ids"
    end

    demo_params = api_v1_demo_params.except(:temp)
    excepts.map(&:to_sym).each do |e| 
      demo_params = demo_params.except(e)
    end

    respond_to do |format|
      if @demo.update(demo_params)
        @demo.build_hold_bies(hold_by_ids)
        @demo.build_cut_bies(cut_by_ids)
        @demo.build_writers(writer_ids)
        @demo.build_pitched_artists(pitched_artist_ids)
        if @demo.save
          format.json { render :show, status: :ok, location: @api_v1_demo }
        else
          format.json { render json: @api_v1_demo.errors, status: :unprocessable_entity }
        end
      else
        format.json { render json: @api_v1_demo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /api/v1/demos/1
  # DELETE /api/v1/demos/1.json
  def destroy
    @demo.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  # POST /api/v1/updemo.json?id=1
  # POST /api/v1/updemo.json?id=1
  # curl http://0.0.0.0:3050/api/v1/updemo\?id\=1 -F "audio_file=@/Users/suzhen/Music/网易云音乐/suzhen_test.mp3" -v
  def upload_audio_file
    @api_v1_demo = Demo.new
    @api_v1_demo.audio_file = params["audio_file"]
    path = Rails.root.join('public').to_s + @api_v1_demo.audio_file.to_s
    path = path.gsub(File.basename(path, ".*"), File.basename(params["audio_file"].original_filename, ".*"))
    logger.info "************"
    logger.info path
    @api_v1_demo.fill_out_info_from_file(path)
    respond_to do |format|
      if @api_v1_demo.save
        format.json { render :show, status: :ok, location: @api_v1_demo}
      else
        logger.info "&&&&&&&"
        logger.info @api_v1_demo.errors
        format.json { render json: @api_v1_demo.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_demo
      @demo = Demo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_demo_params
        params.fetch(:demo, {}).permit(:title, :tag_list, :genre, :source, :writers, :year,
                                     :mfd, :notes, :bpm, :pitched_artists, :hold_by, :cut_by).tap do |whitelisted|
            if params[:genre].present?
                whitelisted[:genre] = Genre.find_by(:chinese_name=>params[:genre]).code
            end
            new_artist_names = []
            # HOLD_BY
            if params[:hold_bies].present?
              ids = params[:hold_bies].map{|obj| obj["id"]}.compact
              new_names = params[:hold_bies].map{|obj| obj["name"] if obj["id"].blank? }.compact
              if ids.present?
                whitelisted[:hold_by_ids] = ids
              end
              if new_names.present?
                new_artist_names << {related_type: "HOLD", names: new_names}
              end
            end
            # CUT_BY
            if params[:cut_bies].present?
              ids = params[:cut_bies].map{|obj| obj["id"]}.compact
              new_names = params[:cut_bies].map{|obj| obj["name"] if obj["id"].blank? }.compact
              if ids.present?
                whitelisted[:cut_by_ids] = ids
              end
              if new_names.present?
                new_artist_names << {related_type: "CUT", names: new_names}
              end
            end
            # WRITER
            if params[:writers].present?
              ids = params[:writers].map{|obj| obj["id"]}.compact
              new_names = params[:writers].map{|obj| obj["name"] if obj["id"].blank? }.compact
              if ids.present?
                whitelisted[:writer_ids] = ids
              end
              if new_names.present?
                new_artist_names << {related_type: "WRITER", names: new_names}
              end
            end
            # PITCHED
            if params[:pitched_artists].present?
              ids = params[:pitched_artists].map{|obj| obj["id"]}.compact
              new_names = params[:pitched_artists].map{|obj| obj["name"] if obj["id"].blank? }.compact
              if ids.present?
                whitelisted[:pitched_artist_ids] = ids
              end
              if new_names.present?
                new_artist_names << {related_type: "PITCHED", names: new_names}
              end
            end
            # 新的
            unless new_artist_names.empty?
              whitelisted[:artist_names] = new_artist_names
            end 
        end                                
    end
end
