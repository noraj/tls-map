# frozen_string_literal: true

require_relative 'lib/tls_map/version'

Gem::Specification.new do |s|
  s.name          = 'tls-map'
  s.version       = TLSmap::VERSION
  s.platform      = Gem::Platform::RUBY
  s.summary       = 'CLI & library for TLS cipher suites manipulation'
  s.description   = 'CLI & library for mapping TLS cipher algorithm names: IANA, OpenSSL, GnuTLS, NSS;'
  s.description  += 'get information and vulnerabilities about cipher suites;'
  s.description  += 'extract cipher suites from external tools: SSLyze, sslscan2, testssl.sh, ssllabs-scan, tlsx'
  s.authors       = ['Alexandre ZANNI']
  s.email         = 'alexandre.zanni@engineer.com'
  s.homepage      = 'https://noraj.github.io/tls-map/'
  s.license       = 'MIT'

  s.files         = Dir['bin/*'] + Dir['lib/**/*.rb'] + Dir['data/*'] + ['LICENSE']
  s.bindir        = 'bin'
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.metadata = {
    'yard.run'              => 'yard',
    'bug_tracker_uri'       => 'https://github.com/noraj/tls-map/issues',
    'changelog_uri'         => 'https://github.com/noraj/tls-map/blob/master/docs/CHANGELOG.md',
    'documentation_uri'     => 'https://noraj.github.io/tls-map/yard/',
    'homepage_uri'          => 'https://noraj.github.io/tls-map/',
    'source_code_uri'       => 'https://github.com/noraj/tls-map/',
    'rubygems_mfa_required' => 'true'
  }

  s.required_ruby_version = ['>= 3.0.0', '< 4.0']

  s.add_runtime_dependency('docopt', '~> 0.6') # for argument parsing
  s.add_runtime_dependency('paint', '~> 2.2') # for colorized output
  s.add_runtime_dependency('rexml', '~> 3.2') # XML parser
end
