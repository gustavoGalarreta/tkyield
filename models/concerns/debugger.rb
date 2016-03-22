module Debugger
  extend ActiveSupport::Concern

  included do
    around_save :around_save_callback
  end

  def around_save_callback
    ap "Before save #{self.class.name}"
    yield
    ap "After save #{self.class.name}"
  end

end
