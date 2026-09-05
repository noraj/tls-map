# Changelog

All notable changes to this project will be documented in this file.

The format is partially following [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), except that the changes are grouped by meaningfulness type (features, updates, chores) and not by change type (added, changed, deprecated, removed, fixed, security). Instead, change types are added as prefixed label + special breaking change label.

Starting from version 3.3.0, this project will adheres to [Break Versioning](https://www.taoensso.com/break-versioning). Until then, no standard was enforced.

## Unreleased

### Updates

- **Fixed** sslyze extraction for version 6.1+ [#200](https://github.com/noraj/tls-map/issues/200)
  - Now `sslyze4` (4.x - 5.x) and `sslyze6` (6.x+) are separated
- **Fixed** testssl.sh extraction for version 3.2+ (including 3.1dev) [#199](https://github.com/noraj/tls-map/issues/199)

### Chores

- **Breaking change** - **Removed** support for Ruby 3.2
  - Ruby 3.2 is ([EOL](https://www.ruby-lang.org/en/downloads/branches/))
  - parallel-2.1.0 requires ruby version >= 3.3
- **Changed** Dependencies update
- **Changed** Data update

## [3.2.0](https://github.com/noraj/tls-map/releases/tag/v3.2.0) - 2026-01-09

### Updates

- **Fixed** error `private constant Pathname::SEPARATOR_LIST referenced (NameError)` by replacing `Pathname::SEPARATOR_LIST` with `File::SEPARATOR` as [the constant was made private](https://github.com/ruby/pathname/commit/60f5d58d73e3deea750f1579d2a94872b199c77f)

### Chores

- **Breaking change** - **Removed** support for Ruby 3.1
- **Added** support for Ruby 4.0
- **Changed** Dependencies update
- **Changed** the publishing process in the documentation

## [3.1.0](https://github.com/noraj/tls-map/releases/tag/v3.1.0) - 2025-02-01

### Features

- **Added** an `--audit` option to bulk mode to highlight weak cipher suites [#104](https://github.com/noraj/tls-map/issues/104)

### Updates

added, changed, deprecated, removed, fixed, security

- **Added** Display protocol version for extract command when options are used [#54](https://github.com/noraj/tls-map/issues/54)
- **Added** Colored help message [2627eb8](https://github.com/noraj/tls-map/commit/2627eb81914cb932e5eb6638d5de80dccaa8833b)

### Chores

- **Breaking changes** - **Removed** support for Ruby 3.0 as they are EOL
- **Added** support for Ruby 3.4
- **Changed** Update extended data for offline use
- **Changed** Use commonmarker 2.0 for lib documentation [ec7a452](https://github.com/noraj/tls-map/commit/ec7a452d953cf364a963037428c44c70165d3949)

## [3.0.0](https://github.com/noraj/tls-map/releases/tag/v3.0.0) - 2024-07-05

### Updates

- **Fixed** Patch GnuTLS parsing regexp to reflect upstream source code format change

### Chores

- **Breaking changes** - **Removed** support for Ruby 2.6 and 2.7 as they are EOL
    - [Ruby - Ruby Maintenance Branches](https://www.ruby-lang.org/en/downloads/branches/)
    - [endoflife.date - Ruby](https://endoflife.date/ruby)
- **Changed** Data update
- **Changed** Update dependencies
- **Added** `csv` as a dependency as it will be removed from standard library

## [2.2.0](https://github.com/noraj/tls-map/releases/tag/v2.2.0) - 2024-01-31

### Features

- **Added** support for `tlsx` in `TLSmap::App::Extractor` class (see [lib doc](https://noraj.github.io/tls-map/yard/TLSmap/App/Extractor))

### Chores

- **Added** support for Ruby 3.2

## [2.1.0](https://github.com/noraj/tls-map/releases/tag/v2.1.0) - 2022-01-31

### Chores

- **Added** CodeQL security code review
- **Added** support for Ruby 3.1
- **Changed** Update to yard [v0.9.27](https://github.com/lsegal/yard/releases/tag/v0.9.27)
  - Move from Redcarpet to CommonMarker markdown provider

## [2.0.0](https://github.com/noraj/tls-map/releases/tag/v2.0.0) - 2021-08-12

### Features

- `TLSmap::App::Extended`:
  - **Added** security level mapping: `SECURITY_LEVEL`
  - **Added** a new attribute and getter `enhanced_data`, it contains a hash with enhanced information of all cipher suites (like the output of `extend` but for all cipher suites)
  - **Added** a new attribute `ciphersuite_all` containing raw data from ciphersuite.info (non-yet enhanced version of `enhanced_data`), only for internal use.
  - internal method `fetch_ciphersuite` that populate `ciphersuite_all` attribute
  - **Added** `enhance_all` method, fetch and enhance data from ciphersuite.info for all cipher suites and store it for batch usage.
  - **Added** new attribute for `extend` method: `caching`: will fetch info for all cipher suites the 1st time and used the cached value for further requests
- `TLSmap::App`:
  - **Added** a `search` class method for stateless usage
  - **Added** a getter for `tls_map` attribute
- `TLSmap::App::Cipher`:
  - **Added** new class allowing to manipulate cipher suite information (check the library doc for more details)
- `TLSmap::CLI::Extended`
  - **Added** new class implementing an offline version of `TLSmap::CLI::Extended`, intended for CLI or offline usage and batch requests (using `data/extended.marshal`)
- CLI
  - `Extract`
    - **Added** `--only-weak` to `--hide-weak` to have the ability to show/hide weak cipher suites
  - `Update`
    - **Added** `--with-extended` option to backup `extended.marshal` in addition to `mapping.marshal`

### Updates

**Breaking changes** - **Changed** More modular file architecture in `lib`
  - It shouldn't change anything from user perspective (CLI & lib)
  - It will change the `require` path for people who want to develop on tls-map or that use some fragments of the library
- CLI
  - `Search`
    - **Changed** `--extended`: colorize `security` value depending on the security level

### Chores

- Dev dependencies:
  - **Removed** commonmarker since it's not supported by yard yet
  - **Added** yard-coderay for basic syntax highlight
  - **Changed** Update rubocop
- `TLSmap::CLI`
  - **Changed** small transparent fixes and spelling mistakes corrected
- Fork:
  - **Changed** repository move from [sec-it/tls-map](https://github.com/sec-it/tls-map) to [noraj/tls-map](https://github.com/noraj/tls-map)

## [1.3.2](#)

### Updates

- **Added** `helper()` method to `TLSmap::App::Extractor` so it will display a useful error message when the wrong format is provided.

### Chores

- **Added** new dependency requirement architecture: runtime dependencies are set both in `.gemspec` + `Gemfile` while development ones are set in `Gemfile` only.
- **Changed** `Gemfile` dependencies are categorized in groups. So it's now possible to exclude the _docs_ group while installing in a CI while keeping _test_ and _lint_. `.gempsec` is only able to create _runtime_ and _development_ but not custom groups.

## [1.3.1](#)

### Chores

- **Fixed** `JSON.load_file()` is only available since Ruby 3.0 so `Utils.json_load_file()` was created to bring compatibility with Ruby 2.X
- **Changed** Convert `Utils` methods as module methods instead of instance methods

## [1.3.0](#)

### Features

- **Added** `bulk_search()` method for bulk search (file with one cipher per line)
  - **Added** new `bulk` CLI command

### Chores

- **Added** `webrick` in dev dependencies to be able to use `yard server` for teh documentation

## [1.2.0](#)

### Features

- **Added** new `TLSmap::App::Extractor` class: extract ciphers from external tools file output (see [lib doc](https://noraj.github.io/tls-map/yard/TLSmap/App/Extractor))
  - Support SSLyze, sslscan2, testssl.sh, ssllabs-scan
  - **Added** New `extract` CLI command

### Chores

- **Changed** yard doc format from rdoc to markdown for teh documentation
- **Added** unit tests

## [1.1.0](#)

### Features

- **Added** new `TLSmap::App::Extended` class: partial wrapper around ciphersuite.info API to get extra info about a cipher
- **Added** new `--extended` and `--acronym` CLI option for the `search` command using the new class

### Updates

- **Changed** Move `tmpfile()` to a `Utils` module (no breaking changes)
- **Fixed** NSS and GnuTLS parser: many ciphers were not parsed due to a wrong regexp
- **Changed** make search case-insensitive for hexadecimal codepoints
- **Fixed** OpenSSL parser: some TLS 1.0 ciphers where defined in SSL 3.0 source code file

### Chores

- **Added** a _limitations_ page in the documentation
  - No SSL support
  - No custom cipher suites support
  - Unassigned and reserved codepoints are hidden

## [1.0.0](#)

- First version
