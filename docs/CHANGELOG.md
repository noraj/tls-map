# Changelog

## [3.1.0]

Additions:

- Add an `--audit` option to bulk mode to highlight weak cipher suites [#104](https://github.com/noraj/tls-map/issues/104)

Enhancements:

- Display protocol version for extract command when options are used [#54](https://github.com/noraj/tls-map/issues/54)
- Colored help message [2627eb8](https://github.com/noraj/tls-map/commit/2627eb81914cb932e5eb6638d5de80dccaa8833b)

Chore:

- **Breaking changes**:
  - Drop support for Ruby 3.0 as they are EOL
- Add support for Ruby 3.4
- Update extended data for offline use

Documentation:

- Use commonmarker 2.0 [ec7a452](https://github.com/noraj/tls-map/commit/ec7a452d953cf364a963037428c44c70165d3949)

## [3.0.0]

- **Breaking changes**:
  - Drop support for Ruby 2.6 and 2.7 as they are EOL
    - [Ruby - Ruby Maintenance Branches](https://www.ruby-lang.org/en/downloads/branches/)
    - [endoflife.date - Ruby](https://endoflife.date/ruby)
- Update data
- Patch GnuTLS parsing regexp to reflect upstream source code format change
- Patch GnuTLS parsing regexp to reflect upstream source code format change (again)
- Update dependencies
- Add `csv` as a dependency as it will be removed from standard library

## [2.2.0]

- New support for `tlsx` in `TLSmap::App::Extractor` class (see [lib doc](https://noraj.github.io/tls-map/yard/TLSmap/App/Extractor))
- Chore:
  - Add support for Ruby 3.2

## [2.1.0]

- Chore:
  - Add CodeQL security code review
  - Add support for Ruby 3.1
- Dependencies:
  - Update to yard [v0.9.27](https://github.com/lsegal/yard/releases/tag/v0.9.27)
    - Move from Redcarpet to CommonMarker markdown provider

## [2.0.0]

**BREAKING CHANGES:**

- More modular file architecture in `lib`
  - It shouldn't change anything from user perspective (CLI & lib)
  - It will change the `require` path for people who want to develop on tls-map or that use some fragments of the library

Additions:

- `TLSmap::App::Extended`:
  - add security level mapping: `SECURITY_LEVEL`
  - add a new attribute and getter `enhanced_data`, it contains a hash with enhanced information of all cipher suites (like the output of `extend` but for all cipher suites)
  - add a new attribute `ciphersuite_all` containing raw data from ciphersuite.info (non-yet enhanced version of `enhanced_data`), only for internal use.
  - internal method `fetch_ciphersuite` that populate `ciphersuite_all` attribute
  - add `enhance_all` method, fetch and enhance data from ciphersuite.info for all cipher suites and store it for batch usage.
  - new attribute for `extend` method: `caching`: will fetch info for all cipher suites the 1st time and used the cached value for further requests
- `TLSmap::App`:
  - add a `search` class method for stateless usage
  - add a getter for `tls_map` attribute
- `TLSmap::App::Cipher`:
  - New class allowing to manipulate cipher suite information (check the library doc for more details)
- `TLSmap::CLI`
  - small transparent fixes and spelling mistakes corrected
- `TLSmap::CLI::Extended`
  - new class implementing an offline version of `TLSmap::CLI::Extended`, intended for CLI or offline usage and batch requests (using `data/extended.marshal`)
- CLI
  - `Search`
    - `--extended`: colorize `security` value depending on the security level
  - `Extract`
    - add `--only-weak` to `--hide-weak` to have the ability to show/hide weak cipher suites
  - `Update`
    - add `--with-extended` option to backup `extended.marshal` in addition to `mapping.marshal`

Chore:

- Dev dependencies:
  - Remove commonmarker since it's not supported by yard yet
  - Add yard-coderay for basic syntax highlight
  - Update rubocop

- Fork:
  - repository move from [sec-it/tls-map](https://github.com/sec-it/tls-map) to [noraj/tls-map](https://github.com/noraj/tls-map)

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
