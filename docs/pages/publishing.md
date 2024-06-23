# Publishing

## On Rubygems.org

```plaintext
$ git tag -a vx.x.x
$ git push --follow-tags
$ gem push tls-map-x.x.x.gem
```

See https://guides.rubygems.org/publishing/.

On new release don't forget to rebuild the library documentation:

```plaintext
$ bundle exec yard doc
```

And to be sure all tests pass!

```plaintext
$ rake test
```

## On BlackArch

BA process

On new release don't forget to rebuild the library documentation:

```plaintext
$ bundle exec yard doc
```

And to be sure all tests pass!

```plaintext
$ rake test
```

## Update data

Update `data/mapping.marshal` and `data/extended.marshal`:

```
$ bundle exec ruby -Ilib -rtls_map bin/tls-map update --with-extended
```

Update `INTEGRITY` of `TLSmap::CLI` and `TLSmap::CLI::Extended` in `lib/tls_map/cli/cli.rb`.

```
$ sha256sum data/*.marshal
```

Update other files:

```
$ bundle exec ruby -Ilib -rtls_map bin/tls-map export data/mapping.json json_pretty
$ bundle exec ruby -Ilib -rtls_map bin/tls-map export data/mapping.min.json json_compact
$ bundle exec ruby -Ilib -rtls_map bin/tls-map export data/mapping.md markdown
```

Update the table in `docs/pages/mapping.md`.
