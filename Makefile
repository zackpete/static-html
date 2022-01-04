out/index.html: out/1.html
	npx prettier $< >$@

out/1.html: out/0.html minifier.config.json
	npx html-minifier -c minifier.config.json -o $@ $<

out/0.html: src/index.html src/style.css
	mkdir -p out
	npx html-inline-external --src $< >$@

src/style.css: src/input.css tailwind.config.js
	npx tailwindcss -i $< -o $@

develop:
	$$( \
		npx tailwindcss -i src/input.css -o src/style.css & \
		npx browser-sync start -c browsersync.config.js & \
	)

clean:
	rm -f src/style.css
	rm -fr out

.PHONY: develop clean
