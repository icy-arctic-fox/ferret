require_relative 'reference'

module Ferret
  # Reference to another revision in the repository.
  class RevisionReference < Reference
    # Revision being referenced.
    # @return [RevisionId]
    attr_reader :revision
  end
end