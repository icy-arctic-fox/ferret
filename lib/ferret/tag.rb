module Ferret
  # An important point in the repository.
  # @abstract Implemented by a sub-class based on the repository type.
  class Tag
    # Display name of the tag.
    # @return [String]
    attr_reader :name

    # Revision the tag is placed at.
    # @return [RevisionId]
    attr_reader :revision

    # Creates a tag reference.
    # @param name [String] Display name of the tag.
    # @param revision [RevisionId] Revision the tag is placed at.
    def initialize(name, revision)
      @name     = name
      @revision = revision
      freeze
    end
  end
end