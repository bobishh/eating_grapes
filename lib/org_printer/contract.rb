require_relative '../../config/initializers/dry_validation'

module OrgPrinter
  class Contract < Dry::Validation::Contract
    params do
      required(:input).filled(:string)
      required(:format).value(:string)
    end

    rule(:format) do
      key.failure('unsupported') unless OrgPrinter::FORMATS.include?(value)
    end
  end
end
