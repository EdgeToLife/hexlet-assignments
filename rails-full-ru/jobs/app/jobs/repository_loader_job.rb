class RepositoryLoaderJob < ApplicationJob
  queue_as :default

  def perform(repository)
    begin
      repository.to_fetch
      octokit_repo = Octokit::Repository.from_url(repository[:link])
      client = Octokit::Client.new
      repository_data = client.repository(octokit_repo)
      repository.update!(
        owner_name: repository_data[:owner][:login],
        repo_name: repository_data[:name],
        description: repository_data[:description],
        default_branch: repository_data[:default_branch],
        watchers_count: repository_data[:watchers_count],
        language: repository_data[:language],
        repo_created_at: repository_data[:created_at],
        repo_updated_at: repository_data[:updated_at]
      )

      repository.to_fetched!

    rescue
      repository.to_failed!
    end
  end
end
