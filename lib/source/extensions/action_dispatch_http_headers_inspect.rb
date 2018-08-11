module ActionDispatchHttpHeadersInspect
  def inspect
    "#<#{self.class.name} ...>"
  end
end

ActionDispatch::Http::Headers.prepend(ActionDispatchHttpHeadersInspect)
