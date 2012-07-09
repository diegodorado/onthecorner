$ ->
  kill_lightbox()
  fix_fb_share() 
  set_body()
  set_archive_widget()
  set_image_widget()
  set_menu()
  set_pager()
  display_archive_page()  if $("body").hasClass("archive")
  format_posts()  if $("body").hasClass("index") or $("body").hasClass("item")
  $(".post-outer .post-body ol li").wrapInner "<span>"  if $("body").hasClass("static_page")
  


kill_lightbox = ->
  $("a[href$=\"jpg\"],a[href$=\"png\"]").each (i, el) ->
    html = @innerHTML
    @innerHTML = html

fix_fb_share = ->
  $(".widget.Blog .post-outer .hentry").each (i, el) ->
    url =  $(el).find('h2.lower a').attr 'href'
    link = $(el).find('.share-links .facebook')
    link.attr 'onclick', null
    u = encodeURIComponent url
    link.attr 'href', "https://www.facebook.com/sharer.php?u=#{u}"


set_body = ->
  $("body").removeClass "loading"
  $("body").addClass "news"  unless not window.location.pathname.match(/\/label\//)
  $("body").addClass "search"  unless not window.location.href.match(/search\?q/)

format_posts = ->

  #display status message if no posts
  $(".status-message").show()  if $(".widget.Blog .post-outer").size() is 0
  
  #set label classes and h3.upper text
  $(".widget.Blog .post-outer .post-labels div").each (i, el) ->
    c = $(el).attr("class")
    $(el).closest(".post-outer").addClass("news").find("h3.upper").text c  if c is "especiales otc" or c is "prensa"

  #share behaviour
  $(".widget.Blog .post-outer .share-comments .share").click (e) ->
    e.preventDefault()
    $(this).closest(".share-comments").toggleClass "active"
    
  #grabs title and subtitle
  $(".widget.Blog .post-outer:not(.news) .hentry").each (i, el) ->
    try
      t = $(el).find("h2.lower a").text()
      t = $(el).find(".post-body").text()  if t.trim().length is 0
      a = t.split(",")
      $(el).find("h2.lower a").text a[0]
      $(el).find("h3.lower a").text a.slice(1).join(",")

  #sets photo-container on posts with caption
  $(".widget.Blog .post-outer .post-body .tr-caption-container").each (i, el) ->
    $a = $(el).find("a")
    $a.addClass "photo-container"
    c = $(el).find(".tr-caption").html()
    $a.append "<span class=\"caption-wrapper\"><span class=\"caption-container\"><span class=\"caption\">" + c + "</span></span></span>"
    $(el).before $a
    $(el).remove()

  $(".widget.Blog .post-body .photo-container .caption-wrapper").hoverIntent
    over: ->
      $(this).find(".caption-container").stop(true, true).animate {height: "80px"} , duration: 400
      $(this).find(".caption").stop(true, true).delay(400).animate {opacity: 1}, duration: 400
    out: ->
      $(this).find(".caption").stop(true, true).animate {opacity: 0} , duration: 400
      $(this).find(".caption-container").stop(true, true).delay(400).animate {height: "0px"}, duration: 400
    timeout: 500

set_image_widget = ->
  #open links in new window
  $(".widget.Image .widget-content a").attr "target", "_blank"

set_archive_widget = ->
  $(".widget.BlogArchive .hierarchy .post-count-link[href*=\"search\"]").each (i, el) ->
    #not an archive page
    $(el).closest(".archivedate").removeClass("expanded").addClass "collapsed"  unless $("body").hasClass("archive")
    $(el).attr "href", $(el).siblings(".hierarchy").find(".post-count-link").first().attr("href")

set_index_pager = ->
  pageCount = 7
  json_url_feed = "http://onthecornerstreetstyle.blogspot.com/feeds/posts/summary?callback=?"
  params =
    redirect: "false"
    "max-results": "99999"
    alt: "json-in-script"

  unless not window.location.pathname.match(/\/label\//)
    m = unescape(window.location.pathname).match(/\/label\/(\w+[\s\w+]*)/)
    params.category = m[1]
  $.getJSON json_url_feed, params, (data) ->
    links = []
    url = location.href
    activeLink = 0
    prefix_url = ""
    unless not params.category
      prefix_url = "/search/label/" + params.category + "?&max-results=" + pageCount + "&updated-max="
    else
      prefix_url = "/search?&max-results=" + pageCount + "&updated-max="
    $.each data.feed.entry, (i, entry) ->
      timestamp = entry.published.$t.substring(0, 19) + entry.published.$t.substring(23, 29)
      timestamp = encodeURIComponent(timestamp)
      if i is 0 or (i % pageCount is (pageCount - 1))
        activeLink = links.length  unless url.indexOf(timestamp) is -1
        links.push prefix_url + timestamp

    $.each links, (i, link) ->
      if Math.abs(i - activeLink) < 5
        $a = $("<a>" + (i + 1) + "</a>")
        $a.attr "href", link
        $a.addClass "active"  if i is activeLink
        $("#pager .page-links").append $a

    $("#pager .newer a").attr "href", $("#pager .page-links .active").prev().attr("href")
    $("#pager .older a").attr "href", $("#pager .page-links .active").next().attr("href")
    $("#pager a[href='']").remove()
    $("#pager").show()
    
set_pager = ->
  $("#pager li.archive a").attr "href", $("#menu a.archive").attr("href")
  return false  if $("body").hasClass("static_page")
  return false  if $("body").hasClass("search")
  set_index_pager()  if $("body").hasClass("index")
  if $("body").hasClass("archive")
    current_reached = false
    $(".widget.BlogArchive .hierarchy .post-count-link").each (i, el) ->
      current_reached = true  if $(el).attr("href") is window.location
      $("#pager .older a").attr "href", $(el).attr("href")  unless current_reached
      if current_reached
        unless $(el).attr("href") is window.location
          #avoid duplicates (year links)
          $("#pager .newer a").attr "href", $(el).attr("href")
          #stops loop
          false

    $("#pager a[href='']").remove()
    $("#pager").show()
  if $("body").hasClass("item")
    #get links from the hidden blog-pager
    $("#pager .older a").attr "href", $("#blog-pager .older").attr("href")  unless not $("#blog-pager .older")
    $("#pager .newer a").attr "href", $("#blog-pager .newer").attr("href")  unless not $("#blog-pager .newer")
    $("#pager a[href='']").remove()
    $("#pager").show()

set_menu = ->
  $(window).scroll ->
    if $(window).scrollTop() > 50
      $("#logo a").stop().animate paddingTop: "7px"
    else
      $("#logo a").stop().animate paddingTop: "48px"

  $("#menu a.archive").attr "href", $(".widget.BlogArchive .hierarchy .post-count-link").last().attr("href")
  #set active class
  $("#menu a.archive").addClass "active"  if $("body").hasClass("archive")
  $("#menu ul li a").each (i, el) ->
    $(el).addClass "active"  if $(el).attr("href") is window.location.pathname

display_archive_page = ->
  d = Date.parseBloggerUrl(window.location.pathname)
  $("#content .center h1").html d.getMonthName() + " " + d.getFullYear()
  json_url_feed = "http://www.blogger.com/feeds/4049043576605538433/posts/default?callback=?"
  params =
    redirect: "false"
    "published-min": d.toBlogger()
    "published-max": d.toBlogger(1)
    "start-index": "1"
    "max-results": "100"
    alt: "json-in-script"

  $.getJSON json_url_feed, params, (data) ->
    items = []
    if data.feed.entry
      $.each data.feed.entry, (i, entry) ->
        try
          post_url = entry.link[4].href
          post_thumb_url = entry.media$thumbnail.url.replace(/\/s72-c\//i, "/s217/")
          items.push "<li class=\"col-" + (i % 3) + "\" ><a href=\"" + post_url + "\"><img src=\"" + post_thumb_url + "\" /></a></li>"
        catch e
          #ignore that item
          
      $("#archive_list").html items.join("")
      $("#archive_list img").css "opacity", 0
      $("#archive_list img").each (i, el) ->
        image = new Image
        #Handle the image loading and error with the same callback.
        $(image).bind "load", (event) ->
          h = $(el).height()
          if h is 217
            $(el).attr "width", 146
          else
            $(el).attr "height", 217
            $(el).attr 'src', $(el).attr("src").replace(/\/s217\//i, "/s492/")
          $(el).css left: 0 - (($(el).width() - 146) / 2)
          $(el).animate {opacity: 1} , 2000

        image.src = el.src
    else
      $('#archive_list').html '<li>No hay resultados</li>'
      
      

