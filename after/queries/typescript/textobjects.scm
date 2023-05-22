; extends

(method_definition
  body: (statement_block)) @method.outer

(method_definition
  body: (statement_block . "{" . (_) @_start @_end (_)? @_end . "}"
  (#make-range! "method.inner" @_start @_end)))
