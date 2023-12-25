require "exact_online/version"
require "exact_online/engine"

module ExactOnline
  def self.alive?
    ExactOnline::Client.new.alive?
  end

  def find_customers_by_email(email)
    Resources::Customer.find_by(email:)
  end
end
