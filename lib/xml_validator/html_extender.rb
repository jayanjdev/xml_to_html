require 'nokogiri'

module XmlValidator
  class HtmlExtender
    def initialize(node)
      @node = node
    end

    def self.convert(tag, opts = {})
      @convert_table ||= {}
      @convert_table[tag.to_s] = opts
    end

    def self.in_conversion_table(tag)
      @convert_table[tag.to_s]
    end

    def expand(_node) 
      if _node.is_a?(Nokogiri::XML::Element) 
        return node_expand(_node)
      elsif _node.is_a?(Nokogiri::XML::NodeSet)
        return _node.inject('') { |str, ele| str + expand(ele) }
      elsif  _node.is_a?(Nokogiri::XML::Text)
        return _node.to_s
      end
    end

    def node_expand(_node)
      if self.class.in_conversion_table(_node.name)
        open_tag = self.class.in_conversion_table(_node.name)[:open]
        close_tag = self.class.in_conversion_table(_node.name)[:close]
        "#{open_tag}#{expand(_node.children)}#{close_tag}"
      else
        "<#{_node.name}#{node_attributes(_node)}>#{expand(_node.children)}</#{_node.name}>"
      end
    end

    def node_attributes(_node)
      if _node.attributes.any?
        _node.attributes.collect { |key, val| " #{key}=\"#{val}\""}.join('')
      else
        ''
      end
    end

  end
end
