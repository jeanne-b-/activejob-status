# frozen_string_literal: true

require "bundler/setup"
Bundler.setup

require "active_job"
require "activejob-status"

Dir.mkdir("tmp") unless Dir.exist?("tmp")

ActiveJob::Base.queue_adapter = :test
ActiveJob::Base.logger = ActiveSupport::TaggedLogging.new(ActiveSupport::Logger.new(File.open("tmp/log", "w")))
ActiveJob::Status.store = :memory_store

RSpec.configure do |config|
  config.expect_with :rspec do |expect|
    expect.syntax = :expect
  end

  config.include ActiveJob::TestHelper
end
