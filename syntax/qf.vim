" From https://github.com/kevinhwang91/nvim-bqf

if exists('b:current_syntax')
  finish
endif

syn match qfFileName       /^[^│]*/              nextgroup=qfSeparatorLeft
syn match qfSeparatorLeft  /│/         contained nextgroup=qfLineNr
syn match qfLineNr         /[^│]*/     contained nextgroup=qfSeparatorRight
syn match qfSeparatorRight '│'         contained nextgroup=qfError,qfWarning,qfInfo,qfNote
syn match qfError          / E .*$/    contained
syn match qfWarning        / W .*$/    contained
syn match qfInfo           / I .*$/    contained
syn match qfNote           / [NH] .*$/ contained

hi def link qfFileName       Directory
hi def link qfSeparatorLeft  qfLineNr
hi def link qfSeparatorRight qfLineNr

hi def link qfError          DiagnosticError
hi def link qfWarning        Diagnostic
hi def link qfInfo           DiagnosticInfo
hi def link qfNote           DiagnosticHint

let b:current_syntax = 'qf'
