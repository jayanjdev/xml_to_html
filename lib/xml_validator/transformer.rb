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

    def convert(tag, opts = {})
      @convert_table ||= {}
      @convert_table[tag.to_s] = opts
    end

    def requires_conversion?(tag)
      @convert_table[tag.to_s]
    end

    def element_transform(_node)
      if requires_conversion?(_node.name)
        if (requires_conversion?(_node.name)[:open] && requires_conversion?(_node.name)[:close])
          open_tag = requires_conversion?(_node.name)[:open]
          close_tag = requires_conversion?(_node.name)[:close]
          "#{open_tag}#{transform(_node.children)}#{close_tag}"
        elsif requires_conversion?(_node.name)[:lambda]
          requires_conversion?(_node.name)[:lambda].call(_node)
        else
          raise "conversion definition for #{_node.name} is incorrect" 
        end
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
