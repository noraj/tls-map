# Publishing

Change version in `lib/tls_map/version.rb`.

Be sure all tests pass!

```bash
bundle exec rake test
```

Ensure there is no linting offence.

```bash
bundle exec rubocop
```

Update `data/mapping.marshal` and `data/extended.marshal`:

```bash
bundle exec ruby -Ilib -rtls_map bin/tls-map update --with-extended
```

Update `INTEGRITY` of `TLSmap::CLI` and `TLSmap::CLI::Extended` in `lib/tls_map/cli/cli.rb`.

```bash
sha256sum data/*.marshal
```

Update other files:

```bash
bundle exec ruby -Ilib -rtls_map bin/tls-map export data/mapping.json json_pretty
bundle exec ruby -Ilib -rtls_map bin/tls-map export data/mapping.min.json json_compact
bundle exec ruby -Ilib -rtls_map bin/tls-map export data/mapping.md markdown
```

Update the table in `docs/pages/mapping.md`.

Don't forget to rebuild the library documentation:

```bash
bundle exec yard doc
```

Push git tag and the gem on Rubygems.

```bash
git tag -a vx.x.x
git push --follow-tags

bundle exec rake build
gem push tls-map-x.x.x.gem
```

See https://guides.rubygems.org/publishing/.

