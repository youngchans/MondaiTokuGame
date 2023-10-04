class StartController < ApplicationController
  def start_p
    record_count = Quest.count
    random_id = rand(1..record_count)
    @random_quest = Quest.find(random_id)
  end
end
