require "test_helper"

class ApplicationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end
  setup do
    get '/users/sign_in'
    sign_in users(:one)
    post user_session_url
    @job =  Job.create(title: "New Job", description: "Some description")
    @application = Application.create(content: "New application", job_id: Job.first.id)   
  end

  test "should get index" do    
    get applications_url
    assert_response :success
    assert_equal 200, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
    assert_equal Application.count, 2
  end

  test "should create application" do
    assert_difference "Application.count", 1 do
      post applications_url, params:
      { application:{
        content: "New application", 
        job_id: Job.first.id
      }}
    end
    assert_redirected_to jobs_url
    assert_response :found
    assert_equal 302, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

  test "should get edit" do
    get edit_application_url(applications(:one))
    assert_response :success
    assert_equal 200, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

  test "should update application" do
    patch application_url(applications(:one)), params:
      { application:{
        content: "Updated application"        
      }}
    applications(:one).reload
    assert_redirected_to applications_url
    assert_response :found
    assert_equal "Updated application", applications(:one).content   
    assert_equal 302, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end

  test "should destroy application" do
    assert_difference "Application.count", -1 do
      delete application_url(applications(:one))
    end
    assert_redirected_to applications_url
    assert_response :found
    assert_equal 302, response.status
    assert_equal "text/html", response.media_type
    assert_equal "utf-8", response.charset
  end
end
