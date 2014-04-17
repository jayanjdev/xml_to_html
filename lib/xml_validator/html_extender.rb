require 'nokogiri'

module XmlValidator
  class HtmlExtender
    extend Transformer
    attr_reader :node
    def initialize(node)
      @node = node
    end

    def inner_html
      self.class.transform(node)
    end
  end
end
