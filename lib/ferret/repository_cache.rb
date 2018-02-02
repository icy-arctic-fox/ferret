module Ferret
  # Tracks repositories already known about to avoid recreation.
  class RepositoryCache
    # Creates an empty repository cache.
    def initialize
      @cache = Hash.new
    end

    # Attempts to find a repository entry in the cache.
    # This method yields when an item isn't found in the cache.
    # The return value from the block will be stored in the cache and associated with the repository.
    # @param repository [Repository] Repository to look for.
    # @return [Object] Value associated with the repository that was previously stored.
    # @yieldparam repository [Repository] Repository not found in the cache.
    # @yieldreturn [Object] Value associated with the repository to store.
    def lookup(repository)
      return @cache[repository] if @cache.has_key?(repository)
      @cache[repository] = yield(repository)
    end

    # Removes all entries from the cache.
    # @return [void]
    def clear
      @cache.clear
    end
  end
end