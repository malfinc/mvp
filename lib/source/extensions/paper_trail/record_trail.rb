module PaperTrail
  class RecordTrail
    def record_create
      return unless enabled?

      @in_after_callback = true

      @record.class.paper_trail.version_class.after_transaction do
        VersionJob.perform_async(@record.class.paper_trail.version_class, data_for_create)
      end
    ensure
      @in_after_callback = false
    end

    def record_destroy(recording_order)
      return unless enabled?

      @in_after_callback = recording_order == "after"

      unless @record.new_record?
        @record.class.paper_trail.version_class.after_transaction do
          VersionJob.perform_async(@record.class.paper_trail.version_class, data_for_destroy)
        end
      end
    ensure
      @in_after_callback = false
    end

    def record_update(force:, in_after_callback:, is_touch:)
      return unless enabled?

      @in_after_callback = in_after_callback

      if force == true || changed_notably?
        @record.class.paper_trail.version_class.after_transaction do
          VersionJob.perform_async(@record.class.paper_trail.version_class, data_for_update(is_touch))
        end
      end
    ensure
      @in_after_callback = false
    end
  end
end
