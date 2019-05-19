class CarrierRecruitmentsController < ApplicationController

  def new
    @carrier_recruitment = CarrierRecruitment.new
    @carrier_recruitment.how_did_hear = 'digitalad' if params[:digitalad] == 'true'
  end

  def create
    @carrier_recruitment = CarrierRecruitment.new(carrier_recruitment_params)
    if @carrier_recruitment.save
      redirect_to root_path, notice: 'Your information was successfully submitted. '+
                                     'You should receive an email confirmation shortly.'
    else
      render action: :new
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def carrier_recruitment_params
    params.require(:carrier_recruitment).permit(
        :first_name, :last_name, :address_line, :city, :state, :zip_code, :phone_number, :phone_number2,
        :email, :paper_to_deliver, :best_time_to_reach, :how_did_hear, :referral_code, :other_source, :preferred_language
      )
  end
end
