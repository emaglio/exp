# require "trailblazer/endpoint"
module Expense
  module Endpoint

  def self.claim(params:, sinatra:, **)
    result = Expense::Claim.( params: params, archive_dir: "./downloads", upload_dir: "./uploads" )

    if result.success?
      sinatra.redirect "/claims/#{result[:model].id}"
    else
      "broken!"
    end
  end
end
end

module Claim::Endpoint
  def self.show(params:, sinatra:, **)

    return PaymentVoucher::Cell::Voucher.( Claim::Row[params[:id]] ).()
    Claim::Cell::Show.( Claim::Row[params[:id]] ).()
  end

  def self.rezip(params:, sinatra:, **)
    result = Expense::Claim::Rezip.( params: params, archive_dir: "./downloads", upload_dir: "./uploads" )

    result.inspect

    # Claim::Cell::Show.( Claim::Row[params[:id]] ).()
  end
end
