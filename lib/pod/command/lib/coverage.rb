require 'cocoapods_testing'
require 'slather'
require 'xcodeproj'

module Pod
  class Command
    class Lib
      # @todo Create a PR to add your plugin to CocoaPods/cocoapods.org
      #       in the `plugins.json` file, once your plugin is released.
      #
      class Coverage < Lib
        self.summary = 'Generate code coverage statistics for Pods.'

        self.description = <<-DESC
          Longer description of cocoapods-coverage.
        DESC

        def run
          test_with_coverage

          Pod::Command::Lib::Testing.handle_workspaces_in_dir(Pathname.pwd) do |workspace, _path|
            workspace.file_references.each do |file_ref|
              next unless file_ref.path.end_with? '.xcodeproj'
              next if file_ref.path == 'Pods/Pods.xcodeproj'
              ref_path = File.absolute_path(file_ref.path, Pathname.new(_path).dirname)
              slather(ref_path)
            end
          end
        end

        def slather(project_path)
          return if not File.directory?(project_path)
          project = Slather::Project.open(project_path)

          if ENV['TRAVIS'] == 'true'
            project.coverage_service = :coveralls
          else
            project.coverage_service = :terminal
          end

          begin
            project.post

            project.coverage_service = :gutter_json
            project.post
          rescue
          end
        end

        def test_with_coverage
          args = CLAide::ARGV.new(['GCC_GENERATE_TEST_COVERAGE_FILES=YES',
                                   'GCC_INSTRUMENT_PROGRAM_FLOW_ARCS=YES'])
          tester = Pod::Command::Lib::Testing.new(args)
          tester.run
        end
      end
    end
  end
end
