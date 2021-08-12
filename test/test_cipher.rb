# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/skip_dsl'
require 'tls_map'

class TLSmapCipherTest < Minitest::Test
  def test_Cipher
    ci = TLSmap::App::Cipher.new(:iana, 'TLS_RSA_WITH_SEED_CBC_SHA')
    assert_equal('0096', ci.codepoint)
    assert_nil(ci.gnutls)
    assert_equal('TLS_RSA_WITH_SEED_CBC_SHA', ci.iana)
    assert_equal('TLS_RSA_WITH_SEED_CBC_SHA', ci.nss)
    assert_equal('SEED-SHA', ci.openssl)
    assert_equal('SEED CBC', ci.extended['enc_algorithm'])
    assert_equal(true, ci.weak?)
    assert_equal(false, ci.should_i_use?)
    assert_equal(true, ci.vulnerable?)
  end
end
