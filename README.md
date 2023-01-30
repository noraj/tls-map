# TLS map

[![Gem Version](https://badge.fury.io/rb/tls-map.svg)](https://badge.fury.io/rb/tls-map)
![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/noraj/tls-map)
[![GitHub forks](https://img.shields.io/github/forks/noraj/tls-map)](https://github.com/noraj/tls-map/network)
[![GitHub stars](https://img.shields.io/github/stars/noraj/tls-map)](https://github.com/noraj/tls-map/stargazers)
[![GitHub license](https://img.shields.io/github/license/noraj/tls-map)](https://github.com/noraj/tls-map/blob/master/LICENSE.txt)
[![Rawsec's CyberSecurity Inventory](https://inventory.raw.pm/img/badges/Rawsec-inventoried-FF5050_flat.svg)](https://inventory.raw.pm/tools.html#TLS%20map)

[![Packaging status](https://repology.org/badge/vertical-allrepos/tls-map.svg)](https://repology.org/project/tls-map/versions)

![logo](docs/_media/logo.png)

> CLI & library for mapping TLS cipher algorithm names: IANA, OpenSSL, GnuTLS, NSS;
> get information and vulnerabilities about cipher suites;
> extract cipher suites from external tools: SSLyze, sslscan2, testssl.sh, ssllabs-scan, tlsx

**CLI**

[![asciicast](https://asciinema.org/a/410877.svg)](https://asciinema.org/a/410877)

**Library**

![library example](https://i.imgur.com/3KZgZ6b.png)

## Features

- CLI and library
- Search feature: hexadecimal codepoint and major TLS libraries cipher algorithm name: IANA, OpenSSL, GnuTLS, NSS
  - get extra info about a cipher
- Export to files: markdown table, expanded JSON, minified JSON, Ruby marshalized hash
- Extract ciphers from external tools file output (SSLyze, sslscan2, testssl.sh, ssllabs-scan, tlsx)
- Bulk search (file with one cipher per line)

## Installation

```plaintext
$ gem install tls-map
```

Check the [installation](https://noraj.github.io/tls-map/#/pages/install) page on the documentation to discover more methods.

## Documentation

Homepage / Documentation: https://noraj.github.io/tls-map/

## Author

Made by Alexandre ZANNI ([@noraj](https://pwn.by/noraj/)).
