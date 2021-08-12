# frozen_string_literal: false

require 'minitest/autorun'
require 'minitest/skip_dsl'
require 'tls_map'
require 'tls_map/cli/cli'

class TLSmapCLITest < Minitest::Test
  def test_CLI
    assert(TLSmap::CLI.new)
  end

  def test_CLI_Extended
    assert(TLSmap::CLI::Extended.new)
  end
end
