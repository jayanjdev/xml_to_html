require "spec_helper"

describe XmlValidator::HtmlExtender do
  class Redbold < XmlValidator::HtmlExtender

    convert :red, :open => '<span class="red">', :close => '</span>'

    def initialize(args)
      super(args)
    end
  end

  class BigRedbold < XmlValidator::HtmlExtender

    convert :red, :open => '<span class="bigred">', :close => '</span>'

    def initialize(args)
      super(args)
    end
  end

  describe "#expand" do
    it "returns the inner html" do
      node = Nokogiri.parse('<p class="pi"><i>a1</i><b><i class="ii">a</i>2</b></p>').children.first
      Redbold.new(node).expand(node).should eql('<p class="pi"><i>a1</i><b><i class="ii">a</i>2</b></p>')
    end

    context "with conversion tags exist" do
      it "returns the converted inner html" do
        node = Nokogiri.parse('<p class="pi"><red>a1</red><b><i class="ii">a</i>2</b></p>').children.first
        BigRedbold.new(node).expand(node).should eql('<p class="pi"><span class="bigred">a1</span><b><i class="ii">a</i>2</b></p>')
        Redbold.new(node).expand(node).should eql('<p class="pi"><span class="red">a1</span><b><i class="ii">a</i>2</b></p>')
      end
    end

    it "returns the inner html" do
      node = Nokogiri.parse('<p class="pi"><i>a1</i><b><i class="ii">a</i>2</b></p>').children.first
      Redbold.new(node).expand(node).should eql('<p class="pi"><i>a1</i><b><i class="ii">a</i>2</b></p>')
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
      redbold.node_attributes(node).should eql(' class="red"')
    end

    it "returns attributes as string when there are more than one attributes" do
      node = Nokogiri.parse('<span class="red" data="rd">xyz</span>').children.first
      redbold.node_attributes(node).should eql(' class="red" data="rd"')
    end
  end

end
