class CarrierRecruitmentMailer < ActionMailer::Base

  def new_recruit(recruit)
    @carrier_recruitment = recruit
    mail(to: CARRIER_RECRUITMENT_RECIPIENT, 
         subject: "[Carrier Recruitment] New Recruit: #{recruit.full_name}")
  end

  def confirmation(recruit)
    @carrier_recruitment = recruit
    mail(from: "Gannett Newspapers <dnrespond@gannett.com>",
         to: "#{recruit.full_name} <#{recruit.email}>",
         subject: "We have received your submission!")
  end
end
