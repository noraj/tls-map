# Changelog

## [Unreleased]

Chore:

- Fork: repository move from [sec-it/tls-map](https://github.com/sec-it/tls-map) to [noraj/tls-map](https://github.com/noraj/tls-map)

## [1.3.2]

Additions:

- add `helper()` method to `TLSmap::App::Extractor` so it will display a useful error message when the wrong format is provided.

Chore:

- New dependency requirement architecture: runtime dependencies are set both in `.gemspec` + `Gemfile` while development ones are set in `Gemfile` only.
- `Gemfile` dependencies are categorized in groups. So it's now possible to exclude the _docs_ group while installing in a CI while keeping _test_ and _lint_. `.gempsec` is only able to create _runtime_ and _development_ but not custom groups.

## [1.3.1]

Fixes:

- `JSON.load_file()` is only available since Ruby 3.0 so `Utils.json_load_file()` was created to bring compatibility with Ruby 2.X

Chore:

- Convert `Utils` methods as module methods instead of instance methods

## [1.3.0]

Additions:

- add `bulk_search()` method for bulk search (file with one cipher per line)
  - new `bulk` CLI command

Documentation:

- add `webrick` in dev dependencies to be able to use `yard server`

## [1.2.0]

Additions:

- New `TLSmap::App::Extractor` class: extract ciphers from external tools file output (see [lib doc](https://noraj.github.io/tls-map/yard/TLSmap/App/Extractor))
  - Support SSLyze, sslscan2, testssl.sh, ssllabs-scan
  - New `extract` CLI command

Documentation:

- Change yard doc format from rdoc to markdown

Quality:

- Create unit tests

## [1.1.0]

Additions:

- New `TLSmap::App::Extended` class: partial wrapper around ciphersuite.info API to get extra info about a cipher
- New `--extended` and `--acronym` CLI option for the `search` command using the new class

Changes:

- Move `tmpfile()` to a `Utils` module (no breaking changes)

Fix:

- fix NSS and GnuTLS parser: many ciphers were not parsed due to a wrong regexp
- make search case-insensitive for hexadecimal codepoints
- fix OpenSSL parser: some TLS 1.0 ciphers where defined in SSL 3.0 source code file

Documentation:

- Added a _limitations_ page
  - No SSL support
  - No custom cipher suites support
  - Unassigned and reserved codepoints are hidden

## [1.0.0]

- First version
