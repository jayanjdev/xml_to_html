require "spec_helper"

describe XmlValidator::Transformer do

  describe ".element_transform" do
  end

  describe ".node_attributes" do
    it "returns empty string when there are no attributes" do
      node = Nokogiri.parse('<span>xyz</span>').children.first
      XmlValidator::HtmlExtender.node_attributes(node).should eql('')
    end

    it "returns attributes as string when there is exactly one attribute" do
      node = Nokogiri.parse('<span class="red">xyz</span>').children.first
      XmlValidator::HtmlExtender.node_attributes(node).should eql(' class="red"')
    end

    it "returns attributes as string when there are more than one attributes" do
      node = Nokogiri.parse('<span class="red" data="rd">xyz</span>').children.first
      XmlValidator::HtmlExtender.node_attributes(node).should eql(' class="red" data="rd"')
    end
  end

end
