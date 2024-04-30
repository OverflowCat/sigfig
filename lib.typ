#let toPrecision(x, p) = {
  if type(p) != int {
    return x
  }
  assert(p > 0 and p <= 100)
  if type(x) != float {
    x = float(x)
  }
  let s = ""
  if x < 0 {
    s = "-"
    x = -x
  }
  let m = ""
  let e = 0
  if x == 0 {
    m = "0" * p 
    e = 0
  } else {
    e = calc.floor(calc.log(x))
    let n = calc.round(x / calc.pow(10, e - p + 1))
    m = str(n)

    if e < -6 or e >= p {
      if p != 1 {
        let a = m.at(0)
        let b = m.slice(1)
        m = a + "." + b
      }
      let c = if e > 0 {
        "+"
      } else {
        "-"
      }
      if e < 0 {
        e = -e
      }
      let d = str(e)
      return s + m + "e" + c + d
    }
  }
  if e == p - 1 {
    return s + m
  }

  m = if e >= 0 {
    m.slice(0, e + 1) + "." + m.slice(e + 1)
  } else {
    "0." + "0" * (-(e + 1)) + m
  }
  return s + m
}
