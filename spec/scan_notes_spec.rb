require 'spec_helper'

describe TextIndentationToTree::ScanNotes, bin:true do
  def call(argv, stdin=fixture)
    whitespace = stdin[/\A\s*/]
    stdin      = stdin.gsub(/^#{whitespace}/, "")
    described_class.call(StringIO.new(stdin), argv)
  end

  let(:fixture) { <<-STDIN }
    A
      a
      b
        l
      c
        m
    B
      d
      e
        x
          y
            z
      f
    C
    STDIN

  it 'prints the topmost level of the note string from stdin, numbering lines as it goes' do
    expect(call []).to eq "0. A\n1. B\n2. C\n"
  end

  it 'treats numbers on argv as array indexes in its lines, printing that row\'s children' do
    expect(call %w[0]).to eq "0. a\n1. b\n2. c\n"
    expect(call %w[1]).to eq "0. d\n1. e\n2. f\n"
  end

  it 'can take multiple line numbers to dive down to a topic' do
    expect(call %w[0 1]).to eq "0. l\n"
    expect(call %w[0 2]).to eq "0. m\n"
    expect(call %w[1 1 0 0]).to eq "0. z\n"
  end

  context 'with -a or --all flag' do
    it 'prints all children' do
      raise pending
      expect(call %w[-a]).to eq
    end
  end
  context '--help flag'
  # ERRORS
  context 'when given non-numeric args'
  context 'when index is out of bounds'
  context 'when there are no results to display'
    # expect(call [2]).to eq "" # <-- that really what I want?
  context 'when file is formatted poorly'
end
