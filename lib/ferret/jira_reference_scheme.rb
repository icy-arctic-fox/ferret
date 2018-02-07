require_relative 'reference_scheme'

module Ferret
  # Information for finding JIRA references in text.
  class JiraReferenceScheme < ReferenceScheme
    # Creates a scheme for finding JIRA ticket references.
    # @param key [String] Abbreviation that ticket numbers are prefixed with.
    #   For instance: JIRA-1234, the 'JIRA' part is the key.
    # @param server_url [String] Base URL of the server.
    def initialize(key, server_url)
      @regex      = /(?:\A|\b)(#{Regexp.escape(key)}-\d+)(?:\b|\z)/
      @server_url = server_url
      freeze
    end

    # Attempts to find all JIRA references in text.
    # @param text [String] Text to search through.
    # @return [Enumerable<JiraReference>] Found references.
    def find_all(text)
      text.scan(@regex).map do |match|
        name = match.first
        url  = "#{@server_url}/browse/#{name}"
        JiraReference.new(name, url)
      end
    end
  end
end