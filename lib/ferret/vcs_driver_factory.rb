module Ferret
  # Creates the correct VCS driver based on type.
  class VcsDriverFactory
    # Creates a new factory.
    # @param cache [RepositoryCache] Cache used for the driver.
    # @param work_dir [String] Working directory to store scratch files in.
    def initialize(cache, work_dir)
      @cache    = cache
      @work_dir = work_dir
      freeze
    end

    # Creates a VCS driver based on type.
    # @param type [Symbol] Type of driver to create.
    # @return [VcsDriver]
    def create(type)
      case type
        when :git
          Git::GitVcsDriver.new(@cache, @work_dir)
        else
          raise "Unknown VCS driver type #{type}"
      end
    end
  end
end