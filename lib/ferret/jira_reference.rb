require_relative 'reference'

module Ferret
  # Reference information to a JIRA ticket.
  class JiraReference < Reference
    attr_reader :url

    def type
      :jira
    end

    def initialize(name, url)
      @url = url
      super(name)
    end
  end
end