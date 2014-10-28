class Submission < ActiveRecord::Base

  belongs_to :import

  state_machine :state, initial: :new do
    state :new
    state :processing
    state :success
    state :error

    event :process do
      transition [:new, :error] => :processing
    end

    event :successful do
      transition :processing => :success
    end

    event :failed do
      transition :processing => :error
    end

  end
end
