# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in .gemspec
gemspec

# Needed for the CLI only
group :runtime, :cli do
  gem 'docopt', '~> 0.6' # for argument parsing
  gem 'paint', '~> 2.3' # for colorized ouput
end

# Needed for the CLI & library
group :runtime, :all do
  gem 'csv', '~> 3.3' # parse and generate CSV
  gem 'rexml', '~> 3.4' # XML parser
end

# Needed to install dependencies
group :development, :install do
  gem 'bundler', '~> 2.1'
end

# Needed to run tests
group :development, :test do
  gem 'minitest', '~> 5.25'
  gem 'minitest-skip', '~> 0.0' # skip dummy tests
  gem 'rake', '~> 13.3'
end

# Needed for linting
group :development, :lint do
  gem 'rubocop', '~> 1.77'
end

group :development, :docs do
  gem 'commonmarker', '~> 2.0' # for markdown support in YARD
  # gem 'yard', ['>= 0.9.27', '< 0.10']
  # https://github.com/lsegal/yard/issues/1528
  gem 'yard', github: 'ParadoxV5/yard', ref: '9e869c940859570b07b81c5eadd6070e76f6291e', branch: 'commonmarker-1.0'
  gem 'yard-coderay', '~> 0.1' # for syntax highlight support in YARD
end
