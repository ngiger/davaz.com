#!/usr/bin/env ruby
$:.unshift File.expand_path('..', File.dirname(__FILE__))
require 'test_helper'
require 'rack/test'

class TestMovies < Minitest::Test
  include DaVaz::TestCase

  def setupl
    startup_server
  end

  def test_mock_login
    binding.pry
    browser = Rack::Test::Session.new(Rack::MockSession.new($app))
    first_login(browser)
  end if false
  def test_login_then_logout
    # sleep 1
    # browser.visit('/en/gallery/gallery/')
    # browser.visit('/en/personal/work')
    # sleep 1
    first_login(browser)
    logout_link = browser.link(name: 'logout')
    assert_equal(true, logout_link.exists? && logout_link.visible?, 'Could not log in. Logout-link must be present!')
    logout_link = browser.link(name: 'logout')
    assert_equal(true, logout_link.exists? && logout_link.visible?, 'Could not log in. Logout-link must no longer be present!')
    SBSM.info "Going to movies"
    browser.link(:id => 'movies').click
    logout_link = browser.link(name: 'logout')
    assert_equal(true, logout_link.exists? && logout_link.visible?, 'Could not log in. Logout-link must no longer be present!')

    logout
    login_link = browser.link(text: 'Login')
    login_link.wait_until(&:exist?)

    logout_link = browser.link(name: 'logout')
    assert_equal(false, logout_link.exists? && logout_link.visible?, 'Could not log in. Logout-link must no longer be present!')
  end

  def first_login(a_browser)
    a_browser.visit('/en/personal/work')
    link = a_browser.a(id: 'movies')
    link.click
    login_as( {email: TEST_USER, password: TEST_PASSWORD}, a_browser)

    logout_link = a_browser.link(name: 'logout')
    unless logout_link.exists? && logout_link.visible?
        SBSM.info msg = "Logout is not shown. Workaround: Going to Guestbook"
        puts msg
      a_browser.goto(a_browser.links.find{|x| x.text.eql?('Guestbook')}.href)
    end
    logout_link = a_browser.link(name: 'logout')
    assert_equal(true, logout_link.exists? && logout_link.visible?, 'Could not log in. Logout-link must no longer be present!')
  end

  def do_logout(a_browser)
    logout(a_browser)
    login_link = a_browser.link(text: 'Login')
    login_link.wait_until(&:exist?)

    logout_link = a_browser.link(name: 'logout')
    assert_equal(false, logout_link.exists? && logout_link.visible?, 'Could not log in. Logout-link must no longer be present!')
  end

  def test_login_in_to_browsers
    first_login(browser)
    browser_2 = DaVaz::Browser.new(id: 2)
    first_login(browser_2)
    do_logout(browser)
    do_logout(browser_2)
  end if false
end
