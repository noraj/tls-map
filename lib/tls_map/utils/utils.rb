# frozen_string_literal: true

# Ruby internal
require 'net/http'
require 'tempfile'
require 'json'

# TLS map module
module TLSmap
  # Generic utilities
  module Utils
    def self.tmpfile(name, url)
      tmp = Tempfile.new(name)
      tmp.write(Net::HTTP.get(URI(url)))
      tmp.close
      tmp
    end
  end
end
