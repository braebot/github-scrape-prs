require "pr_reader"

class BodyParser
  def parse(trimmed_pulls)
    parsed_pulls = []
 
    trimmed_pulls.each do |pull|
      split_body = pull[:body].split(/^#[#]+/)

      first_trimmed_content = split_body[1].strip
      second_trimmed_content = split_body[2].strip

      if first_trimmed_content.start_with?('Problem')
        puts "Found a Problem/Solution"
        template_format = 'problem_solution'
        problem_statement = first_trimmed_content.split(/^Problem$/)[1].strip
        solution_statement = second_trimmed_content.split(/^Solution$/)[1].strip
      elsif first_trimmed_content.start_with?('What')
        if second_trimmed_content.start_with?('Why')
          puts "Found a What/Why"
          template_format = 'what_why'
          solution_statement = first_trimmed_content.split(/^What$/)[1].strip
          problem_statement = second_trimmed_content.split(/^Why$/)[1].strip
        else
          puts "Found somethign else"
          template_format = 'what_only'
          solution_statement = first_trimmed_content.split(/^What$/)[1].strip
        end
      else
        template_format = "unknown"
      end

      parsed_pull = {
        :html_url => pull[:html_url],
        :template_format => template_format,
        :problem_statement => problem_statement,
        :solution_statement => solution_statement,
      }
      parsed_pulls.push(parsed_pull)
    end

    parsed_pulls
  end
end
