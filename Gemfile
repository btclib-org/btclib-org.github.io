# The btclib.org website. .github/workflows/website.yml builds it with
# these gems and, on main, deploys it; Pages builds nothing itself. A
# local preview runs the same build: `bundle exec jekyll serve`.
#
# The gems are the ones the site uses and no others: jekyll, the theme,
# `{% seo %}` from jekyll-seo-tag and `site.github` from
# jekyll-github-metadata, both read by _layouts/default.html. Jekyll
# loads the :jekyll_plugins group without a `plugins` key.
#
# `Gemfile.lock`, committed beside this file, is the lock. Dependabot's
# bundler ecosystem moves both files, so a release arrives as a pull
# request that builds the site with it before it is merged.
source 'https://rubygems.org'

gem 'jekyll', '~> 4.4'
gem 'jekyll-theme-minimal', '~> 0.2'

group :jekyll_plugins do
  gem 'jekyll-github-metadata'
  gem 'jekyll-seo-tag'
end
