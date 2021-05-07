class GuestsCleanupJob < ApplicationJob
  queue_as :low_priority

  def perform(*guests)
    # Do something later
    puts guests.to_s
  end
end
