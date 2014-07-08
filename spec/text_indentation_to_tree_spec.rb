require 'spec_helper'
require 'stringio'

describe TextIndentationToTree, tree:true do
  # run against manifesto: /Users/josh/code/todo-game/todo_manifesto.txt
  def call(string)
    to_ary_tree TextIndentationToTree.parse!(string)
  end

  it 'turns String into a tree' do
    expect(call "a").to eq [['a', []]]
    expect(call "a\nb").to eq [['a', []],
                               ['b', []]]
    expect(call "a\n b").to eq [['a', [['b', []]]]]
    expect(call "a\n b\n c\nd").to eq [['a', [['b', []],
                                              ['c', []]
                                             ]],
                                       ['d', []]]
    expect(call "a\n b\n  c").to eq [['a', [['b', [['c', []]]]]]]
  end

  it 'can deal with whatever amount of indentation, so long as it is consistent across childs' do
    expect(call "a\n b\n  c").to eq [['a', [['b', [['c', []]]]]]]
    expect(call "a\n  b\n   c").to eq [['a', [['b', [['c', []]]]]]]
    expect(call "a\n   b\n    c").to eq [['a', [['b', [['c', []]]]]]]
  end

  it 'ignores leading indentation' do
    expect(call " a\n"\
                " b\n"\
                "   c\n"\
                " d").to eq [["a", []],
                             ["b", [["c", []]]],
                             ["d", []]]
  end

  it 'ignores blank lines, but this does not fuck up the line numbers' do
    root = TextIndentationToTree.parse("a\n"\
                                 "\n"\
                                 "b\n"\
                                  "    \n"\
                                  "c")
    expect(root.children.size).to eq 3
    a, b, c = root.children
    expect(a.children).to be_empty
    expect(b.children).to be_empty
    expect(c.children).to be_empty
    expect(a.line_number).to eq 1
    expect(b.line_number).to eq 3
    expect(c.line_number).to eq 5
  end

  specify 'pares vs parse!: the bang-version raises if it fails linting, ' do
    TextIndentationToTree.parse("a\n  b\n c")
    expect { TextIndentationToTree.parse! "a\n  b\n c" }.to raise_error TextIndentationToTree::FailedLint, /2: "b"\n  3: "c"/
  end

  describe 'linting' do
    it 'identifies inconsistent indentation (e.g. 2 spaces and then 3 spaces)' do
      result = TextIndentationToTree::Lint.string "a\n"\
                                            "  b\n"\
                                            "    c\n"\
                                            "   d\n"\
                                            " e\n"
      sibs = result[:inconsistent_child_depths]
      expect(sibs.size).to eq 2
      expect(sibs[0].children.map(&:value)).to eq ['b', 'e']
      expect(sibs[1].children.map(&:value)).to eq ['c', 'd']
    end
  end
end
