require File.dirname(__FILE__) + '/../test_helper'

class ColoredTextFilesExtensionTest < Test::Unit::TestCase
  
  # Replace this with your real tests.
  def test_this_extension
    flunk
  end
  
  def test_initialization
    assert_equal File.join(File.expand_path(RAILS_ROOT), 'vendor', 'extensions', 'colored_text_files'), ColoredTextFilesExtension.root
    assert_equal 'Colored Text Files', ColoredTextFilesExtension.extension_name
  end
  
end
