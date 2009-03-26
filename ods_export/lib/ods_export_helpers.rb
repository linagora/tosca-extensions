module OdsExportHelpers
  def self.included(base)
    base.class_eval {
      helper :export
    }
  end
end
