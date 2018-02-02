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

    # Indicates whether this branch is the default in the repository.
    def default?
      raise NotImplementedError
    end
  end
end