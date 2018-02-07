require 'yaml'

module Ferret
  # Configuration settings for Ferret.
  class Settings
    # Collection of known repositories.
    # @return [Hash] Hash where keys are the repository's ID and the value is a +Repository+ instance.
    attr_reader :repositories

    # Path to the directory to cache repository files in.
    # @return [String]
    attr_reader :work_dir

    # Creates configuration settings.
    # @param repositories [Hash] Collection of known repositories indexed by name.
    # @param reference_mapping [Hash] Collection of reference schemes indexed by repository name.
    # @param work_dir [String] Path to the directory to cache repository files in.
    def initialize(repositories, reference_mapping, work_dir)
      @repositories      = repositories.dup.freeze
      @reference_mapping = reference_mapping.dup.freeze
      @work_dir          = work_dir
      freeze
    end

    # Get reference schemes to be used for a given repository.
    # @param repository_name [String] Name of the repository to get reference schemes for.
    # @return [Array<ReferenceScheme>] Schemes to use for the repository.
    def references_for_repository(repository_name)
      @reference_mapping[repository_name] || []
    end

    class << self
      # Loads configuration settings from a YAML file.
      # @param path [String] Path to the configuration file.
      # @return [Settings] Loaded settings.
      def load(path)
        obj = YAML.load_file(path)
        references   = build_references(obj['references'] || [])
        auth_methods = build_auth_methods(obj['auth'] || [])
        repositories = build_repositories(obj['repositories'] || [], auth_methods)
        reference_mapping = map_references_to_repositories(obj['repositories'] || [], references)
        new(repositories, reference_mapping, obj['work_dir'])
      end

      private

      def build_references(arr)
        Hash[arr.map do |obj|
          name = obj['name']
          [name, build_reference(obj)]
        end]
      end

      def build_reference(obj)
        type = obj['type']
        case type
          when 'jira'
            JiraReferenceScheme.new(obj['key'], obj['url'])
          when 'revision'
            raise NotImplementedError
          when 'github'
            raise NotImplementedError
          else
            raise "Unknown reference type #{type}"
        end
      end

      def build_auth_methods(arr)
        Hash[arr.map do |obj|
          name = obj['name']
          [name, build_auth_method(obj)]
        end]
      end

      def build_auth_method(obj)
        type = obj['type']
        case type
          when 'user-password'
            UserPasswordAuth.new(obj['user'], obj['password'])
          when 'ssh-key'
            SshKeyAuth.new(obj['private'], obj['public'])
          else
            raise "Unknown authentication method #{type}"
        end
      end

      def build_repositories(arr, auth_methods)
        auth_name = obj['auth']
        auth = auth_name ? auth_methods[auth_name] : nil
        Hash[arr.map do |obj|
          name = obj['name']
          [name, build_repository(obj, auth)]
        end]
      end

      def build_repository(obj, auth)
        type = obj['type']
        case type
          when 'github'
            Git::GitHubRepository.new(obj['url'], auth)
          when 'git'
            Git::GitRepository.new(obj['url'], auth)
          else
            raise "Unknown repository type #{type}"
        end
      end

      def map_references_to_repositories(repos_arr, references)
        repos_arr.map do |repo_obj|
          if repo_obj.has_key?('references')
            mapping = repo_obj['references'].map do |ref_name|
              references[ref_name]
            end
            mapping.compact
          else
            []
          end
        end
      end
    end
  end
end