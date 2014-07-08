# TextIndentationToTree

*Three* projects this weekend required me to parse indented text into a tree.
Two of them were completely independent of eachother!

Looked at existing solutions.
They were invarious states of disrepair/untestedness/questionable
implementation (i.e. quick code review found bugs).
I'm all for open source, but a of the 8 or so I checked out,
most didn't even have a repository for the code!
And it's probably not worth putting time into a solution that's
not been touched in years.

So anyway, This lib will parse indented text and return a tree.
It comes with a binary (currently called `scan_notes` -- one of my projects)
that will allow you to print the various levels of indentation
by submitting command line params to tell it how to traverse the tree.

I'd like to build out the TextIndentationToTree gem itself to be
pretty reasonably able to handle any given need, without making
it overly complex.

I'll bundle the binary with it, but probably change the name, since
the functionality is useful independently of what I intend to use it for.

Currently a giant work in progress.

## Dependencies

Runtime Dependencies: None.

Test Dependencies: rspec (I'm using 3)

## To install

Currently, you're going to have to clone it and set lib into the load path as I haven't made a gemspec yet.

## To run tests

From root dir: `$ rspec`

## My notes I took for where I want to go with it

Based on the formatting of my notes, you'll understand why I need this functionality ;)

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
    should work for more than just spaces
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

License
=======

           DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                       Version 2, December 2004

    Copyright (C) 2012 Josh Cheek <josh.cheek@gmail.com>

    Everyone is permitted to copy and distribute verbatim or modified
    copies of this license document, and changing it is allowed as long
    as the name is changed.

               DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
      TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

     0. You just DO WHAT THE FUCK YOU WANT TO.

