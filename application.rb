$LOAD_PATH.unshift(File.dirname(__FILE__))

require "stack/env"
require "stack/db"

DB.connect

require "trailblazer/operation"
# require "reform/form/active_model/validations"

# TODO: initializers/01_reform.rb
require "reform/form/dry"
require "reform/form/coercion"
require "disposable/twin/property/hash"
# 02_cells.rb
Trailblazer::Cell.send :include, Cell::Erb

Reform::Form.class_eval do
  include Reform::Form::Dry
end

Trailblazer::Loader.new.(debug: false, concepts_root: "./concepts/") { |file|
  puts file
  require_relative(file) }

# In a Tamarama stack, you don't need app/concepts/ but only concepts/
Trailblazer::Cell.view_paths = ["concepts"]
# use Bootstrap 3
Formular::Helper.builder(:bootstrap3)

module Exp
  class Application < Sinatra::Base
    get "/expenses/new" do
      Expense::Endpoint::New.( params: params )
    end

    post "/expenses" do
      Expense::Endpoint.create( params: params, sinatra: self )
    end

    # Get assets going.
    # the appends tell sprockets where files *could* be, no types, nothing.
    set :environment, Sprockets::Environment.new
    environment.append_path "assets/css"
    environment.append_path "assets/js"
    environment.append_path "assets"

    get "/assets/*" do
      env["PATH_INFO"].sub!("/assets", "")
      settings.environment.call(env)
    end
  end
end
