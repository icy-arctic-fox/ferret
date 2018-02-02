module Ferret
  # Identifier used to reference a revision or commit in the repository
  class RevisionId
    # ID of the revision.
    # @return [String]
    attr_reader :id

    # Reference back to the repository this revision exists in.
    # @return [Repository]
    attr_reader :repository
  end
end