# Tailwind Views Generator

![](https://ruby-gem-downloads-badge.herokuapp.com/tailwind_views_generator?type=total)  [![MIT license](http://img.shields.io/badge/license-MIT-brightgreen.svg)](http://opensource.org/licenses/MIT) [![Gem Version](https://badge.fury.io/rb/tailwind_views_generator.svg)](https://badge.fury.io/rb/tailwind_views_generator)

This gem is used for generating tailwind based scaffold views for your Rails application. They can be Erb, Slim, or HAML. You can include pagination (using Pagy), simple_form (for the form components), and if you'd like you can utilize the meta-tags gems to all dynamic page titles when switching between your view components.

This is more or less a sister project of the [bootstrap_views_generator](https://github.com/tarellel/bootstrap_views_generator) and [semantic_ui_views_generator](https://github.com/tarellel/semantic_ui_views_generator) gems, but for those who prefer to use TailwindCSS. If you are using [simple_form](https://github.com/heartcombo/simple_form) I've also created a simple_form [config](https://github.com/tarellel/simple_form-tailwind) for styling your forms with Tailwind.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tailwind_views_generator', group: :development

# Before continuing make sure you have the tailwind yarn package or rails tailwind gem installed and included in your application.scss file so tailwind will be available for the applications frontend
gem 'tailwindcss-rails'

```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tailwind_views_generator

## Usage

```shell
Usage:
  rails g tailwind_views:install [options]

Options:
Options:
-t, [--template-engine=TEMPLATE_ENGINE]     # Indicates when to generate using a designated template engine (erb, slim, haml)
                                            # Default: erb
--simpleform                                # Indicates if simple_form is to be used to generate the forms
                                            # Default: false
--pagination                                # Specify if you want to add pagination to the index pages
                                            # Defaults: false (requires Pagy to use pagination)
--metatags                                  # If you want the pages titles to use the meta-tags gem function for the page title
                                            # Default: false
--layout                                    # Over-write your application layout file with a Tailwind based layout
                                            # Default: false
--devise                                    # If you want to generate tailwind based devise views
                                            # Default: false
--skip_javascript                           # If you want to skip adding javascript_include_tag || javascript_pack_tag to the layouts
                                            # Default: false
--skip_turbolinks                           # Do you want to skip associating turbolinks with the assets and views
                                            # Default: false
```

## Options

##### Template Engines

Supported Template Engines

* ERB
* HAML
* Slim

**HAML**

Make sure you have haml added to your your Gemfile
```ruby
gem 'haml-rails'

# generate haml views
rails g tailwind_views:install --template_engine=haml
```

**Slim**
Make sure you have Slim added to your Gemfile
```ruby
gem 'slim-rails'

# generate Slim views
rails g tailwind_views:install --template_engine=slim
```

#### Pagination

Ensure you have [Pagy](https://github.com/ddnexus/pagy) gem installed
```ruby
gem 'pagy'
```

And ensure you have pagy's [tailwind extras](https://ddnexus.github.io/pagy/extras/tailwind) included in your applications stylesheets to format your pagination.


#### Meta-Tags
Ensure you have the [meta-tags](https://github.com/kpumuk/meta-tags) gem installed
```ruby
gem 'meta-tags'
```

### Examples

Generate tailwind views with pagination enabled
```shell
rails g tailwind_views:install --pagination
```

Generate tailwind views with slim and using simple_form
```shell
rails g tailwind_views:install --template_engine=slim --simpleform
```

Generate tailwind scaffolds, devise views, while using simpleform, metatags, and slim template engine.
```shell
 rails g tailwind_views:install --devise --simpleform --metatags --template_engine=slim
```

### Extras

* If you like to use the [meta-tags](https://github.com/kpumuk/meta-tags) gem to add page titles based on the views.
* Pagination defaults to using [Pagy](https://github.com/ddnexus/pagy) on the index pages.
* With [simple_form](https://github.com/plataformatec/simple_form) it generates a `config/initializers/simple_form.rb` file for your simple_form formatting.
