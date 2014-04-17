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

  describe "#inner_html" do
    it "returns the inner html" do
      node = Nokogiri.parse('<p class="pi"><i>a1</i><b><i class="ii">a</i>2</b></p>').children.first
      Redbold.new(node).inner_html.should eql('<p class="pi"><i>a1</i><b><i class="ii">a</i>2</b></p>')
    end

    context "with conversion tags exist" do
      it "returns the converted inner html" do
        node = Nokogiri.parse('<p class="pi"><red>a1</red><b><i class="ii">a</i>2</b></p>').children.first
        BigRedbold.new(node).inner_html.should eql('<p class="pi"><span class="bigred">a1</span><b><i class="ii">a</i>2</b></p>')
        Redbold.new(node).inner_html.should eql('<p class="pi"><span class="red">a1</span><b><i class="ii">a</i>2</b></p>')
      end
    end

    it "returns the inner html" do
      node = Nokogiri.parse('<p class="pi"><i>a1</i><b><i class="ii">a</i>2</b></p>').children.first
      Redbold.new(node).inner_html.should eql('<p class="pi"><i>a1</i><b><i class="ii">a</i>2</b></p>')
    end
  end
end
