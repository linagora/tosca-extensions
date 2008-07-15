require File.dirname(__FILE__) + '/../test_helper'

class JabberNotifierExtensionTest < Test::Unit::TestCase
  
  # Replace this with your real tests.
  def test_this_extension
    flunk
  end
  
  def test_initialization
    assert_equal File.join(File.expand_path(RAILS_ROOT), 'vendor', 'extensions', 'jabber_notifier'), JabberNotifierExtension.root
    assert_equal 'Jabber Notifier', JabberNotifierExtension.extension_name
  end
  
end
