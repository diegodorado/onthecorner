#require('nokogiri')

SSH_USER = 'onthecorner'
SSH_HOST = 'onthecorner.com.ar'
SSH_DIR  = 'onthecorner.com.ar/assets'

GOOGLE_USER = 'diego@cooperativahormigon.com.ar'
GOOGLE_PASSWORD = '------------'
CLIENT_ID = 'diegodorado-makefile-1'

desc "Build the website from source"
task :build do
  puts "## Building website"
  status = system("middleman build --clean")
  puts status ? "OK" : "FAILED"
end

desc "Run the preview server at http://localhost:4567"
task :preview do
  system("middleman server")
end

desc "Deploy website via rsync"
task :deploy do
  puts "## Deploying website via rsync to #{SSH_HOST}"
  #status = system("rsync -avze 'ssh' --delete build/ #{SSH_USER}@#{SSH_HOST}:#{SSH_DIR}")
  status = system("rsync -avze 'ssh' build/ #{SSH_USER}@#{SSH_HOST}:#{SSH_DIR}")
  puts status ? "OK" : "FAILED"
end

desc "Build and deploy website"
task :gen_deploy => [:build, :deploy] do
end


# How authenticate by "Installed Applications":
#   http://code.google.com/apis/accounts/docs/AuthForInstalledApps.html#Request
#                 ClientLogin for Installed Applications
#   http://gdatatips.blogspot.com/2008/08/perform-clientlogin-using-curl.html
#                 Perform ClientLogin using curl
# If 'accountType'='HOSTED' authentication fail. With 'GOOGLE' and 'HOSTED_OR_GOOGLE' work fine.
# If skip 'source' parameter I can successfully login and use Blogger service.
namespace :blogger do
  desc "Authenticate to google"
  task :login do
    puts 'trying to authenticate to google'
    %x[
      curl -s -k https://www.google.com/accounts/ClientLogin \
		    -d 'accountType=GOOGLE' \
		    -d 'source=#{CLIENT_ID}' \
		    -d "Email=#{GOOGLE_USER}" \
		    -d "Passwd=#{GOOGLE_PASSWORD}" \
		    -d "service=blogger" \
        > /tmp/response
    ]

    #	if grep "^Error=" $(WEB_DIR)/login-cookie.txt; then \
    #		echo Can not authenticate!; \
    #		exit 1; \
    #	fi

    %x[sed -n '/^Auth=/{s|^Auth=||;p;q}' < /tmp/response > /tmp/auth]

  end
  
  ################################################################
  # Download targets.

  # How do I get the Atom service document that describes a feed?
  #   http://code.google.com/apis/gdata/faq.html#atom_service_doc
  #.PHONY: get-services
  #get-services: login $(WEB_DIR)/service.atom
  #
  #$(WEB_DIR)/service.atom: $(FORCE_) | $(WEB_DIR)
  #
  #	curl $(CURL_FLAGS) \
  #		--header "Authorization: GoogleLogin auth="`cat $(WEB_DIR)/login-auth.txt` \
  #		--header "GData-Version: 2" \
  #		'http://www.blogger.com/feeds/default/blogs?alt=atom-service' >$(WEB_DIR)/service.atom
  #	tidy $(TIDY_FLAGS) -o $(WEB_DIR)/service-pp.atom $(WEB_DIR)/service.atom
  #
  task :get_services do
    auth = File.read("/tmp/auth")

    %x[
      curl -s -k "http://www.blogger.com/feeds/default/blogs?alt=atom-service" \
    		--header "Authorization: GoogleLogin auth=#{auth}" \
    		--header "GData-Version: 2" \
        > /tmp/services
    ]
    sh 'cat /tmp/services'


  end


  #$(WEB_DIR)/bloglist.atom: $(FORCE_) | $(WEB_DIR)
  #
  #	curl $(CURL_FLAGS) \
  #		--header "Authorization: GoogleLogin auth="`cat $(WEB_DIR)/login-auth.txt` \
  #		--header "GData-Version: 2" \
  #		http://www.blogger.com/feeds/default/blogs >$(WEB_DIR)/bloglist.atom
  #	tidy $(TIDY_FLAGS) -o $(WEB_DIR)/bloglist-pp.atom $(WEB_DIR)/bloglist.atom

  task :bloglist do
    auth = File.read("/tmp/auth")

    %x[
      curl -s -k "http://www.blogger.com/feeds/default/blogs" \
    		--header "Authorization: GoogleLogin auth=#{auth}" \
    		--header "GData-Version: 2" \
        > /tmp/bloglist.atom
    ]

    contents = File.read("/tmp/bloglist.atom")
    
    doc  = Nokogiri::XML(contents)
    doc.remove_namespaces!

    blogs = []
    doc.xpath('//entry').each do |entry|
      blog = {}
      blog['id'] = entry.xpath('id/text()').to_s.sub(/.*blog-/,'')
      blog['title'] = entry.xpath('title/text()').to_s
      blog['url'] = entry.xpath('link[@rel="alternate" and @type="text/html"]/@href').to_s
      blog['name'] = blog['url'].sub('http://','').sub('.blogspot.com/','')
      blog['settings'] = entry.xpath("link[@rel='http://schemas.google.com/blogger/2008#settings']/@href").to_s
      blog['template'] = entry.xpath("link[@rel='http://schemas.google.com/blogger/2008#template']/@href").to_s
      blogs << blog
    end

    File.open('/tmp/blogs', 'w') {|f| f.write(Marshal.dump(blogs)) }

  end


  task :test do


    #$(WEB_DIR)/%-template.atom: $(WEB_DIR)/template-urls.txt $(FORCE_) | $(WEB_DIR)
    #	curl $(CURL_FLAGS) \
    #		--header "Authorization: GoogleLogin auth="`cat $(WEB_DIR)/login-auth.txt` \
    #		--header "GData-Version: 2" \
    #		`sed -n '/$*=/{s|$*=||;p;q}' $(WEB_DIR)/template-urls.txt` >$@
    #	tidy $(TIDY_FLAGS) -o $(WEB_DIR)/$*-template-pp.atom $@

    blogs = Marshal.load(File.read('/tmp/blogs'))    
    blog = blogs[0] #flora-test



    puts blog['name']

    auth = File.read("/tmp/auth")


    %x[
      curl -s -k  \
    		--header "Authorization: GoogleLogin auth=#{auth}" \
    		--header "GData-Version: 2"  \
    		"#{blog['template']}/default" > /tmp/template
    ]


        
    sh 'cat /tmp/template'
    
    
  end



  
end





