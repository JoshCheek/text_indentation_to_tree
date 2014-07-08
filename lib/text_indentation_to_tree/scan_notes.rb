require 'text_indentation_to_tree'

module TextIndentationToTree
  class ScanNotes
    def self.call(stdin, argv)
      new(stdin, argv).call
    end

    def initialize(stdin, argv)
      @stdin = stdin
      @path  = argv.map(&:to_i)
    end

    def call
      root   = TextIndentationToTree.parse! stdin.read
      target = path.reduce(root) { |node, n| node.children[n] }
      target.children
            .map.with_index { |child, index| "#{index}. #{child.value}\n" }
            .join("")
    end

    private

    attr_reader :stdin, :path
  end
end
