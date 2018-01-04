class BodyParser
  def parse(trimmed_pulls)
    parsed_pulls = []
 
    trimmed_pulls.each do |pull|
      split_body = pull[:body].split(/^#[#]+/)

      if split_body.length > 1
        first_trimmed_content = split_body[1].strip

        if split_body.length > 2
          second_trimmed_content = split_body[2].strip
        end

        if first_trimmed_content.start_with?('Problem')
          # puts "Found a Problem/Solution"
          template_format = 'problem_solution'
          problem_statement = first_trimmed_content.split(/^Problem/)[1].gsub("\n",'').gsub("\r",'').strip

          if second_trimmed_content && second_trimmed_content.split(/^Solution/).length > 1
            solution_statement = second_trimmed_content.split(/^Solution/)[1].gsub("\n",'').gsub("\r",'').strip
          else
            solution_statement = "<empty>"
          end
        elsif first_trimmed_content.start_with?('What')
          if second_trimmed_content && second_trimmed_content.start_with?('Why')
            # puts "Found a What/Why"
            template_format = 'what_why'

            split_first_trimmed_content = first_trimmed_content.split(/^What/)
            solution_statement = first_trimmed_content.split(/^What/)[1].gsub("\n",'').gsub("\r",'').strip

            if second_trimmed_content && second_trimmed_content.split(/^Why/).length > 1
              problem_statement = second_trimmed_content.split(/^Why/)[1].gsub("\n",'').gsub("\r",'').strip
            else
              problem_statement = "<empty>"
            end
          else
            # puts "Found something else"
            template_format = 'what_only'
            solution_statement = first_trimmed_content.split(/^What/)[1].gsub("\n",'').gsub("\r",'').strip
          end
        else
          template_format = "unknown"
        end
      else
        template_format = "no_headers_found"
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
