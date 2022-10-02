# frozen_string_literal: true

module VersionHelper
  def code_version_from_tag(tag)
    tag.split(":").last
  end
end
