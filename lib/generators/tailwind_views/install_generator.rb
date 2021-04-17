# frozen_string_literal: true

require 'rails/generators'
require_relative 'devise_generator'
require_relative '../../tailwind_views_generator/helpers'

module TailwindViews
  module Generators
    # Generate scaffolds and views for tailwind
    class InstallGenerator < ::Rails::Generators::Base
      include TailwindViewsGenerator::Helpers
      desc 'Override default view scaffolding with Tailwind based scaffolds'
      source_root ::File.expand_path('../../templates', __dir__)
      class_option :template_engine,    type: :string, default: 'erb', aliases: '-t', enum: %w[erb slim haml],
                                        desc: 'The template_engine to use for generating the applications views (Erb, Slim, HAML)'

      # Boolean flags that can be flagged by adding to the generator call ie: --pagination or --metag_tags
      class_option :devise,             type: :boolean, default: false,
                                        desc: 'If views for devise will be required by the generator'

      class_option :layout,             type: :boolean, default: false, aliases: '-l',
                                        desc: 'Over-write your application layout file with a bootstrap based layout'

      class_option :metatags,           type: :boolean, default: false, aliases: '-m',
                                        desc: 'If views will assign pages title using metatags gem'

      class_option :pagination,         type: :boolean, default: false, aliases: '-p',
                                        desc: 'Toggle if pagination will be used with the index view/controller (based off of Pagy)'

      class_option :simpleform,         type: :boolean, default: false, aliases: '-sf',
                                        desc: 'Enable SimpleForms for the form generating'

      class_option :skip_javascript,    type: :boolean, default: false,
                                        desc: 'Skip adding javascript_include_tag or javascript_pack_tag to the layouts'

      class_option :skip_turbolinks,    type: :boolean, default: false,
                                        desc: 'Skip associating assets and views with turbolinks'

      def copy_scaffold_views
        %w[edit index show new].each do |file|
          template("scaffolds/#{options[:template_engine]}/#{file}.html.#{options[:template_engine]}",
                   "lib/templates/#{options[:template_engine]}/scaffold/#{file}.html.#{options[:template_engine]}",
                   force: true)
        end
      end

      def copy_form
        if options[:simpleform]
          copy_file("scaffolds/simple_form/_form.html.#{options[:template_engine]}",
                    "lib/templates/#{options[:template_engine]}/scaffold/_form.html.#{options[:template_engine]}", force: true)
        else
          copy_file("scaffolds/#{options[:template_engine]}/_form.html.#{options[:template_engine]}",
                    "lib/templates/#{options[:template_engine]}/scaffold/_form.html.#{options[:template_engine]}", force: true)
        end
      end

      def copy_layout_views
        return unless options[:layout]

        template("layouts/application.html.#{options[:template_engine]}.tt",
                 "app/views/layouts/application.html.#{options[:template_engine]}", force: true)
      end

      def copy_shared_views
        %w[footer navigation].each do |template_file|
          template("shared/#{template_file}/_#{template_file}.html.#{options[:template_engine]}.tt",
                   "app/views/shared/_#{template_file}.html.#{options[:template_engine]}", force: true)
        end
      end

      def copy_pagination_view
        return unless options[:pagination]

        copy_file("shared/pagination/_pagination.html.#{options[:template_engine]}",
                  "app/views/shared/_pagination.html.#{options[:template_engine]}", force: true)
      end

      def inject_application_helpers
        pagy_helper = (options[:pagination] ? 'include Pagy::Frontend' : '')
        helper_str = <<~HELPER
          #{pagy_helper}

          FLASH_TYPE_HASH = { success: 'green', error: 'yellow', alert: 'red', notice: 'indigo' }.freeze

          def alert_color(flash_type)
            (FLASH_TYPE_HASH[flash_type.to_sym] || flash_type.to_s)
          end

          def flash_messages(_opts = [])
            return '' unless flash.any?

            # remove any blank devise timeout errors
            flash.delete(:timedout)
            flash.each do |msg_type, message|
              # You don't need to create an empty alert message
              next if message.blank? || message.to_s.length.zero?

              concat(tag.div(class: "bg-\#{alert_color(msg_type)}-50 p-5 lg:w-full rounded border-l-4 border-\#{alert_color(msg_type)}-400 mb-5", role: 'alert') do
                concat(tag.p(message, class: "text-sm text-\#{alert_color(msg_type)}-500"))
              end)
            end
            nil
          end

          # for outputting an objects error messages
          def errors_for(object)
            return '' unless object.errors.any?

            content_tag(:div, class: 'text-sm bg-red-50 rounded p-5 mb-5') do
              concat(content_tag(:div, class: 'text-red-600 font-medium') do
                concat "\#{pluralize(object.errors.count, 'error')} prohibited this \#{object.class.name.downcase} from being saved:"
              end)
              concat(content_tag(:ul, class: 'px-0 text-red-500 italic font-sm') do
                object.errors.full_messages.each do |msg|
                  concat content_tag(:li, msg, class: 'list-disc px-0 py-1 mx-4')
                end
              end)
            end
          end
        HELPER

        inject_into_file('app/helpers/application_helper.rb',
                         optimize_indentation(helper_str, 2),
                         after: "module ApplicationHelper\n",
                         force: true)
      end

      def invoke_devise_generator
        # Generate tailwind based devise views if devise is being used
        invoke('tailwind_views:devise') if options[:devise]
      end
    end
  end
end
