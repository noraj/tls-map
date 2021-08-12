# frozen_string_literal: true

# Project internal
require 'tls_map/cli/cli'

module TLSmap
  # TLS mapping
  class App
    # Manipulate cipher suite information
    class Cipher
      # Get the hexadecimal codepoint of the cipher suite
      # @return [String] Hexadecimal codepoint
      attr_reader :codepoint

      # Get the IANA name of the cipher suite
      # @return [String] IANA name
      attr_reader :iana

      # Get the OpenSSL name of the cipher suite
      # @return [String] OpenSSL name
      attr_reader :openssl

      # Get the GnuTLS name of the cipher suite
      # @return [String] GnuTLS name
      attr_reader :gnutls

      # Get the NSS name of the cipher suite
      # @return [String] NSS name
      attr_reader :nss

      # Get extended information
      # @!attribute [r] extended
      # @return [Hash]
      # @example
      #   ci = TLSmap::App::Cipher.new(:iana, 'TLS_RSA_WITH_SEED_CBC_SHA')
      #   ci.extended
      #   # =>
      #   # {"protocol_version"=>"TLS",
      #   #  "kex_algorithm"=>"RSA",
      #   #  "auth_algorithm"=>"RSA",
      #   #  "enc_algorithm"=>"SEED CBC",
      #   #  "hash_algorithm"=>"SHA",
      #   #  "security"=>"weak",
      #   #  "tls_version"=>["TLS1.0", "TLS1.1", "TLS1.2"],
      #   #  "vulns"=>
      #   #   [{:severity=>1, :description=>"This key exchange algorithm does not support Perfect Forward Secrecy (PFS)
      #   #   which is recommended, so attackers cannot decrypt the complete communication stream."},
      #   #    {:severity=>1,
      #   #     :description=>
      #   #      "In 2013, researchers demonstrated a timing attack against several TLS implementations using the CBC
      #   #      encryption algorithm (see [isg.rhul.ac.uk](http://www.isg.rhul.ac.uk/tls/Lucky13.html)). Additionally,
      #   #      the CBC mode is vulnerable to plain-text attacks in TLS 1.0, SSL 3.0 and lower. A fix has been
      #   #      introduced with TLS 1.2 in form of the GCM mode which is not vulnerable to the BEAST attack. GCM should
      #   #      be preferred over CBC."},
      #   #    {:severity=>1, :description=>"The Secure Hash Algorithm 1 has been proven to be insecure as of 2017 (see
      #   #      [shattered.io](https://shattered.io))."}],
      #   #  "url"=>"https://ciphersuite.info/cs/TLS_RSA_WITH_SEED_CBC_SHA/"}
      def extended
        fetch_extended
        @extended
      end

      # Initialize {TLSmap::App::Cipher} instance
      # @param type [Symbol] Same as `criteria` from {TLSmap::App#search}
      # @param value [String] Same as `term` from {TLSmap::App#search}
      # @param opts [Hash] the option hash
      # @option opts [Hash] :tls_map mapping of all TLS cipher suites returned by {App#tls_map}.
      #   (better performance for batch usage)
      # @option opts [Hash] :enhanced_data enhanced information of all cipher suites returned by
      #   {Extended#enhanced_data}. (better performance for batch usage)
      # @example
      #   # Offline TLS data + online extended data
      #   ci = TLSmap::App::Cipher.new(:iana, 'TLS_DH_anon_WITH_RC4_128_MD5')
      #   # Online TLS data + online extended data
      #   tm = TLSmap::App.new
      #   ci = TLSmap::App::Cipher.new(:iana, 'TLS_DH_anon_WITH_RC4_128_MD5', tls_map: tm.tls_map)
      #   # Offline TLS data + online extended data but more efficient for batch requesting
      #   tmext = TLSmap::App::Extended.new
      #   tmext.enhance_all
      #   ci = TLSmap::App::Cipher.new(:iana, 'TLS_DH_anon_WITH_RC4_128_MD5', enhanced_data: tmext.enhanced_data)
      #   # Offline TLS data + offline extended data (better performance but may be outdated)
      #   cliext = TLSmap::CLI::Extended.new
      #   ci = TLSmap::App::Cipher.new(:iana, 'TLS_DH_anon_WITH_RC4_128_MD5', enhanced_data: cliext.enhanced_data)
      def initialize(type, value, opts = {}) # rubocop:disable Metrics/MethodLength
        res = if opts[:tls_map].nil?
                TLSmap::CLI.new.search(type, value)
              else
                TLSmap::App.search(opts[:tls_map], type, value)
              end
        @codepoint = res[:codepoint]
        @iana = res[:iana]
        @openssl = res[:openssl]
        @gnutls = res[:gnutls]
        @nss = res[:nss]
        @extended = opts.dig(:enhanced_data, @iana)
      end

      # Retrieve extended data by using #{App:Extended}
      def fetch_extended
        return unless @extended.nil?

        tmext = TLSmap::App::Extended.new
        @extended = tmext.extend(@iana)
      end

      # Is the security level defined to `weak`?
      # @return [Boolean]
      def weak?
        fetch_extended
        @extended['security'] == 'weak'
      end

      # Is the security level defined to `insecure`?
      # @return [Boolean]
      def insecure?
        fetch_extended
        @extended['security'] == 'insecure'
      end

      # Is the security level defined to `secure`?
      # @return [Boolean]
      def secure?
        fetch_extended
        @extended['security'] == 'secure'
      end

      # Is the security level defined to `recommended`?
      # @return [Boolean]
      def recommended?
        fetch_extended
        @extended['security'] == 'recommended'
      end

      # Is the security level defined to `secure` or `recommended`?
      # It will return `false` for `weak` and `insecure` cipher suites.
      # @return [Boolean]
      def should_i_use?
        recommended? || secure?
      end

      # Is the cipher suite vulnerable?
      # @return [Boolean] `true` if one (or more) vulnerability is declared
      def vulnerable?
        fetch_extended
        !@extended['vulns'].empty?
      end

      protected :fetch_extended
    end
  end
end
