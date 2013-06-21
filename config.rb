### 
# Compass
###

# Susy grids in Compass
# First: gem install compass-susy-plugin
# require 'susy'

# Change Compass configuration
compass_config do |config|
  #config.images_dir = "assets/images"
  config.output_style = :expanded
  config.relative_assets = true
  config.line_comments = true
  config.sass_options = {:debug_info => true}
end



###
# Haml
###

# CodeRay syntax highlighting in Haml
# First: gem install haml-coderay
# require 'haml-coderay'

# CoffeeScript filters in Haml
# First: gem install coffee-filter
# require 'coffee-filter'

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

###
# Page command
###

# Per-page layout changes:
# 
# With no layout
page "/pantene.html", :layout => false
page "/test.html", :layout => false
page "/widget_test.html", :layout => false
page "/template.xml", :layout => false
page "/most_commented.xml", :layout => false
# 
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
# 
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
#page "/onthecornerba.blogspot.com.xml", :proxy => "/template.xml" do
#   @which_fake_page = "Rendering a fake page with a variable"
#end

###
# Helpers
###



module MyAssetHandler
  class << self
    def registered(app)
      app.send :include, InstanceMethods
    end
    alias :included :registered
  end

  module InstanceMethods
    def asset_url(path, prefix="")
      original = super(path, prefix)
      #"http://localhost:4567" + original
      "http://onthecorner.com.ar/assets" + original
    end
  end
end

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

# Change the CSS directory
# set :css_dir, "alternative_css_directory"

# Change the JS directory
# set :js_dir, "alternative_js_directory"

# Change the images directory
# set :images_dir, "alternative_image_directory"

# Build-specific configuration
configure :build do

  activate MyAssetHandler

  compass_config do |config|
    config.output_style = :compact
    config.asset_host do |asset|
      "http://onthecorner.com.ar/assets"
    end
    config.relative_assets = false
    config.line_comments = false
    config.sass_options = {:debug_info => false}
  end

  # For example, change the Compass output style for deployment
  #activate :minify_css
  
  # Minify Javascript on build
  #activate :minify_javascript
  
  # Enable cache buster
  # activate :cache_buster
  
  # Use relative URLs
  # activate :relative_assets
  
  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher
  
  # Or use a different image path
  set :http_path, "http://ontheconrner.com.ar/assets/"
end
