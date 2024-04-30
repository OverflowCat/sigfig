# `sigfig`

`sigfig` is a [Typst](https://typst.app/) package for rounding numbers with significant figures and uncertainty.

## Documentation

### `round`

Similar to JavaScript's `Number.prototype.toPrecision()` ([ES spec](https://tc39.es/ecma262/multipage/numbers-and-dates.html#sec-number.prototype.toprecision)).

```typ
#assert(round(114514, 3) == "1.15e5")
#assert(round(1, 5) == "1.0000")
#assert(round(12345, 10) == "12345.00000")
#assert(round(.00000002468, 3) == "2.47e-8")
```

Note that what is different from the ES standard is that there will be no sign ($+$) if the exponent after `e` is positive.

### `uround`

```typ
#assert(uround(114514, 1919) == "1.15e5+-2e3")
#assert(uround(114514.0, 1.9) == "114514+-2")
```

### `urounds`

You can use `unify` to display the number.

```typ
#let res = urounds(114514.0, 1.9)
#import "@preview/unify:0.5.0": num
$ num(res) $
```

$$ (114514 \pm 2) $$
