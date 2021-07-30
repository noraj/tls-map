# Documentation 

## CLI doc

See [Usage](pages/usage.md?id=cli).

### Serve locally

```plaintext
$ npm i docsify-cli -g
$ docsify serve docs
```

Documentation available at: http://localhost:3000/

## Library doc

The output directory of the library documentation will be `docs/yard`.

You can consult it online on [GitHub](https://noraj.github.io/tls-map/yard/) or on [RubyDoc](https://www.rubydoc.info/gems/tls-map/).

### Building locally: for library users

For developers who only want to use the library.

```plaintext
$ bundle exec yard doc
```

### Serve locally

Serve with live reload:

```
$ bundle exec yard server --reload
```

Documentation available at: http://localhost:8808/
