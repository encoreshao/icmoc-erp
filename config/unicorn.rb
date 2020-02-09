# frozen_string_literal: true

worker_processes Integer(ENV['WEB_CONCURRENCY'] || 4)
