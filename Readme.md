```
Maybe features will be added one day:
  ScanNotes:
    --help flag
    Handle bad args:
      non-numeric
      out of bounds
    Show something useful when there are no children
    -n/--number-of-children
    possibly a -i/--interactive, not sure if this will work well, but keyboard magician did something kind of like this
    show path that you took to current node
    start at 1, not 0
    --line for printing by line number instead of child position
    --depth 2 to show children (default depth = 1)
    --continuation-character="c" to signal that next line is a continuation of previous
  TextIndentationToTree:
    tree-like inspect
    Options to linting
      no_toplevel_indentation: false # implies the first node must have a depth of 0
      consistent_indentation:  true  # implies all depths are a multiple of n
      exact_indentation:       n     # the n that all depths are a multiple of
    Prettier inspect
    Put blank-lines back in, but have options to filter them (parser), and to disallow them (linter)
    Some traversal methods for nodes
    Some way to specify that next line is actually part of current line (block, probably)
    parent pointer
    trailing whitespace can decide blank lines siblings
    ability to tell it to keep next line with parent
    if next line is with parent, its depth is same as parent's (in "abc\n de", don't strip that space)
    provide traversal obj (depth first, breadth first, parent, children, prev_sibling, next_sibling)
    what is the difference between hard and softlinks?
    move scan_notes to be a bin in TextIndentationToTree
```
