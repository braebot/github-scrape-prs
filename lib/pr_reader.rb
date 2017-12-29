require "github_repo"

class PrReader
  def initialize()
  end

  def read(repo_url)
    github_repo = GitHubRepo.new(repo_url)

    trimmed_pulls = []
    begin
      Octokit.auto_paginate = true
      pulls = github_repo.client.pulls("#{github_repo.org}/#{github_repo.repo}", :state => 'all')

      puts "Found #{pulls.length} PRs"

      pulls.each do |pull|
        trimmed_pull = {
          :html_url => pull.html_url, 
          :body => pull.body
        }
        trimmed_pulls.push(trimmed_pull)
      end
    rescue => error
      puts "<could not read releases from github>"
      puts "\xE2\x9C\x98 FAILURE: #{error.inspect}"
      abort()
    end

    trimmed_pulls
  end
end