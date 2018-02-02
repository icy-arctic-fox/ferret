module Ferret
  # A single code stream in a repository.
  # @abstract Implemented by a sub-class based on the repository type.
  class Branch
    # Display name of the branch.
    # @return [String]
    attr_reader :name

    # Revision at the tip of the branch.
    # @return [RevisionId]
    attr_reader :revision

    # Creates a branch reference.
    # @param name [String] Display name of the branch.
    # @param revision [RevisionId] Revision at the tip of the branch.
    def initialize(name, revision)
      @name     = name
      @revision = revision
      freeze
    end
  end
end