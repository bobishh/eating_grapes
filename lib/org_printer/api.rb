require 'grape'

module OrgPrinter
  # API
  class API < Grape::API
    version 'v1', using: :header, vendor: 'bovoid'
    format :json

    post "/conversions" do
      result = OrgPrinter::Converter.new(params[:input], params[:format]).convert
      if result.success?
        { result: result.success }
      else
        { error: result.failure }
      end
    end
  end
end
