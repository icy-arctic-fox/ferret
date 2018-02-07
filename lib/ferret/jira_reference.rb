require_relative 'reference'

module Ferret
  # Reference information to a JIRA ticket.
  class JiraReference < Reference
    attr_reader :url

    def initialize(name, url)
      @url  = url
      super(name)
    end
  end
end