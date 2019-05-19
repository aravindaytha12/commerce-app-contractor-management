# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

def run_tests(platform, browser, version, junit_dir)
  environment_variables = {
    'SELENIUM' => 'true',
    'REMOTE' => 'true',
    'platform' => platform,
    'browserName' => browser,
    'version' => version,
    'JUNIT_DIR' => junit_dir,
    'SAUCE_USERNAME' => ENV['SAUCE_USERNAME'],
    'SAUCE_ACCESS_KEY' => ENV['SAUCE_ACCESS_KEY']
  }

  system(environment_variables, 'rspec spec/integration -f progress --format html --out selenium_results.html')
  fail 'run_tests' unless $?.exitstatus == 0
end

task :windows_8_1_chrome do
  run_tests('Windows 8.1', 'chrome', '51', 'junit_reports/windows_8_1_chrome')
end

task :windows_7_firefox do
  run_tests('Windows 7', 'firefox', '47', 'junit_reports/windows_7_firefox')
end

task :os_x_10_11_chrome do
  run_tests('OS X 10.11', 'chrome', '51', 'junit_reports/os_x_10_11_chrome')
end

multitask :test_sauce => [
            :windows_8_1_chrome,
            :windows_7_firefox,
            :os_x_10_11_chrome,
          ] do
  puts 'Running Test Automation on Sauce Labs'
end
