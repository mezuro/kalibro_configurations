class InformationController < ApplicationController
  def data
    data = Information.data

    respond_to do |format|
      format.json { render json: data }
    end
  end
end
