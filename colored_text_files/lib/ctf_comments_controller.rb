module CtfCommentsController
  def self.included(base)
    base.class_eval {
      helper :uv
    }
  end
end
