; SQL syntax highlighting in sqlx queries

(macro_invocation
  macro: (scoped_identifier
    path: (identifier) @_path (#eq? @_path "sqlx")
    name: (identifier) @_name (#any-of? @_name "query" "query_as")
  )
  (token_tree
    (_ (string_content) @injection.content)
    (#set! injection.language "sql")
  )
)

(call_expression
  (scoped_identifier
    path: (identifier) @path (#eq? @path "sqlx")
    name: (identifier) @name (#any-of? @name "query" "query_as"))
  (arguments
    (_ (string_content) @injection.content)
    (#set! injection.language "sql")))
