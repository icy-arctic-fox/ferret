module Ferret
  # Searches for references of known types in a repository.
  class ReferenceFinder
    # Creates a reference finder.
    # @param schemes [Enumerable<ReferenceScheme>] Schemes used to find references.
    def initialize(schemes = [])
      @schemes = schemes.to_a.dup.freeze
      freeze
    end

    # Attempts to find references from a branch instance.
    # This only scans the branch context, not the commits on it.
    # @param branch [Branch] Branch to search.
    # @return [Enumerable<Reference>] Found references.
    def search_branch(branch)
      search_text(branch.name)
    end

    # Attempts to find references from a tag instance.
    # This only scans the tag context, not the commits on it.
    # @param tag [Tag] Tag to search.
    # @return [Enumerable<Reference>] Found references.
    def search_tag(tag)
      search_text(tag.name)
    end

    # Attempts to find references in a commit.
    # @param commit [Commit] Commit to search.
    # @return [Enumerable<Reference>] Found references.
    def search_commit(commit)
      search_text(commit.message)
    end

    # Attempts to find references in plain text.
    # @param text [String] Text to search.
    # @return [Enumerable<Reference>] Found references.
    def search_text(text)
      sets = @schemes.map do |scheme|
        scheme.find_all(text).uniq
      end
      sets.flatten.uniq
    end
  end
end