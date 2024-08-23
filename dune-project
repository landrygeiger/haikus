(lang dune 3.16)

(name haikus)

(generate_opam_files true)

(source
 (github landrygeiger/haikus))

(authors "Landry Geiger")

(maintainers "Landry Geiger")

(license LICENSE)

(package
 (name haikus)
 (synopsis "Find all haikus in a Groupme chat")
 (description "This is a script to pull all messages for a Groupme chat and analyze their syllable use to identify haikus")
 (depends ocaml dune)
 (tags
  (topics "to describe" your project)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
