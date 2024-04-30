#let getHighest(num) = calc.floor(calc.log(num))

#let round(x, p) = {
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
    e = getHighest(x)
    let n = calc.round(x / calc.pow(10, e - p + 1))
    m = str(n)

    if e < -6 or e >= p {
      if p != 1 {
        let a = m.at(0)
        let b = m.slice(1)
        m = a + "." + b
      }
      let c = if e > 0 {
        "" // JS uses "+"
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

#let uround(n, u) = {
  let e_u = getHighest(u)
  let e_n = getHighest(n)
  assert(e_u >= 0 and e_n >= 0)
  assert(e_u <= e_n)
  let sigfig = e_n - e_u + 1
  let uncertainty = round(u, 1)
  let value = round(n, sigfig)
  value + "+-" + uncertainty
}

#let urounds(n, u) = {
  let e_u = getHighest(u)
  let e_n = getHighest(n)
  let sigfig = e_n - e_u + 1
  let value = round(n, sigfig)

  let splitted = value.split("e")
  if splitted.len() == 2 {
    let uncertainty = calc.round(u / calc.pow(10, e_u)) * calc.pow(10, e_u - e_n)
    splitted.at(0) + "+-" + str(uncertainty) + "e" + splitted.at(1)
  } else {
    let uncertainty = round(u, 1)
    value + "+-" + str(uncertainty)
  }
}
