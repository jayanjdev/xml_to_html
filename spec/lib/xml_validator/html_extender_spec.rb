require "spec_helper"

describe XmlValidator::HtmlExtender do
  class Redbold < XmlValidator::HtmlExtender

    def initialize(args)
      super(args)
    end
  end

  describe "#expand" do
    it "returns the inner html" do
      node = Nokogiri.parse('<b>a</b>')
      Redbold.new(node).expand.should eql('<b>a</b>')
    end
  end

  describe "#node_attributes" do
    let(:redbold) { Redbold.new('')}
    it "returns empty string when there are no attributes" do
      node = Nokogiri.parse('<span>xyz</span>').children.first
      redbold.node_attributes(node).should eql('')
    end

    it "returns attributes as string when there is exactly one attribute" do
      node = Nokogiri.parse('<span class="red">xyz</span>').children.first
      redbold.node_attributes(node).should eql('class="red"')
    end

    it "returns attributes as string when there are more than one attributes" do
      node = Nokogiri.parse('<span class="red" data="rd">xyz</span>').children.first
      redbold.node_attributes(node).should eql('class="red" data="rd"')
    end
  end

end
