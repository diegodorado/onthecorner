# Copyright (C) 2010 by Oleksandr Gavenko <gavenkoa@gmail.com>
#
# Permitted to do anything with this file for any purpose but this file is not in Public Domain.
#
# NOTE: Some national copyright lows reserve some rights for authors.
# For example in Ukraine you can not use this work to damage author reputation.
# So be careful!

# Makefile.config MUST contain:
#   GOOGLE_USER         google user to login
#   GOOGLE_PASSWORD     google passowrd to login
# Makefile.contain MAY contain:
#   CLIENT_ID           in form companyName-applicationName-versionID
#   WEBCLIENT           curl[default]/wget

# How use CURL with Google:
#   http://code.google.com/apis/gdata/articles/using_cURL.html

# What is the service name in ClientLogin for each Data API?
#   http://code.google.com/apis/gdata/faq.html#clientlogin

# END-OF-COMMENTS

SHELL = /bin/sh

# Disable built in pattern rules.
MAKEFLAGS += -r
# Disable built in variables.
MAKEFLAGS += -R
# Disable built in suffix rules.
.SUFFIXES:
# Default target.
.DEFAULT_GOAL = help

################################################################
# Path definition.

MK_FILE = Makefile
MK_CONFIG_FILE = Makefile.config

ifneq '' '$(wildcard $(MK_CONFIG_FILE))'
  include $(MK_CONFIG_FILE)
endif

WEB_DIR = web

################################################################
# Tools definitions and switches.

ifeq '$(FORCE)' 'yes'
  FORCE_ = force
endif

WEBCLIENT = curl

TIDY_FLAGS = -xml -quiet -utf8 -config tidy.cfg

USER_AGENT = Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.3) Gecko/20100401 Firefox/3.6.3

WGET_FLAGS = --user-agent="$(USER_AGENT)" --keep-session-cookies

# -k, --insecure        Allow connections to SSL sites without certs.
# -A, --user-agent <string>  User-Agent to send to server.
# -s, --silent          Silent mode. Don't output anything.
CURL_FLAGS = -s -k --user-agent "$(USER_AGENT)"

################################################################
# Init and login targets.

TEMPLATE_FILES := $(wildcard *.blogspot.com.xml)
TEMPLATE_NAMES := $(TEMPLATE_FILES:.blogspot.com.xml=)

$(WEB_DIR):
	mkdir -p $@

.PHONY: login
login: $(WEB_DIR)/login-auth.txt

# How authenticate by "Installed Applications":
#   http://code.google.com/apis/accounts/docs/AuthForInstalledApps.html#Request
#                 ClientLogin for Installed Applications
#   http://gdatatips.blogspot.com/2008/08/perform-clientlogin-using-curl.html
#                 Perform ClientLogin using curl
# If 'accountType'='HOSTED' authentication fail. With 'GOOGLE' and 'HOSTED_OR_GOOGLE' work fine.
# If skip 'source' parameter I can successfully login and use Blogger service.
$(WEB_DIR)/login-auth.txt: $(FORCE_) | $(WEB_DIR)
ifeq '$(WEBCLIENT)' 'curl'
	curl $(CURL_FLAGS) \
		-d "accountType=GOOGLE" \
		-d "source=$(CLIENT_ID)" \
		-d "Email=$(GOOGLE_USER)" \
		-d "Passwd=$(GOOGLE_PASSWORD)" \
		-d "service=blogger" \
		"https://www.google.com/accounts/ClientLogin" >$(WEB_DIR)/login-cookie.txt
	if grep "^Error=" $(WEB_DIR)/login-cookie.txt; then \
		echo Can not authenticate!; \
		exit 1; \
	fi
	sed -n '/^Auth=/{s|^Auth=||;p;q}' <$(WEB_DIR)/login-cookie.txt >$(WEB_DIR)/login-auth.txt
endif

# This target allow initialize working environment.
.PHONY: create-template-stubs
create-template-stubs: $(WEB_DIR)/bloglist.txt
	for blogs in `sed -e 's|^http://||' -e 's|/$$||' $(WEB_DIR)/bloglist.txt`; do \
		touch $$blogs.xml; \
	done

################################################################
# Upload targets.

UPLOADED_TEMPLATE_ATOM_FILES := $(patsubst %,$(WEB_DIR)/%-template-uploaded.atom,$(TEMPLATE_NAMES))

.PHONY: upload-template
upload-template: $(UPLOADED_TEMPLATE_ATOM_FILES)

$(WEB_DIR)/%-template-uploaded.atom: %.blogspot.com.xml $(WEB_DIR)/%-template.atom \
        xsl/template-xml2atom.xsl xsl/template-url.xsl $(FORCE_) | $(WEB_DIR)
	( \
		printf '<?xml version="1.0" encoding="UTF-8"?>\n<content>'; \
		sed -e 's=&=\&amp;=g' -e 's=<=\&lt;=g' -e 's=>=\&gt;=g' <$*.blogspot.com.xml; \
		printf '</content>'; \
	 ) >$(WEB_DIR)/$*-template-escaped.xml
	xsltproc --stringparam templatefile ../$(WEB_DIR)/$*-template-escaped.xml \
		xsl/template-xml2atom.xsl $(WEB_DIR)/$*-template.atom >$@
	curl $(CURL_FLAGS) \
		--request PUT \
		--data-binary @$@ \
		--header "Content-Type: application/atom+xml" \
		--header "Authorization: GoogleLogin auth="`cat $(WEB_DIR)/login-auth.txt` \
		--header "GData-Version: 2" \
		`xsltproc xsl/template-url.xsl $(WEB_DIR)/$*-template.atom`

################################################################
# Download targets.

# How do I get the Atom service document that describes a feed?
#   http://code.google.com/apis/gdata/faq.html#atom_service_doc
.PHONY: get-services
get-services: login $(WEB_DIR)/service.atom

$(WEB_DIR)/service.atom: $(FORCE_) | $(WEB_DIR)
ifeq '$(WEBCLIENT)' 'curl'
	curl $(CURL_FLAGS) \
		--header "Authorization: GoogleLogin auth="`cat $(WEB_DIR)/login-auth.txt` \
		--header "GData-Version: 2" \
		'http://www.blogger.com/feeds/default/blogs?alt=atom-service' >$(WEB_DIR)/service.atom
	tidy $(TIDY_FLAGS) -o $(WEB_DIR)/service-pp.atom $(WEB_DIR)/service.atom
endif
ifeq '$(WEBCLIENT)' 'wget'
	$(error not implemented)
endif

SETTINGS_NAMES := $(TEMPLATE_FILES:.blogspot.com.xml=)
REMOTE_SETTINGS_ATOM_FILES := $(patsubst %,$(WEB_DIR)/%-settings.atom,$(SETTINGS_NAMES))

.PHONY: get-settings-atom
get-settings-atom: login $(REMOTE_SETTINGS_ATOM_FILES)

$(WEB_DIR)/%-settings.atom: $(WEB_DIR)/settings-urls.txt $(FORCE_) | $(WEB_DIR)
	curl $(CURL_FLAGS) \
		--header "Authorization: GoogleLogin auth="`cat $(WEB_DIR)/login-auth.txt` \
		--header "GData-Version: 2" \
		`sed -n '/$*=/{s|$*=||;p;q}' $(WEB_DIR)/settings-urls.txt` >$@
	tidy $(TIDY_FLAGS) -o $(WEB_DIR)/$*-settings-pp.atom $@

.PHONY: get-settings-urls
get-settings-urls: login $(WEB_DIR)/settings-urls.txt

$(WEB_DIR)/settings-urls.txt: $(WEB_DIR)/bloglist.atom xsl/settings-urls2txt.xsl $(FORCE_) | $(WEB_DIR)
	xsltproc xsl/settings-urls2txt.xsl $(WEB_DIR)/bloglist.atom | tee $@

REMOTE_TEMPLATE_FILES := $(patsubst %,$(WEB_DIR)/%-template.xml,$(TEMPLATE_NAMES))

.PHONY: overwrite-template
overwrite-template: get-template
	for file in *.blogspot.com.xml; do \
		name=$${file%.blogspot.com.xml}; \
		cp -f $(WEB_DIR)/$$name-template.xml $$file; \
	done

.PHONY: get-template
get-template: login $(REMOTE_TEMPLATE_FILES)

$(WEB_DIR)/%-template.xml: $(WEB_DIR)/%-template.atom  xsl/template-atom2xml.xsl $(FORCE_)
	xsltproc xsl/template-atom2xml.xsl $< \
		| sed -e 's=&lt;=<=g' -e 's=&gt;=>=g' -e 's=&amp;=\&=g'  >$@
	tidy $(TIDY_FLAGS) -o $(WEB_DIR)/$*-template-pp.xml $@

REMOTE_TEMPLATE_ATOM_FILES := $(patsubst %,$(WEB_DIR)/%-template.atom,$(TEMPLATE_NAMES))

.PHONY: get-template-atom
get-template-atom: login $(REMOTE_TEMPLATE_ATOM_FILES)

$(WEB_DIR)/%-template.atom: $(WEB_DIR)/template-urls.txt $(FORCE_) | $(WEB_DIR)
	curl $(CURL_FLAGS) \
		--header "Authorization: GoogleLogin auth="`cat $(WEB_DIR)/login-auth.txt` \
		--header "GData-Version: 2" \
		`sed -n '/$*=/{s|$*=||;p;q}' $(WEB_DIR)/template-urls.txt` >$@
	tidy $(TIDY_FLAGS) -o $(WEB_DIR)/$*-template-pp.atom $@

.PHONY: get-template-urls
get-template-urls: login $(WEB_DIR)/template-urls.txt

$(WEB_DIR)/template-urls.txt: $(WEB_DIR)/bloglist.atom xsl/template-urls2txt.xsl $(FORCE_) | $(WEB_DIR)
	# xpath $(WEB_DIR)/bloglist.atom  '//link[@rel="http://schemas.google.com/blogger/2008#template"]/@href'
	xsltproc xsl/template-urls2txt.xsl $(WEB_DIR)/bloglist.atom | tee $@

.PHONY: bloglist
bloglist: login $(WEB_DIR)/bloglist.txt

$(WEB_DIR)/bloglist.txt: $(WEB_DIR)/bloglist.atom xsl/bloglist.xsl $(FORCE_) | $(WEB_DIR)
	# @xpath $(WEB_DIR)/bloglist.atom '/feed/entry/link[@rel="alternate" and @type="text/html"]/@href' 2>&1 | \
	# 	awk 'BEGIN {RS="-- NODE --\n"; skip=1} {if (skip) {skip=0} else {print $$0}}'
	# xmllint --xpath '/feed/entry/link[@rel="alternate" and @type="text/html"]/@href' $(WEB_DIR)/bloglist.atom
	# xmllint --valid --noout $(WEB_DIR)/bloglist.atom
	xsltproc xsl/bloglist.xsl $(WEB_DIR)/bloglist.atom | tee $@

# http://www.blogger.com/feeds/default/blogs is the metafeed URL.
# It returns a list of blogs for the currently authenticated user with following blogger data:
#   user profile: /feed/link[@rel='alternate']/@href
#   blog title (for each blog): /feed/entry/title/text()
#   blog feeds (for each blog): /feed/entry/link[rel='http://schemas.google.com/g/2005#feed']/@href
#   blog template (for each blog): /feed/entry/link[rel='http://schemas.google.com/blogger/2008#template']/@href
#   blog settings (for each blog): /feed/entry/link[rel='http://schemas.google.com/blogger/2008#settings']/@href
# See:
#   http://code.google.com/apis/blogger/docs/2.0/developers_guide_protocol.html#RetrievingMetafeed
$(WEB_DIR)/bloglist.atom: $(FORCE_) | $(WEB_DIR)
ifeq '$(WEBCLIENT)' 'curl'
	curl $(CURL_FLAGS) \
		--header "Authorization: GoogleLogin auth="`cat $(WEB_DIR)/login-auth.txt` \
		--header "GData-Version: 2" \
		http://www.blogger.com/feeds/default/blogs >$(WEB_DIR)/bloglist.atom
	tidy $(TIDY_FLAGS) -o $(WEB_DIR)/bloglist-pp.atom $(WEB_DIR)/bloglist.atom
endif


################################################################
# Helper target.

.PHONY: help
help:
	@echo
	@sed -n -e '/END-OF-COMMENTS/q' -e '/^# /{s=^# =  =;p}' $(MK_FILE)
	@echo
	@echo WEBCLIENT = $(WEBCLIENT)
	@echo
	@echo Supported targets:
	@sed -n -e '/^[[:alnum:]_-]*:/{s=^\(.*\):.*=  \1=;p;}' $(MAKEFILE_LIST)
