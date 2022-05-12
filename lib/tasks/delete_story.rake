# frozen_string_literal: true

namespace :delete_story do
  desc 'Delete records older than 24 hours'
  task delete_1_days_old: :environment do
    Story.where(['created_at < ?', 10.hours.ago]).destroy_all
  end
end
