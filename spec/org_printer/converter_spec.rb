require 'spec_helper'
require 'org_printer/converter'
require 'org_printer'

RSpec.describe OrgPrinter::Converter do
  subject { OrgPrinter::Converter.new(source, to).convert }
  let(:source) { "* HELLO" }

  context "org to html" do
    let(:to) { :html }
    let(:expected) { "<h1>HELLO</h1>\n" }

    it 'is success' do
      expect(subject).to be_success
    end

    it 'wraps converted text' do
      expect(subject.value!).to eq(expected)
    end
  end

  context "org to markdown" do
    let(:to) { :markdown }
    let(:expected) { "# HELLO\n" }

    it 'is success' do
      expect(subject).to be_success
    end

    it 'wraps converted text' do
      expect(subject.value!).to eq(expected)
    end
  end
end
