# frozen_string_literal: true

module LinkHelper
  def external_link_to(title, path, options = {}, &block)
    external_options = options.merge(target: "_blank", rel: "noopener noreferrer")

    if block
      link_to path, external_options, &block
    else
      link_to title, path, external_options
    end
  end
end
