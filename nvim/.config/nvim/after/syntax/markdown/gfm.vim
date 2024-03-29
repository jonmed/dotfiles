" Inline code
"
" This is `inline` code.
" Note: \%(^\|[^`\\]\)\zs`[^`] does not work (issue #5)
syn region githubFlavoredMarkdownCode start="\%(^\|[^`\\]\)\@<=`[^`]" end="`" display oneline

" Mentions
"
" @rhysd @foo/bar
syn match githubFlavoredMarkdownMention "\%(^\|\s\)\@<=@\S\+" display

" Strikethrough
"
" ~~This text is deleted~~
syn region githubFlavoredMarkdownStrikethrough start="\~\~" end="\~\~"

" Issue number
"
" #123
syn match githubFlavoredMarkdownIssueNumber "#\@<!#\d\+\>" display

" Table
"
" |  A  |  B  |
" | Foo | Woo |
" | Bar | Hoo |
syn match githubFlavoredMarkdownTable "^|.\+|\s*$" contains=
  \githubFlavoredMarkdownTableDelimiter,githubFlavoredMarkdownTableAligner,githubFlavoredMarkdownTableAlignBorder,
  \githubFlavoredMarkdownTableBorderAligner,githubFlavoredMarkdownTableBorder,githubFlavoredMarkdownCode,
  \markdownBoldItalic,markdownBold,markdownItalic,markdownLinkText,markdownIdDeclaration,githubFlavoredMarkdownMention,
  \githubFlavoredMarkdownIssueNumber,githubFlavoredMarkdownStrikethrough,githubFlavoredMarkdownEmoji
syn match githubFlavoredMarkdownTableAlignBorder ":-\+:" contained containedin=githubFlavoredMarkdownTable display
syn match githubFlavoredMarkdownTableAligner ":-\@=" contained containedin=githubFlavoredMarkdownTableAlignBorder display
syn match githubFlavoredMarkdownTableAligner "-\@<=:" contained containedin=githubFlavoredMarkdownTableAlignBorder display
syn match githubFlavoredMarkdownTableBorder "-\+" contained containedin=githubFlavoredMarkdownTableAlignBorder display
syn match githubFlavoredMarkdownTableDelimiter "\\\@<!|" contained containedin=githubFlavoredMarkdownTable display

" Check box
"
" - [x] Checked
" - [ ] Not checked
syn match githubFlavoredMarkdownCheckBox "\%(\_^\s*\%(-\|\*\|+\|\d\+\.\)\s\+\)\@<=\[[ x]]" contains=githubFlavoredMarkdownCheckBoxBracket,githubFlavoredMarkdownCheckBoxX
syn match githubFlavoredMarkdownCheckBoxBracket "\[\|]" contained containedin=githubFlavoredMarkdownCheckBox
syn keyword githubFlavoredMarkdownCheckBoxX x contained containedin=githubFlavoredMarkdownCheckBox

hi def link githubFlavoredMarkdownCode            Constant
hi def link githubFlavoredMarkdownMention         markdownLinkText
hi def link githubFlavoredMarkdownStrikethrough   Comment
hi def link githubFlavoredMarkdownEmoji           PreProc
hi def link githubFlavoredMarkdownTableDelimiter  Delimiter
hi def link githubFlavoredMarkdownTableAligner    Delimiter
hi def link githubFlavoredMarkdownTableBorder     Type
hi def link githubFlavoredMarkdownIssueNumber     Number
hi def link githubFlavoredMarkdownCheckBoxBracket markdownListMarker
hi def link githubFlavoredMarkdownCheckBoxX       Special
