ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Returns true if a test user is logged in.
  def is_logged_in?
    !session[:user_id].nil?
  end

  # Log in as a particular user (for use in controller tests)
  # def log_in_as(user)
  #   session[:user_id] = user.id
  # end
end

# Since session can't be manipulated inside integration test, this is an
# alternative to log_in_as
class ActionDispatch::IntegrationTest
  # Log in as a particular user.
  def log_in_as(user, password: "zvjezdana")
    post login_path, params: { session: { username: user.username,
                                          password: password } }
  end
end