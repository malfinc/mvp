if Rails.env.development? && ENV.key?("DEBUG")
  ActiveRecordQueryTrace.enabled = true
  ActiveRecordQueryTrace.lines = 0
  ActiveRecordQueryTrace.level = :full
end
