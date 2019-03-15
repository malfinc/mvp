module HashFetchDeep
  def fetch_deep(*keys)
    keys.reduce(self) do |value, key|
      raise(TypeError, "value for #{key} does not respond to fetch") unless value.respond_to?(:fetch)

      value.fetch(key)
    end
  end
end

Hash.prepend(HashFetchDeep)
