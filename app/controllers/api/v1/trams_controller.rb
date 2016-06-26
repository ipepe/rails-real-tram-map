class Api::V1::TramsController < ApplicationController
  respond_to :html

  def index
    p = sanitize_index_params
    @trams = Tram.currently_running(p).to_a
    gon.trams = @trams.map(&:serialized_hash)
    gon.user_text = I18n.t('user.your_position')
    respond_to do |format|
      format.html
      format.json { render json: {result: @trams.map(&:serialized_hash)} }
    end
  end

  def about
    @services = {
      dane_po_warszawsku: 'png',
      zarzad_transportu_miejskiego: 'jpg',
      leaflet: 'png',
      open_street_map: 'jpg',
      carto_db: 'png',
      tobiasahlin: 'jpg',
      font_awesome:'png',
      pjatk: 'png'
    }
  end

  private

  def sanitize_index_params
    {
        latitude: if params['center_latitude'].present? then params['center_latitude'].to_f else 52.23 end,
        logitude: if params['center_longitude'].present? then params['center_longitude'].to_f else 21.01 end,
        radius: if params['radius'].present? then params['radius'].to_f else 30 end,
        limit: if params['limit'].present? then params['limit'].to_i else 30 end
    }
  end
end
