class CarrierRecruitment
  include ActiveAttr::Model

  attribute :first_name,          type: String
  attribute :last_name,           type: String
  attribute :address_line,        type: String
  attribute :city,                type: String
  attribute :state,               type: String
  attribute :zip_code,            type: String
  attribute :phone_number,        type: String
  attribute :phone_number2,       type: String
  attribute :email,               type: String
  attribute :paper_to_deliver,    type: String
  attribute :best_time_to_reach,  type: String
  attribute :how_did_hear,        type: String
  attribute :referral_code,       type: String
  attribute :other_source,        type: String
  attribute :preferred_language,  type: String

  with_options presence: true do |v|
    v.validates :first_name,          length: {maximum: 25, allow_blank: true}
    v.validates :last_name,           length: {maximum: 25, allow_blank: true}
    v.validates :address_line,        length: {maximum: 50, allow_blank: true}
    v.validates :city,                length: {maximum: 40, allow_blank: true}
    v.validates :state,               length: {is: 2, allow_blank: true},
                                      inclusion: {within: States::LOOKUP.keys, allow_blank: true}
    v.validates :zip_code,            format: {with: /\A\d{5}(?:-\d{4})?\z/, allow_blank: true}
    v.validates :phone_number,        format: {with: /1?\W*([2-9][0-8][0-9])\W*([2-9][0-9]{2})\W*([0-9]{4})(\se?x?t?(\d*))?/, allow_blank: true}
    v.validates :email,               email: {allow_blank: true}
    v.validates :paper_to_deliver,    length: {maximum: 40, allow_blank: true}
    v.validates :best_time_to_reach,  length: {maximum: 100, allow_blank: true}
    v.validates :how_did_hear,        length: {maximum: 20, allow_blank: true},
                                      inclusion: %w(craigslist post-it flier careerbuilder digitalad billboard yardsign newspaperad referral other)
    v.validates :referral_code,       length: {maximum: 25, allow_blank: true}, :if => :referral?
    v.validates :other_source,        length: {maximum: 255, allow_blank: true}, :if => :other?
    v.validates :preferred_language
  end
  validates :phone_number2,       format: {with: /1?\W*([2-9][0-8][0-9])\W*([2-9][0-9]{2})\W*([0-9]{4})(\se?x?t?(\d*))?/, allow_blank: true}

  def full_name
    "#{first_name} #{last_name}"
  end

  def referral?
    how_did_hear == 'referral'
  end

  def other?
    how_did_hear == 'other'
  end

  # Returns a human-readable description of this recruitment's source.
  def source_description
    case code = how_did_hear.presence
    when 'other'
      "OTHER: #{other_source}"
    when 'referral'
      "REFERRAL: #{referral_code}"
    when NilClass
    else
      code.upcase
    end
  end

  # If validations pass, this method sends an email.
  # For my neanderthalic purposes, this is considered "saving" the model.
  def save
    self.referral_code = nil unless referral?
    self.other_source = nil unless other?
    if valid?
      CarrierRecruitmentMailer.new_recruit(self).deliver
      CarrierRecruitmentMailer.confirmation(self).deliver
      true
    else
      false
    end
  end

  # Overridden to support "smarter" error highlighting on forms.
  #
  # @see config/initializers/active_model_helper.rb
  def errors_under *symbols
    symbols.map do |sym|
      case sym
      when /^city_state_zip$/
        %w(city state zip_code city_state_zip)
      when /^(city|state|zip_code)$/
        [sym, :city_state_zip]
      when /^how_did_you_hear$/
        %w(how_did_hear referral_code other_source how_did_you_hear)
      when /^(how_did_hear|referral_code|other_source)$/
        [sym, :how_did_you_hear]
      else
        [sym]
      end
    end.flatten.map{|k| errors[k]}.compact.flatten
  end
end
