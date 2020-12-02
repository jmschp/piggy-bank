class FamiliesController < ApplicationController

  private

  def family_params
    params.require(:family).permit(:name)
  end
end
