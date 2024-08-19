(lang dune 3.16)

(name haikus)

(generate_opam_files true)

(source
 (github landrygeiger/haikus))

(authors "Landry Geiger")

(maintainers "Landry Geiger")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name haikus)
 (synopsis "Run a report on haiku usage in a GroupMe chat")
 (description "This is a tool to run a report on haiku usage in a GroupMe chat.")
 (depends ocaml dune)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
