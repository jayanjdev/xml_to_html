module XmlValidator
  module Transformer
    def transform(_node) 
      if _node.is_a?(Nokogiri::XML::Element) 
        return element_transform(_node)
      elsif _node.is_a?(Nokogiri::XML::NodeSet)
        return _node.inject('') { |str, ele| str + transform(ele) }
      elsif  _node.is_a?(Nokogiri::XML::Text)
        return _node.to_s
      end
    end

    def element_transform(_node)
      if self.in_conversion_table(_node.name)
        open_tag = self.in_conversion_table(_node.name)[:open]
        close_tag = self.in_conversion_table(_node.name)[:close]
        "#{open_tag}#{transform(_node.children)}#{close_tag}"
      else
        "<#{_node.name}#{node_attributes(_node)}>#{transform(_node.children)}</#{_node.name}>"
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
