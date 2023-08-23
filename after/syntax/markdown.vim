" Markdown :tag: highlight
syn match markdownTag ":\w\+:"
hi link markdownTag mkdLink

" markdownWikiLink is a new region
syn region markdownWikiLink matchgroup=markdownLinkDelimiter start="\[\[" end="\]\]" keepend oneline concealends
hi markdownWikiLink gui=bold
hi link markdownLinkDelimiter markdownWikiLink
