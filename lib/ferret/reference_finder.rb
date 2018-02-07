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
    # @yieldparam reference [Reference] Found reference.
    # @return [Enumerable<Reference>] Found references.
    def search_branch(branch, &block)
      return enum_for(:search_branch) unless block_given?
      search_text(branch.name, &block)
    end

    # Attempts to find references from a tag instance.
    # This only scans the tag context, not the commits on it.
    # @param tag [Tag] Tag to search.
    # @yieldparam reference [Reference] Found reference.
    # @return [Enumerable<Reference>] Found references.
    def search_tag(tag, &block)
      return enum_for(:search_tag) unless block_given?
      search_text(tag.name, &block)
    end

    # Attempts to find references in a commit.
    # @param commit [Commit] Commit to search.
    # @yieldparam reference [Reference] Found reference.
    # @return [Enumerable<Reference>] Found references.
    def search_commit(commit, &block)
      return enum_for(:search_commit) unless block_given?
      search_text(commit.message, &block)
    end

    # Attempts to find references in plain text.
    # @param text [String] Text to search.
    # @yieldparam reference [Reference] Found reference.
    # @return [Enumerable<Reference>] Found references.
    def search_text(text, &block)
      return enum_for(:search_text) unless block_given?
      sets = @schemes.map do |scheme|
        scheme.find_all(text).uniq
      end
      sets.flatten.uniq.each(&block)
    end
  end
end