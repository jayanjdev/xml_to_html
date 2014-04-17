require 'nokogiri'

module XmlValidator
  class HtmlExtender
    attr_reader :node

    def initialize(node)
      @node = node
    end

    def expand(node) 
      if node.is_a?(Nokogiri::XML::Element) 
        return node_expand(node)
      elsif node.is_a?(Nokogiri::XML::NodeSet)
        return node.inject('') { |str, ele| str + expand(ele) }
      elsif  node.is_a?(Nokogiri::XML::Text)
        return node.to_s
      end
    end

    def node_expand(_node)
      "<#{_node.name}#{node_attributes(_node)}>#{expand(_node.children)}</#{_node.name}>"
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
