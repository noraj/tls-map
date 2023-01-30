# Quick start

## Quick install

```plaintext
$ gem install tls-map
```

See [Installation](/pages/install)

## Default usage: CLI

```plaintext
$ tls-map --help
TLS map 2.0.0

Usage:
  tls-map search <criteria> <term> [-o <output> --force -e -a] [--no-color --debug]
  tls-map bulk <criteria> <file> [-q <output> --force] [--no-color --debug]
  tls-map export <filename> <format> [--force] [--debug]
  tls-map extract <filename> <format> [--no-color --debug [--only-weak | --hide-weak]]
  tls-map update [--with-extended] [--debug]
  tls-map -h | --help
  tls-map --version

Search options: (offline) search and translate cipher names between SSL/TLS libraries
  <criteria>              The type of term. Accepted values: codepoint, iana, openssl, gnutls, nss.
  <term>                  The cipher algorithm name.
  -o, --output <output>   Displayed fields. Accepted values: all, codepoint, iana, openssl, gnutls, nss. [default: all]
  -e, --extended          (Online) Display additional information about the cipher (requires output = all or iana)
  -a, --acronym           (Online) Display full acronym name (requires -e / --extended option)

Bulk options: (offline) search and translate cipher names between SSL/TLS libraries in bulk
  <criteria>              The type of term. Accepted values: codepoint, iana, openssl, gnutls, nss.
  <file>                  File containing the cipher algorithm names, one per line.
  -q, --output2 <output>  Displayed fields. Accepted values: codepoint, iana, openssl, gnutls, nss. [default: iana]

Export options: (offline) export the list of all ciphers (mapping) in various formats
  <filename>              The output file name to write to.
  <format>                Supported formats: markdown (a markdown table), json_pretty (expanded JSON), json_compact (minified JSON), marshal (Ruby marshalized hash).

Extract options: (offline) extract ciphers from external tools output file
  <filename>              The external tool output file
  <format>                Supported formats: sslyze, sslscan2, testssl, ssllabs-scan, tlsx (check the documentation for the expected file format)
  --only-weak             Show only ciphers with a security level equal to weak or insecure (hide secure and recommended) (work only with TLS not SSL).
  --hide-weak             Hide ciphers with a security level equal to weak or insecure (show only secure and recommended) (work only with TLS not SSL).

Update options: (online) DANGEROUS, will break database integrity, force option will be required
  --with-extended         (Online) Also save extended information used by search --extended option.

Other options:
  --force     Force parsing even if integrity check failed (DANGEROUS, may result in command execution vulnerability)
  --no-color  Disable colorized output
  --debug     Display arguments
  -h, --help  Show this screen
  --version   Show version
```

See [Usage](/pages/usage)

## Default usage: library

```ruby
require 'tls_map'

tm = TLSmap::App.new

# Translate from one lib to another
tm.search(:gnutls, 'RSA_ARCFOUR_128_SHA1', :iana) #=> {:iana=>"TLS_RSA_WITH_RC4_128_SHA"
tm.search(:openssl, 'AES128-SHA', :iana) #=> {:iana=>"TLS_RSA_WITH_AES_128_CBC_SHA"}
tm.search(:iana, 'TLS_DH_RSA_WITH_AES_256_CBC_SHA', :codepoint) #=> {:codepoint=>"0037"}

# Get all
tm.search(:codepoint, '1303') #=> {:codepoint=>"1303", :iana=>"TLS_CHACHA20_POLY1305_SHA256", :openssl=>"TLS_CHACHA20_POLY1305_SHA256", :gnutls=>"CHACHA20_POLY1305_SHA256", :nss=>"TLS_CHACHA20_POLY1305_SHA256"}
tm.search(:nss, 'TLS_AES_256_GCM_SHA384') #=> {:codepoint=>"1302", :iana=>"TLS_AES_256_GCM_SHA384", :openssl=>"TLS_AES_256_GCM_SHA384", :gnutls=>"AES_256_GCM_SHA384", :nss=>"TLS_AES_256_GCM_SHA384"}
```

See [Usage](/pages/usage)
