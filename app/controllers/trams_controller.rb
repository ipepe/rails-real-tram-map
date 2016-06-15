class TramsController < ApplicationController
  respond_to :html

  def index
    p = sanitize_index_params
    @trams = Tram.currently_running.to_a
    gon.trams = @trams
    respond_to do |format|
      format.html
      format.json { render json: {result: @trams.map(&:serialized_hash)} }
    end
  end

  private

  def sanitize_index_params
    params
  end
end
