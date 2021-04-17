# frozen_string_literal: true

require 'rails/generators'

module TailwindViews
  module Generators
    # Generator to run to add devise templates to the application
    class DeviseGenerator < ::Rails::Generators::Base
      include TailwindViewsGenerator::Helpers
      hide!
      desc 'Overwrite default devise views'
      source_root ::File.expand_path('../../templates/devise', __dir__)

      class_option :template_engine,    type: :string, default: 'erb', aliases: '-t', enum: %w[erb slim haml],
                                        desc: 'Set template engine to generate the views with'

      class_option :metatags,           type: :boolean, default: false, aliases: '-m',
                                        desc: 'If views will assign pages title using metatags gem'

      class_option :simpleform,         type: :boolean, default: false, aliases: '-sf',
                                        desc: 'Enable SimpleForms for the form generating'

      def install
        template "#{file_template_location('confirmations/new')}.tt", "app/views/devise/confirmations/new.html.#{options[:template_engine]}", force: true
        directory "#{options[:template_engine]}/mailer", 'app/views/devise/mailer', force: true

        %i[edit new].map do |file|
          template "#{file_template_location("passwords/#{file}")}.tt", "app/views/devise/passwords/#{file}.html.#{options[:template_engine]}", force: true
          template "#{file_template_location("registrations/#{file}")}.tt", "app/views/devise/registrations/#{file}.html.#{options[:template_engine]}", force: true
        end
        template "#{file_template_location('sessions/new')}.tt", "app/views/devise/sessions/new.html.#{options[:template_engine]}", force: true
        template "#{file_template_location('unlocks/new')}.tt", "app/views/devise/unlocks/new.html.#{options[:template_engine]}", force: true
        directory "#{options[:template_engine]}/shared", 'app/views/devise/shared', force: true
      end

      private

      def file_template_location(file_location = '')
        return '' if file_location.blank?

        # Depending if simpleform is to be used, it will return a path similar to one of the following:
        # => slim/unlocks/new.html.slim || simple_form/slim/unlocks/new.html.slim
        "#{simple_path}#{options[:template_engine]}/#{file_location}.html.#{options[:template_engine]}"
      end

      # If simpleform is going ot be used with the forms return a simple_form path
      def simple_path
        options[:simpleform] ? 'simple_form/' : ''
      end
    end
  end
end
