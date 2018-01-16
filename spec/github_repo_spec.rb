require "github_repo"

describe GitHubRepo do
  describe ".initialize" do
    context "given a github.com url" do
      repo_url = "git@github.com:braebot/test.git"

      it "returns the parsed fields" do
        github_repo = GitHubRepo.new(repo_url)
        expect(github_repo.org).to eql('braebot')
        expect(github_repo.repo).to eql('test')
        expect(github_repo.domain).to eql('github.com')
      end
    end

    context "given a example.com url" do
      repo_url = "git@github.example.com:org-name/repo-name.git"

      it "returns the parsed fields" do
        github_repo = GitHubRepo.new(repo_url)
        expect(github_repo.org).to eql('org-name')
        expect(github_repo.repo).to eql('repo-name')
        expect(github_repo.domain).to eql('github.example.com')
      end
    end
  end
end
