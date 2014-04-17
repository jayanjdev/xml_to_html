require 'nokogiri'

module XmlValidator
  class HtmlExtender
    extend Transformer
    attr_reader :node
    def initialize(node)
      @node = node
    end

    def self.convert(tag, opts = {})
      @convert_table ||= {}
      p "#{self.class} #{self.superclass}------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
      @convert_table[tag.to_s] = opts
      p @convert_table.inspect
    end

    def self.in_conversion_table(tag)
      @convert_table[tag.to_s]
    end

    def inner_html
      self.class.transform(node)
    end
  end
end
