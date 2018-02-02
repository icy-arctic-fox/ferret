module Ferret
  # Tracks repositories already known about to avoid recreation.
  class RepositoryCache
    def initialize
      @cache = Hash.new
    end

    def lookup(repository)
      return @cache[repository] if @cache.has_key?(repository)
      @cache[repository] = yield(repository)
    end

    def clear
      @cache.clear
    end
  end
end