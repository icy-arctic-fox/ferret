module Ferret
  # Identifier used to reference a revision or commit in the repository
  class RevisionId
    # ID of the revision.
    # @return [String]
    attr_reader :id

    # Reference back to the repository this revision exists in.
    # @return [Repository]
    attr_reader :repository

    # Creates a revision identifier.
    # @param id [String] ID of the revision.
    # @param repository [Repository] Reference back to the repository this revision exists in.
    def initialize(id, repository)
      @id         = id
      @repository = repository
      freeze
    end

    def ==(other)
      other.id == id
    end

    def to_s
      "#{repository} rev: #{id}"
    end
  end
end