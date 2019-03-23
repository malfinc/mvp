if File.exist?(Rails.root.join("config", "sidecloq.yml"))
  Sidecloq.configure do |config|
    # config[:schedule_file] = Rails.root.join("config", "sidecloq.yml")
  end
end
