# Examples

## CLI

### Search

Search for the IANA value of `RSA_ARCFOUR_128_SHA1` (GnuTLS):

```
$ tls-map search gnutls RSA_ARCFOUR_128_SHA1 -o iana
iana: TLS_RSA_WITH_RC4_128_SHA
```

Search for the IANA value of `AES128-SHA` (OpenSSL):

```
$ tls-map search openssl AES128-SHA -o iana
iana: TLS_RSA_WITH_AES_128_CBC_SHA
```

Search for the hexadecimal codepoint of `TLS_DH_RSA_WITH_AES_256_CBC_SHA-SHA` (IANA):

```
$ tls-map search iana TLS_DH_RSA_WITH_AES_256_CBC_SHA -o codepoint
codepoint: 0037
```

Get all values corresponding to codepoint `1303`:

```
$ tls-map search codepoint 1303
codepoint: 1303
iana: TLS_CHACHA20_POLY1305_SHA256
openssl: TLS_CHACHA20_POLY1305_SHA256
gnutls: CHACHA20_POLY1305_SHA256
nss: TLS_CHACHA20_POLY1305_SHA256
```

Get all values corresponding to NSS cipher algorithm `TLS_AES_256_GCM_SHA384`:

```
$ tls-map search nss TLS_AES_256_GCM_SHA384
codepoint: 1302
iana: TLS_AES_256_GCM_SHA384
openssl: TLS_AES_256_GCM_SHA384
gnutls: AES_256_GCM_SHA384
nss: TLS_AES_256_GCM_SHA384
```

Display extended information (online):

```
$ tls-map search -e codepoint 0013
codepoint: 0013
iana: TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA
openssl: DHE-DSS-DES-CBC3-SHA
gnutls: DHE_DSS_3DES_EDE_CBC_SHA1
nss: TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA
Protocol: TLS
Key Exchange: DHE
Authentication: DSS
Encryption: 3DES EDE CBC
Hash: SHA
Security: weak
TLS Version(s): TLS1.0, TLS1.1
Vulnerabilities:
  - Medium - While Triple-DES is still recognized as a secure symmetric-key encryption, a more and more standardizations bodies and projects decide to deprecate this algorithm. Though not broken, it has been proven to suffer from several vulnerabilities in the past (see [sweet32.info](https://sweet32.info)).
  - Medium - In 2013, researchers demonstrated a timing attack against several TLS implementations using the CBC encryption algorithm (see [isg.rhul.ac.uk](http://www.isg.rhul.ac.uk/tls/Lucky13.html)). Additionally, the CBC mode is vulnerable to plain-text attacks in TLS 1.0, SSL 3.0 and lower. A fix has been introduced with TLS 1.2 in form of the GCM mode which is not vulnerable to the BEAST attack. GCM should be preferred over CBC.
  - Medium - The Secure Hash Algorithm 1 has been proven to be insecure as of 2017 (see [shattered.io](https://shattered.io)).
More info: https://ciphersuite.info/cs/TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA/
```

Display extended information (online) with full acronym name:

```
$ tls-map search -e codepoint 0013 -a
codepoint: 0013
iana: TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA
openssl: DHE-DSS-DES-CBC3-SHA
gnutls: DHE_DSS_3DES_EDE_CBC_SHA1
nss: TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA
Protocol: TLS (Transport Layer Security)
Key Exchange: DHE (Diffie-Hellman Ephemeral)
Authentication: DSS (Digital Signature Standard)
Encryption: 3DES EDE CBC (Triple-DES (Encrypt Decrypt Encrypt) in Cipher Block Chaining mode)
Hash: SHA (Secure Hash Algorithm 1)
Security: weak
TLS Version(s): TLS1.0, TLS1.1
Vulnerabilities:
  - Medium - While Triple-DES is still recognized as a secure symmetric-key encryption, a more and more standardizations bodies and projects decide to deprecate this algorithm. Though not broken, it has been proven to suffer from several vulnerabilities in the past (see [sweet32.info](https://sweet32.info)).
  - Medium - In 2013, researchers demonstrated a timing attack against several TLS implementations using the CBC encryption algorithm (see [isg.rhul.ac.uk](http://www.isg.rhul.ac.uk/tls/Lucky13.html)). Additionally, the CBC mode is vulnerable to plain-text attacks in TLS 1.0, SSL 3.0 and lower. A fix has been introduced with TLS 1.2 in form of the GCM mode which is not vulnerable to the BEAST attack. GCM should be preferred over CBC.
  - Medium - The Secure Hash Algorithm 1 has been proven to be insecure as of 2017 (see [shattered.io](https://shattered.io)).
More info: https://ciphersuite.info/cs/TLS_DHE_DSS_WITH_3DES_EDE_CBC_SHA/
```

### Export

Export to minified JSON:

```
$ tls-map export /tmp/map.min.json json_compact
/tmp/map.min.json exported
```

See [Usage](/pages/usage#CLI) for other formats.

### Extract

Extract ciphers from external tools output file.
SSLyze, sslscan2, testssl.sh, ssllabs-scan are supported, see the [library documentation](https://noraj.github.io/tls-map/yard/TLSmap/App/Extractor) for expected file format.

```
$ tls-map extract newwebsite.json ssllabs-scan
TLS1.2
TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256
TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
TLS1.3
TLS_AES_256_GCM_SHA384
TLS_CHACHA20_POLY1305_SHA256
TLS_AES_128_GCM_SHA256

$ tls-map extract oldwebsite.json ssllabs-scan
SSL2.0
SSL_CK_RC4_128_WITH_MD5
SSL_CK_DES_192_EDE3_CBC_WITH_MD5
SSL3.0
TLS_RSA_WITH_3DES_EDE_CBC_SHA
TLS_RSA_WITH_RC4_128_SHA
TLS_RSA_WITH_RC4_128_MD5
TLS1.0
TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA
TLS_DHE_RSA_WITH_AES_256_CBC_SHA
TLS_DHE_RSA_WITH_AES_128_CBC_SHA
TLS_RSA_WITH_AES_256_CBC_SHA
TLS_RSA_WITH_AES_128_CBC_SHA
TLS_RSA_WITH_3DES_EDE_CBC_SHA
TLS_RSA_WITH_RC4_128_SHA
TLS_RSA_WITH_RC4_128_MD5
```

Hide weak cipher suites while extracting (show only strong ones):

```
$ tls-map extract test/file_sample/testssl.json testssl --hide-weak
TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
TLS_DHE_RSA_WITH_AES_256_GCM_SHA384
TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
TLS_DHE_RSA_WITH_AES_128_GCM_SHA256
TLS_AES_256_GCM_SHA384
TLS_CHACHA20_POLY1305_SHA256
TLS_AES_128_GCM_SHA256
```

Show only weak cipher suites while extracting:

```
$ tls-map extract test/file_sample/sslyze.json sslyze --only-weak
TLS_RSA_WITH_SEED_CBC_SHA
TLS_RSA_WITH_CAMELLIA_256_CBC_SHA
TLS_RSA_WITH_CAMELLIA_128_CBC_SHA
TLS_RSA_WITH_AES_256_CBC_SHA
TLS_RSA_WITH_AES_128_CBC_SHA
TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA
TLS_DHE_RSA_WITH_SEED_CBC_SHA
TLS_DHE_RSA_WITH_CAMELLIA_256_CBC_SHA
TLS_DHE_RSA_WITH_CAMELLIA_128_CBC_SHA
TLS_DHE_RSA_WITH_AES_256_CBC_SHA
TLS_DHE_RSA_WITH_AES_128_CBC_SHA
TLS_RSA_WITH_SEED_CBC_SHA
TLS_RSA_WITH_CAMELLIA_256_CBC_SHA
TLS_RSA_WITH_CAMELLIA_128_CBC_SHA
TLS_RSA_WITH_AES_256_CBC_SHA
TLS_RSA_WITH_AES_128_CBC_SHA
TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA
TLS_DHE_RSA_WITH_SEED_CBC_SHA
TLS_DHE_RSA_WITH_CAMELLIA_256_CBC_SHA
TLS_DHE_RSA_WITH_CAMELLIA_128_CBC_SHA
TLS_DHE_RSA_WITH_AES_256_CBC_SHA
TLS_DHE_RSA_WITH_AES_128_CBC_SHA
TLS_RSA_WITH_SEED_CBC_SHA
TLS_RSA_WITH_CAMELLIA_256_CBC_SHA
TLS_RSA_WITH_CAMELLIA_128_CBC_SHA
TLS_RSA_WITH_AES_256_CBC_SHA
TLS_RSA_WITH_AES_128_GCM_SHA256
TLS_RSA_WITH_AES_128_CBC_SHA
TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA
TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256
TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA
TLS_DHE_RSA_WITH_SEED_CBC_SHA
TLS_DHE_RSA_WITH_CAMELLIA_256_CBC_SHA
TLS_DHE_RSA_WITH_CAMELLIA_128_CBC_SHA
TLS_DHE_RSA_WITH_AES_256_CBC_SHA256
TLS_DHE_RSA_WITH_AES_256_CBC_SHA
TLS_DHE_RSA_WITH_AES_128_CBC_SHA256
TLS_DHE_RSA_WITH_AES_128_CBC_SHA
```

### Update

The CLI is working with an offline database (Marshaled Ruby hash) to avoid
fetching and parsing all source file at each execution.
If you want up to date values but do not want to wait for an official new
release of TLS map you can use the update command.
Doing so you will override `data/mapping.marshal` but for security purpose
and integrity check is done so if the file is modified the tool will refuse to
word so you have to use the `--force` option every time to bypass the security
check. So it is recommended to not use the update command and wait for official
release.

### Bulk search

Search and translate cipher names between SSL/TLS libraries **in bulk**

`test/file_sample/bulk_IANA.txt`

```
TLS_DH_RSA_WITH_AES_256_CBC_SHA
TLS_RSA_WITH_RC4_128_SHA
TLS_RSA_WITH_AES_128_CBC_SHA
TLS_INVALID
TLS_CHACHA20_POLY1305_SHA256
TLS_AES_256_GCM_SHA384
```

```
$ tls-map bulk iana test/file_sample/bulk_IANA.txt -q openssl
DH-RSA-AES256-SHA
RC4-SHA
AES128-SHA

TLS_CHACHA20_POLY1305_SHA256
TLS_AES_256_GCM_SHA384
```

## Library

Basic usage, searching for cipher name equivalent in other libraries.

```ruby
require 'tls_map'

tm = TLSmap::App.new

# Translate from one lib to another
tm.search(:gnutls, 'RSA_ARCFOUR_128_SHA1', :iana) #=> {:iana=>"TLS_RSA_WITH_RC4_128_SHA"}
tm.search(:openssl, 'AES128-SHA', :iana) #=> {:iana=>"TLS_RSA_WITH_AES_128_CBC_SHA"}
tm.search(:iana, 'TLS_DH_RSA_WITH_AES_256_CBC_SHA', :codepoint) #=> {:codepoint=>"0037"}

# Get all
tm.search(:codepoint, '1303') #=> {:codepoint=>"1303", :iana=>"TLS_CHACHA20_POLY1305_SHA256", :openssl=>"TLS_CHACHA20_POLY1305_SHA256", :gnutls=>"CHACHA20_POLY1305_SHA256", :nss=>"TLS_CHACHA20_POLY1305_SHA256"}
tm.search(:nss, 'TLS_AES_256_GCM_SHA384') #=> {:codepoint=>"1302", :iana=>"TLS_AES_256_GCM_SHA384", :openssl=>"TLS_AES_256_GCM_SHA384", :gnutls=>"AES_256_GCM_SHA384", :nss=>"TLS_AES_256_GCM_SHA384"}
```

Usage of the `Extended` class to get advanced information about a cipher
(online feature).

```ruby
require 'tls_map'

# tm = TLSmap::CLI.new # (Offline)
tm = TLSmap::App.new # (Online)

# Translate from one lib to another
cipher = tm.search(:gnutls, 'RSA_ARCFOUR_128_SHA1', :iana)
# => {:iana=>"TLS_RSA_WITH_RC4_128_SHA"}

tmext = TLSmap::App::Extended.new

# Fetch extended info (online
tmext.extend(cipher[:iana])
# =>
# {"protocol_version"=>"TLS",
#  "kex_algorithm"=>"RSA",
#  "auth_algorithm"=>"RSA",
#  "enc_algorithm"=>"RC4 128",
#  "hash_algorithm"=>"SHA",
#  "security"=>"insecure",
#  "tls_version"=>["TLS1.0", "TLS1.1", "TLS1.2"],
#  "vulns"=>
#   [{:severity=>1,
#     :description=>
#      "This key exchange algorithm does not support Perfect Forward Secrecy (PFS) which is recommended, so attackers cannot decrypt # the complete communication stream."},
#    {:severity=>2,
#     :description=>
#      "IETF has officially prohibited RC4 for use in TLS in RFC 7465. Therefore, it can be considered insecure."},
#    {:severity=>1,
#     :description=>
#      "The Secure Hash Algorithm 1 has been proven to be insecure as of 2017 (see [shattered.io](https://shattered.io))."}],
#  "url"=>"https://ciphersuite.info/cs/TLS_RSA_WITH_RC4_128_SHA/"})

# Resolve acronyms
tmext.translate_acronym('RSA')
# => "Rivest Shamir Adleman algorithm"

# Find vulnerabilities related to a technologiy
tmext.find_vuln('MD5')
# =>
# [{:severity=>2,
#   :description=>
#    "The Message Digest 5 algorithm suffers form multiple vulnerabilities and is considered insecure."}]

tmext.find_vuln('DES CBC')
# =>
# [{:severity=>2,
#   :description=>
#    "DES is considered weak, primarily due to its short key-lengths of 40 or 65-Bit. Furthermore, it has been withdrawn as a # standard by the National Institute of Standards and Technology in 2005."},
#  {:severity=>1,
#   :description=>
#    "In 2013, researchers demonstrated a timing attack against several TLS implementations using the CBC encryption algorithm (see [isg.rhul.ac.uk](http://www.isg.rhul.ac.uk/tls/Lucky13.html)). Additionally, the CBC mode is vulnerable to plain-text attacks in TLS 1.0, SSL 3.0 and lower. A fix has been introduced with TLS 1.2 in form of the GCM mode which is not vulnerable to the BEAST attack. GCM should be preferred over CBC."}]
```

Extract ciphers from external tools output file.
SSLyze, sslscan2, testssl.sh, ssllabs-scan are supported, see the [library documentation](https://noraj.github.io/tls-map/yard/TLSmap/App/Extractor).

```ruby
require 'tls_map'

extractor = TLSmap::App::Extractor.new

# Parse the file
extractor.parse('ssllabs-scan', 'oldwebsite.json')

# Access to all extracted ciphers
extractor.ciphers
=>
# {"SSL2.0"=>["SSL_CK_RC4_128_WITH_MD5", "SSL_CK_DES_192_EDE3_CBC_WITH_MD5"],
#  "SSL3.0"=>["TLS_RSA_WITH_3DES_EDE_CBC_SHA", "TLS_RSA_WITH_RC4_128_SHA", "TLS_RSA_WITH_RC4_128_MD5"],
#  "TLS1.0"=>
#   ["TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA",
#    "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA",
#    "TLS_DHE_RSA_WITH_AES_256_CBC_SHA",
#    "TLS_DHE_RSA_WITH_AES_128_CBC_SHA",
#    "TLS_RSA_WITH_AES_256_CBC_SHA",
#    "TLS_RSA_WITH_AES_128_CBC_SHA",
#    "TLS_RSA_WITH_3DES_EDE_CBC_SHA",
#    "TLS_RSA_WITH_RC4_128_SHA",
#    "TLS_RSA_WITH_RC4_128_MD5"],
#  "TLS1.1"=>[],
#  "TLS1.2"=>[],
#  "TLS1.3"=>[]}

# Access only SSL 2.0 ciphers
extractor.ssl20
# => ["SSL_CK_RC4_128_WITH_MD5", "SSL_CK_DES_192_EDE3_CBC_WITH_MD5"]
```

Search and translate cipher names between SSL/TLS libraries **in bulk**:

```ruby
require 'tls_map'

tm = TLSmap::App.new

tm.bulk_search(:iana, 'test/file_sample/bulk_IANA.txt', :openssl)
# => [{:openssl=>"DH-RSA-AES256-SHA"}, {:openssl=>"RC4-SHA"}, {:openssl=>"AES128-SHA"}, {}, {:openssl=>"TLS_CHACHA20_POLY1305_SHA256"}, {:openssl=>"TLS_AES_256_GCM_SHA384"}]

tm.bulk_search(:iana, 'test/file_sample/bulk_IANA.txt', :codepoint)
# => [{:codepoint=>"0037"}, {:codepoint=>"0005"}, {:codepoint=>"002F"}, {}, {:codepoint=>"1303"}, {:codepoint=>"1302"}]

tm.bulk_search(:iana, 'test/file_sample/bulk_IANA.txt')
# =>
# [{:codepoint=>"0037", :iana=>"TLS_DH_RSA_WITH_AES_256_CBC_SHA", :openssl=>"DH-RSA-AES256-SHA", :gnutls=>nil, # :nss=>"TLS_DH_RSA_WITH_AES_256_CBC_SHA"},
#  {:codepoint=>"0005", :iana=>"TLS_RSA_WITH_RC4_128_SHA", :openssl=>"RC4-SHA", :gnutls=>"RSA_ARCFOUR_128_SHA1", # :nss=>"TLS_RSA_WITH_RC4_128_SHA"},
#  {:codepoint=>"002F", :iana=>"TLS_RSA_WITH_AES_128_CBC_SHA", :openssl=>"AES128-SHA", :gnutls=>"RSA_AES_128_CBC_SHA1", # :nss=>"TLS_RSA_WITH_AES_128_CBC_SHA"},
#  {},
#  {:codepoint=>"1303", :iana=>"TLS_CHACHA20_POLY1305_SHA256", :openssl=>"TLS_CHACHA20_POLY1305_SHA256", # :gnutls=>"CHACHA20_POLY1305_SHA256", :nss=>"TLS_CHACHA20_POLY1305_SHA256"},
#  {:codepoint=>"1302", :iana=>"TLS_AES_256_GCM_SHA384", :openssl=>"TLS_AES_256_GCM_SHA384", :gnutls=>"AES_256_GCM_SHA384", # :nss=>"TLS_AES_256_GCM_SHA384"}]
```

Manipulate a cipher suite:

```ruby
require 'tls_map'

ci = TLSmap::App::Cipher.new(:iana, 'TLS_RSA_WITH_SEED_CBC_SHA')

# Get the OpenSSL name
ci.openssl
# => "SEED-SHA"

# Try to get the GnuTLS one (output is nil because it's not implemented in GnuTLS)
ci.gnutls
# => nil

# Some boolean checker
ci.weak?
# => true
ci.vulnerable?
# => true
ci.should_i_use?
# => false

# Get the vulnerabilities
ci.extended['vulns']
# =>
# [{:severity=>1, :description=>"This key exchange algorithm does not support Perfect Forward Secrecy (PFS) which is recommended, so attackers cannot decrypt the complete communication stream."},
#  {:severity=>1,
#   :description=>
#    "In 2013, researchers demonstrated a timing attack against several TLS implementations using the CBC encryption algorithm (see [isg.rhul.ac.uk](http://www.isg.rhul.ac.uk/tls/Lucky13.html)). Additionally, the CBC mode is vulnerable to plain-text attacks in TLS 1.0, SSL 3.0 and lower. A fix has been introduced with TLS 1.2 in form of the GCM mode which is not vulnerable to the BEAST attack. GCM should be preferred over CBC."},
#  {:severity=>1, :description=>"The Secure Hash Algorithm 1 has been proven to be insecure as of 2017 (see [shattered.io](https://shattered.io))."}]

# Get the TLS version it is implemented in
ci.extended['tls_version']
# => ["TLS1.0", "TLS1.1", "TLS1.2"]
```

By default the `Cipher` class will use the offline database for TLS library
conversions (eg. OpenSSL to IANA name) and online API call to retrieve
advanced information such as the details about key exchange algorithm, authentication algorithm,
vulnerabilities, etc.

Bulk usage of cipher manipulation can be slow if we use the regular way to get
advanced information (online),
because we will have to make one HTTP request per cipher suite. 

One solution is to pre-feed the `Cipher` class with one fetch-all call to the API.
This way we still have the most up-to-date data.

```ruby
require 'tls_map'

# Get ONCE the advanced data about all cipher suites
tmext = TLSmap::App::Extended.new
tmext.enhance_all
# Note: The data is accessible via tmext.enhanced_data

# Now each time we want to manipulate a cipher we can feed the Cipher
# class with the pre-fetched data.
# If we have to use this in a loop for hundreds or thousands of cipher suites
# there is no new HTTP call.
ci = TLSmap::App::Cipher.new(:iana, 'TLS_DH_anon_WITH_RC4_128_MD5', enhanced_data: tmext.enhanced_data)
ci.insecure?
# => true
```

Another solution which has even better performance is to use the offline database
to pre-feed the `Cipher` class.

```ruby
require 'tls_map'

# Load advanced data from the offline database
cliext = TLSmap::CLI::Extended.new

# Load pre-fetched data into the Cipher class
ci = TLSmap::App::Cipher.new(:iana, 'TLS_DH_anon_WITH_RC4_128_MD5', enhanced_data: cliext.enhanced_data)
```

Of course if you have only to access TLS names you don't need to bother with that
because advanced information are not fetch during the initialization but only when
a method needing it is called.

But at the contrary, the `Cipher` class is using the offline database for TLS
name by default to have a decent execution time, but if you want to be sure to
have the latest data available (directly fetched from upstream DVCS) you can
pre-fetch and feed the `Cipher` class too in a manner similar to what we did
earlier with the advanced data.

```ruby
require 'tls_map'

# Pre-fetch basic TLS data from the main class
tm = TLSmap::App.new

# Feed it into the cipher class
ci = TLSmap::App::Cipher.new(:iana, 'TLS_DH_anon_WITH_RC4_128_MD5', tls_map: tm.tls_map)
```
