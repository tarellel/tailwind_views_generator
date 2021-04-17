# frozen_string_literal: true

require 'simplecov'
SimpleCov.start('rails') do
  add_filter('/bin/')
  add_filter('/lib/templates/**.**')
end
SimpleCov.minimum_coverage(90)
SimpleCov.use_merging(false)
