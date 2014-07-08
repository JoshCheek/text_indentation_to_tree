require 'text_indentation_to_tree'
require 'text_indentation_to_tree/scan_notes'

module SpecHelpers
  def to_ary_tree(root)
    children = root.children.map { |child| to_ary_tree child }
    return children if root.root?
    [root.value, children]
  end
end

RSpec.configure do |config|
  config.include SpecHelpers
end
