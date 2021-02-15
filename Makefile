src_dir:=src
tgt_dir:=target
deps_dir:=$(tgt_dir)/deps
gen_dir:=$(tgt_dir)/gen
gen_site_dir:=$(gen_dir)/site
blog_content_dir:=$(deps_dir)/blog_content
posts_dir:=$(blog_content_dir)/posts
img_dir:=$(blog_content_dir)/img

$(gen_site_dir)/public/index.html: \
		check_lint \
		$(addprefix $(gen_site_dir)/,$(shell find src)) \
		$(patsubst \
			$(posts_dir)/%, \
			$(gen_site_dir)/src/posts/%, \
			$(wildcard $(posts_dir)/*) \
		) \
		$(patsubst \
			$(img_dir)/%, \
			$(gen_site_dir)/src/images/%, \
			$(wildcard $(img_dir)/*) \
		)
	( \
		cd '$(gen_site_dir)' \
			&& yarn install \
			&& yarn build \
	)

$(gen_site_dir)/src/images/%: $(img_dir)/% | $(gen_site_dir)
	cp '$<' '$@'

$(gen_site_dir)/src/posts/%.md: $(posts_dir)/%.md | $(gen_site_dir)
	cp '$<' '$@'

$(gen_site_dir)/src/data/site.json: $(src_dir)/data/site.json | $(gen_site_dir)
	cp '$<' '$@'

$(gen_site_dir)/src/about.md: $(src_dir)/about.md | $(gen_site_dir)
	cp '$<' '$@'

$(gen_site_dir)/src/index.md: $(src_dir)/index.md | $(gen_site_dir)
	cp '$<' '$@'

$(gen_site_dir)/src/projects.md: $(src_dir)/projects.md | $(gen_site_dir)
	cp '$<' '$@'

$(gen_site_dir)/src/css/%: $(src_dir)/css/% | $(gen_site_dir)
	cp '$<' '$@'

$(gen_site_dir)/src/layouts/%: $(src_dir)/layouts/% | $(gen_site_dir)
	cp '$<' '$@'

# We remove files that we intend to overwrite to avoid the case where they're
# not overwritten, due to being newer than the source files.
$(gen_site_dir)/src: | $(deps_dir)/eleventy_duo $(gen_dir)
	cp \
		-r \
		$(deps_dir)/eleventy_duo \
		$(gen_site_dir)
	rm \
		$(gen_site_dir)/src/about.md \
		$(gen_site_dir)/src/index.md \
		$(gen_site_dir)/src/data/site.json \
		$(gen_site_dir)/src/css/main.css \
		$(gen_site_dir)/src/layouts/about.njk \
		$(gen_site_dir)/src/images/* \
		$(gen_site_dir)/src/posts/*.md

$(deps_dir)/eleventy_duo: | $(deps_dir)
	sh scripts/pull_eleventy_duo.sh '$@'

$(gen_dir): | $(tgt_dir)
	mkdir '$@'

$(deps_dir): | $(tgt_dir)
	mkdir '$@'

$(tgt_dir):
	mkdir '$@'

.PHONY: check_lint
check_lint:
	markdownlint \
		--config=configs/markdownlint.json \
		'*.md' \
		'$(src_dir)/**/*.md'
