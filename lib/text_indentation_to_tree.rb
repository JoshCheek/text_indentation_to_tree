module TextIndentationToTree
  class Node < Struct.new(:is_root, :depth, :line_number, :value, :children)
    alias root? is_root

    def initialize(is_root:, depth:, line_number:, value:, children:)
      super is_root, depth, line_number, value, children
    end
  end


  class FailedLint < StandardError
    attr_reader :lint_result

    def initialize(lint_result)
      @lint_result = lint_result
      super build_message(lint_result)
    end

    def validate!
      raise self unless message.empty?
    end

    private

    def build_message(lint_result)
      lint_result[:inconsistent_child_depths].each_with_object("") do |node, message|
        children_message = node.children.map do |child|
          "  #{child.line_number}: #{child.value.inspect}"
        end
        message << "Inconsistent child depths:\n#{children_message.join "\n"}\n"
      end
    end
  end


  module Lint
    extend self
    def string(string)
      tree TextIndentationToTree.parse(string)
    end

    def tree(root)
      lint_results = {inconsistent_child_depths: []}
      _lint_tree lint_results, root
    end

    private

    def _lint_tree(lint_results, root)
      children   = root.children
      num_depths = children.map(&:depth).uniq.size
      if 1 < num_depths
        lint_results[:inconsistent_child_depths] << root
      end
      children.each do |child|
        _lint_tree lint_results, child
      end
      lint_results
    end
  end

  extend self

  # builds the tree, but raises if it fails linting
  def parse!(string)
    root, queue = build_tree string
    result = Lint.tree root
    FailedLint.new(result).validate!
    root
  end

  def parse(string)
    root, * = build_tree(string)
    root
  end

  private

  def build_tree(string)
    root  = Node.new is_root: true, depth: -1, line_number: -1, value: 'root', children: []
    queue = node_queue_for(string)
    extract_children(root, queue)
    raise "This shouldn't be possible!" unless queue.empty?
    root
  end

  def extract_children(parent, queue)
    return parent if queue.empty?
    if parent.depth < queue.first.depth
      child = queue.shift
      parent.children << child
      extract_children child,  queue
      extract_children parent, queue
    end
  end

  def node_queue_for(string)
    string.lines
          .map.with_index(1)
          .reject { |line, _| line =~ /^\s*$/ }
          .map { |line, line_number|
            Node.new(is_root:     false,
                     depth:       line[/^\s*/].size, # amount of leading indentation
                     line_number: line_number,
                     value:       line.strip,
                     children:    Array.new)
          }
  end
end
