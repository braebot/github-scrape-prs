require "body_parser"

describe BodyParser do
  describe ".parse" do
    context "an empty list" do
      it "returns an empty list" do
        parsed_pulls = BodyParser.new().parse([])
        expect(parsed_pulls.length).to eql(0)
      end
    end

    context "given a problem/solution body" do
      it "returns a parsed body with values filled in with" do

        body = """
### Problem

The problem

### Solution

The solution"""
        trimmed_pulls = []
        trimmed_pulls.push({
          :html_url => "test_url",
          :body => body
        })
        parsed_pulls = BodyParser.new().parse(trimmed_pulls)
        expect(parsed_pulls.length).to eql(1)
        puts parsed_pulls
        expect(parsed_pulls[0][:html_url]).to eql("test_url")
        expect(parsed_pulls[0][:template_format]).to eql("problem_solution")
        expect(parsed_pulls[0][:problem_statement]).to eql("The problem")
        expect(parsed_pulls[0][:solution_statement]).to eql("The solution")
      end
    end

    context "given a what/why body" do
      it "returns a parsed body with values filled in" do
        body = """
## What

The what

## Why

The why"""
        trimmed_pulls = []
        trimmed_pulls.push({
          :html_url => "test_url",
          :body => body
        })
        parsed_pulls = BodyParser.new().parse(trimmed_pulls)
        expect(parsed_pulls.length).to eql(1)
        expect(parsed_pulls[0][:html_url]).to eql("test_url")
        expect(parsed_pulls[0][:template_format]).to eql("what_why")
        expect(parsed_pulls[0][:problem_statement]).to eql("The why")
        expect(parsed_pulls[0][:solution_statement]).to eql("The what")
      end
    end

    context "given a what/something else body" do
      it "returns a parsed body with only the solution filled in" do
        body = """
## What

The what

## Concerns

The concerns"""
        trimmed_pulls = []
        trimmed_pulls.push({
          :html_url => "test_url",
          :body => body
        })
        parsed_pulls = BodyParser.new().parse(trimmed_pulls)
        expect(parsed_pulls.length).to eql(1)
        expect(parsed_pulls[0][:html_url]).to eql("test_url")
        expect(parsed_pulls[0][:template_format]).to eql("what_only")
        expect(parsed_pulls[0][:problem_statement]).to eql(nil)
        expect(parsed_pulls[0][:solution_statement]).to eql("The what")
      end
    end
  end
end