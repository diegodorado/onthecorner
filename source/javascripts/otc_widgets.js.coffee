
prefs = new gadgets.Prefs()
posts_count = prefs.getInt('posts_count')
year = prefs.getInt('year')
month = prefs.getInt('month')

title = 'los ' + posts_count + ' más comentados '


if month is 0 
  published_min = year+"-01-01T00:00:00"
  published_max = year+"-12-31T23:59:59"
  title += 'del ' + year
else
  d = new Date(year, month - 1, 1)
  published_min = d.toBlogger()
  published_max = d.toBlogger(1)
  title += 'de ' + d.getMonthName()



compare_post_by_comments_reverse = (a, b) ->
  return -1  if a.comments > b.comments
  return 1  if a.comments < b.comments
  0


$ ->
  $("h2").text title
  
  html = ''
  for i in [0...posts_count]
    html += "<li id=\"mcp_#{i}\"><a target=\"_parent\" href=\"#\"><img width=\"146\" height=\"219\"/></a></li>"
  $("ul").append html

  json_url_feed = "http://www.blogger.com/feeds/4049043576605538433/posts/default?callback=?"
  params =
    redirect: "false"
    "published-min": published_min
    "published-max": published_max
    "max-results": "1000000"
    alt: "json-in-script"

  $.getJSON json_url_feed, params, (data) ->
    items = []
    unless not data.feed.entry
      $.each data.feed.entry, (i, entry) ->
        post = {}
        $.each entry.link, (j, l) ->
          post.url = l.href  if l.rel is "alternate"
          post.comments = parseInt(l.title, 10)  if l.rel is "replies" and l.type is "text/html"

        try
          post.thumb = entry.media$thumbnail.url.replace(/\/s72-c\//i, "/s219/")
        items.push post  if !!post.comments and !!post.thumb and !!post.url
    items.sort compare_post_by_comments_reverse
    items = items.slice(0, posts_count)
    $.each items, (k, item) ->
      image = new Image
      $(image).bind "load", (event) ->
        $li = $("#mcp_" + k)
        $li.find("a").attr("href", item.url).attr "title", item.comments + " comentarios"
        $li.find("img").css("opacity", 0).attr("src", item.thumb).animate
          opacity: 1
        , 2000
      image.src = item.thumb





#examples
makeJSONRequest = ->
  params = {}
  params[gadgets.io.RequestParameters.CONTENT_TYPE] = gadgets.io.ContentType.JSON
  url = "http://gadget-doc-examples.googlecode.com/svn/trunk/opensocial-gadgets/json-data.txt"
  gadgets.io.makeRequest url, response, params
response = (obj) ->
  jsondata = obj.data
  
start = ->
  prefs = new gadgets.Prefs()
  debug = 1
  debug_html = ""
  gadgets.util.registerOnLoadHandler displayDate
  gadgets.util.registerOnLoadHandler makeJSONRequest
