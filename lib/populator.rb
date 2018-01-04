require_relative "pr_reader"
require_relative "body_parser"

class Populator
  def populate(repo_url)
    pulls = PrReader.new().read(repo_url)

    parsed_pulls = BodyParser.new().parse(pulls)

    parsed_pulls.each do |pull|
      puts "#{pull[:html_url]}|#{pull[:problem_statement]}|#{pull[:solution_statement]}|#{pull[:template_format]}"
    end
  end
end
