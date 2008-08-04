module Ruport::Reportable::InstanceMethods
  # Overrides, since Ruport is not really active for supporting edge rails.
  # Maybe we can remove it with a further version of acts_as_reportable
  # It's broken as of version 1.1.0.
  def get_attributes_with_options(options = {})
        attrs = attributes()
        attrs = attrs.inject({}) {|h,(k,v)|
                  h["#{options[:qualify_attribute_names]}.#{k}"] = v; h
                } if options[:qualify_attribute_names]
        attrs
      end


end
