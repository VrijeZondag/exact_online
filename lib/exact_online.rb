require "exact_online/version"
require "exact_online/engine"

require "exact_online/jobs/create_purchase_invoice"
require "exact_online/jobs/keep_alive"

require "exact_online/resources/base"
require "exact_online/resources/collection"
require "exact_online/resources/customer"
require "exact_online/resources/document_attachment"
require "exact_online/resources/document"
require "exact_online/resources/mailbox"
require "exact_online/resources/purchase_invoice_lines"
require "exact_online/resources/purchase_invoice"

require "exact_online/services/base"
require "exact_online/services/customers_api"
require "exact_online/services/purchase_invoices_api"

require "exact_online/token/manager"
require "exact_online/token/refresher"

require "exact_online/client"
require "exact_online/configuration"
require "exact_online/o_auth_handler"
require "exact_online/webhook"


module ExactOnline
  def self.alive?
    ExactOnline::Client.new.alive?
  end

  def find_customers_by_email(email)
    Resources::Customer.find_by(email:)
  end
end
