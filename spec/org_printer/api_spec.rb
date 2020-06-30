require 'spec_helper'
require 'org_printer/api'

RSpec.describe "App::API" do
  include Rack::Test::Methods

  def json_body
    JSON.parse(last_response.body)
  end

  def app
    OrgPrinter::API
  end

  describe 'POST /conversions' do
    subject { post "/conversions", { format: format, input: input } }
    let(:input) do
      <<~ORG
        * Hello
        ** World
      ORG
    end

    before do
      subject
    end

    context 'format = html' do
      let(:format) { :html }

      it 'returns html when given org text' do
        expect(json_body['result']).to eq("<h1>Hello</h1>\n<h2>World</h2>\n")
      end
    end

    context 'format = markdown' do
      let(:format) { :markdown }

      it 'returns markdown when given org text' do
        expect(json_body['result']).to eq("# Hello\n## World\n")
      end
    end
  end
end
