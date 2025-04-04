# frozen_string_literal: true

# Ruby internal
require 'digest'

# TLS map module
module TLSmap
  # Offline version of {App}
  class CLI < App
    INTEGRITY = 'a04956498a5838c5f55cc58f255bd143a646826c8e709048d17e7d09adae0b4e' # sha2-256

    # Load and parse data from marshalized hash (`data/mapping.marshal`).
    # It must match the integrity check for security purpose.
    # @param force [Boolean] Force parsing even if integrity check failed (DANGEROUS,
    #   may result in command execution vulnerability)
    def initialize(force = false)
      @storage_location = 'data/'
      @database_path = absolute_db_path('mapping.marshal')
      database_exists?
      @tls_map = []
      parse(force)
    end

    # Find the absolute path of the a data file from its relative location
    # @param filename [String] file name
    # @return [String] absolute filename of the data file
    def absolute_db_path(filename)
      pn = Pathname.new(__FILE__)
      install_dir = pn.dirname.parent.parent.parent.to_s + Pathname::SEPARATOR_LIST
      install_dir + @storage_location + filename
    end

    # Check if the TLS database DB exists
    # @return [Boolean] `true` if the file exists
    def database_exists?
      exists = File.file?(@database_path)
      raise "Database does not exist: #{@database_path}" unless exists

      exists
    end

    def parse(force = false)
      if Digest::SHA256.file(@database_path).hexdigest == INTEGRITY || force # rubocop:disable Style/GuardClause
        @tls_map = Marshal.load(File.read(@database_path)) # rubocop:disable Security/MarshalLoad
      else
        raise 'Integrity check failed, maybe be due to unvalidated database after update'
      end
    end

    def update
      tm = TLSmap::App.new
      tm.export(@database_path, :marshal)
    end

    protected :database_exists?, :absolute_db_path, :parse

    # Offline version of {App::Extended}
    class Extended < App::Extended
      INTEGRITY = '3236733f1d5b69f4230adaa726faeb2f4ba4e88aa59a72880cc822c43ed37b73' # sha2-256

      # Load and parse data from marshalized hash (`data/extended.marshal`).
      # It must match the integrity check for security purpose.
      # @param force [Boolean] Force parsing even if integrity check failed (DANGEROUS,
      #   may result in command execution vulnerability)
      def initialize(force = false)
        @storage_location = 'data/'
        @extended_path = absolute_db_path('extended.marshal')
        @enhanced_data = {}
        extended_exists?
        parse(force)
      end

      # Find the absolute path of the a data file from its relative location
      # @param filename [String] file name
      # @return [String] absolute filename of the data file
      def absolute_db_path(filename)
        pn = Pathname.new(__FILE__)
        install_dir = pn.dirname.parent.parent.parent.to_s + Pathname::SEPARATOR_LIST
        install_dir + @storage_location + filename
      end

      # Check if the extended DB exists
      # @return [Boolean] `true` if the files exists
      def extended_exists?
        exists = File.file?(@extended_path)
        raise "Database does not exist: #{@extended_path}" unless exists

        exists
      end

      def parse(force = false)
        if Digest::SHA256.file(@extended_path).hexdigest == INTEGRITY || force # rubocop:disable Style/GuardClause
          @enhanced_data = Marshal.load(File.read(@extended_path)) # rubocop:disable Security/MarshalLoad
        else
          raise 'Integrity check failed, maybe be due to unvalidated database after update'
        end
      end

      def update
        tmext = TLSmap::App::Extended.new
        tmext.enhance_all
        File.write(@extended_path, Marshal.dump(tmext.enhanced_data))
      end

      # Same as {App::Extended} but loading data from offline database, so there
      # is no caching option.
      # @see App::Extended
      def extend(iana_name)
        @enhanced_data[iana_name]
      end

      protected :extended_exists?, :absolute_db_path, :parse
      undef_method :enhance_all, :fetch_ciphersuite, :parse_tech, :parse_vuln
    end
  end
end
