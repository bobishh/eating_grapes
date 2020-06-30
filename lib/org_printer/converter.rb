require 'dry/monads'
require 'dry/monads/do'
require 'org-ruby'
require 'org_printer/contract'

module OrgPrinter
  # converts org to whatever
  class Converter
    class UnsupportedOutputFormat < StandardError; end
    include Dry::Monads[:try]
    include Dry::Monads::Do.for(:convert)

    DEFAULT_OUTPUT_FORMAT = :html
    attr_reader :source

    def initialize(source, to = DEFAULT_OUTPUT_FORMAT)
      @source = source
      @to = to.to_s
    end

    def convert
      validated = yield validate
      result = call_converter
    end

    private

    def validate
      Contract.new.call(input: source, format: @to)
    end

    def call_converter
      Try do
        converter.new(source).public_send(to_method)
      end.to_result
    end

    def to_method
      "to_#{@to}".to_sym
    end

    def converter
      Orgmode::Parser
    end
  end
end
