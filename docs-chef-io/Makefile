# we use pushd/popd here, and /bin/sh of our chefes/buildkite image is not bash
# so we have to override the default shell here
SHELL=bash

preview_netlify: chef_web_docs
	cp -R content/inspec/resources/* chef-web-docs/_vendor/github.com/inspec/inspec-aws/docs-chef-io/content/inspec/resources/
	cp -R config.toml chef-web-docs/_vendor/github.com/inspec/inspec-aws/docs-chef-io/
	pushd chef-web-docs && make build; hugo --gc --minify --buildFuture && popd


replace = "replacements = \'github.com/inspec/inspec-aws/docs-chef-io -\> ../../\'\\n\\n"

serve: chef_web_docs
	@echo -e "$(replace)" > temp.txt
	@cat chef-web-docs/config/_default/module.toml >> temp.txt
	@cat temp.txt > chef-web-docs/config/_default/module.toml
	rm temp.txt
	pushd chef-web-docs && make build; hugo server --buildDrafts --buildFuture --noHTTPCache && popd

chef_web_docs:
	if [ -d "chef-web-docs/" ]; then \
		pushd chef-web-docs && git reset HEAD --hard; git clean -fd; git pull --ff-only origin main; rm -rf public && popd; \
	else \
		git clone https://github.com/chef/chef-web-docs.git; \
	fi

clean_all:
	rm -rf chef-web-docs

clean:
	pushd chef-web-docs && make clean_all && popd

lint:
	hugo -D


publish_release_notes:
	$(shell . tools/release-notes/publish-release-notes.sh)

