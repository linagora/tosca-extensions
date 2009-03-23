module CtfIssuesController
  def self.included(base)
    base.class_eval {
      helper :uv
    }
  end
end
