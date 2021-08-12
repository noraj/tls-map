# frozen_string_literal: true

# Ruby internal
require 'pathname'
# Project internal
require 'tls_map/version'
require 'tls_map/utils/utils'
require 'tls_map/app/iana'
require 'tls_map/app/openssl'
require 'tls_map/app/gnutls'
require 'tls_map/app/nss'
require 'tls_map/app/output'
require 'tls_map/app/extended/ciphersuiteinfo'
require 'tls_map/app/extractor/extractor'
require 'tls_map/app/cipher/cipher'

# TLS map module
module TLSmap
  # TLS mapping
  class App
    # Get the mapping of all TLS cipher suites
    # @return [Hash] mapping of all TLS cipher suites
    attr_reader :tls_map

    # Will automatically fetch source files and parse them.
    def initialize
      @iana_file = Utils.tmpfile('iana', IANA_URL)
      @openssl_file = Utils.tmpfile('openssl', OPENSSL_URL)
      @openssl_file2 = Utils.tmpfile('openssl', OPENSSL_URL2)
      @gnutls_file = Utils.tmpfile('gnutls', GNUTLS_URL)
      @nss_file = Utils.tmpfile('nss', NSS_URL)

      @tls_map = []
      parse
    end

    def parse
      parse_iana # must be first
      parse_openssl
      parse_gnutls
      parse_nss
    end

    # Search for corresponding cipher algorithms in other libraries
    # @param criteria [Symbol] The type of `term`.
    #   Accepted values: `:codepoint`, `:iana`, `:openssl`, `:gnutls`, `:nss`.
    # @param term [String] The cipher algorithm name.
    # @param output [Symbol] The corresponding type to be included in the return value.
    #   Accepted values: `:all` (default), `:codepoint`, `:iana`, `:openssl`,
    #   `:gnutls`, `:nss`.
    # @return [Hash] The corresponding type matching `term`.
    def search(criteria, term, output = :all)
      @tls_map.each do |alg|
        term = term.upcase if criteria == :codepoint
        next unless alg[criteria] == term
        return alg if output == :all

        return { output => alg[output] }
      end
      {}
    end

    # Stateless version of {App#search}.
    # @param tls_map [Hash] mapping of all TLS cipher suites returned by {tls_map}.
    # @param criteria [Symbol] Same as `criteria` from {TLSmap::App#search}
    # @param term [String] Same as `term` from {TLSmap::App#search}
    # @param output [Symbol] Same as `output` from {TLSmap::App#search}
    # @see App#search
    # @example
    #   tm = TLSmap::App.new
    #   TLSmap::App.search(tm.tls_map, :iana, 'TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256')
    #   # => {:codepoint=>"CCA9", :iana=>"TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256",
    #         :openssl=>"ECDHE-ECDSA-CHACHA20-POLY1305", :gnutls=>"ECDHE_ECDSA_CHACHA20_POLY1305",
    #         :nss=>"TLS_ECDHE_ECDSA_WITH_CHACHA20_POLY1305_SHA256"}
    #   # or to use with the Cipher class
    #   ci = TLSmap::App::Cipher.new(:iana, 'TLS_DH_anon_WITH_RC4_128_MD5', tm.tls_map)
    def self.search(tls_map, criteria, term, output = :all)
      tls_map.each do |alg|
        term = term.upcase if criteria == :codepoint
        next unless alg[criteria] == term
        return alg if output == :all

        return { output => alg[output] }
      end
      {}
    end

    # Search for corresponding cipher algorithms in other libraries in bulk
    # @param criteria [Symbol] The type of `term`.
    #   Accepted values: `:codepoint`, `:iana`, `:openssl`, `:gnutls`, `:nss`.
    # @param file [String] File containing the cipher algorithm names, one per line.
    # @param output [Symbol] The corresponding type to be included in the return value.
    #   Accepted values: `:all` (default), `:codepoint`, `:iana`, `:openssl`,
    #   `:gnutls`, `:nss`.
    # @return [Array<Hash>] The corresponding type, same as {search} return value
    #   but one per line stored in an array.
    def bulk_search(criteria, file, output = :all)
      res = []
      File.foreach(file) do |line|
        res.push(search(criteria, line.chomp, output))
      end
      res
    end

    protected :parse
  end
end
