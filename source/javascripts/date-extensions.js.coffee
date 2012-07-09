Date.monthNames = [ "enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre" ]
Date::getMonthName = ->
  Date.monthNames[@getMonth()]

Date.parseBloggerUrl = (url) ->
  m = url.match(/(\d+)_(\d+)_(\d+)/i)
  new Date(parseInt(m[1], 10), parseInt(m[2], 10) - 1, 1)

Date::toBlogger = (last) ->
  d = this
  y = d.getFullYear()
  m = d.getMonth() + 1
  m = (if (m < 10) then "0" else "") + m
  str = y + "-" + m + "-"
  unless last
    str + "01T00:00:00"
  else
    d.setMonth d.getMonth() + 1
    d.setDate 0
    str + d.getDate() + "T23:59:59"

