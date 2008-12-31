require File.dirname(__FILE__) + '/../test_helper'
require 'issues_controller'

# Re-raise errors caught by the controller.
# class IssuesController; def rescue_action(e) raise e end; end
class ExportControllerTest < Test::Unit::TestCase

  fixtures :all

  def setup
    login 'admin', 'admin'
  end

  def test_contributions
    get :contributions, :format => 'ods'
    assert_response :success
  end

  def test_users
    get :users, :format => 'ods'
    assert_response :success
  end

  def test_phonecalls
    get :phonecalls, :format => 'ods'
    assert_response :success
  end

  def test_issues
    get :issues, :format => 'ods'
    assert_response :success
  end

end
