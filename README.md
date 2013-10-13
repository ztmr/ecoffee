# CoffeeScript for Erlang
```Erlang
erl> ecoffee:compile (<<"console.log 'hello!'">>).
{ok,<<"(function() {\n  console.log('hello!');\n\n}).call(this);\n">>}
```

# TODO and known issues
- get rid of repetitive creating/destroying JS driver, make a pool of constantly running workers rather
- integration with euglifyjs to return compressed output (via `{minimize, true}` config option)
