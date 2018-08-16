module PaperTrailRecordTrailBackground
  def record_create
    return unless enabled?

    @in_after_callback = true

    data_for_create.tap do |attributes|
      @record.class.paper_trail.version_class.after_transaction do
        VersionJob.perform_async(@record.class.paper_trail.version_class, attributes.merge(:item_id => @record.id, :item_type => @record.class.name))
      end
    end
  ensure
    @in_after_callback = false
  end

  def record_destroy(recording_order)
    return unless enabled?

    @in_after_callback = recording_order == "after"

    return if @record.new_record?

    data_for_destroy.tap do |attributes|
      @record.class.paper_trail.version_class.after_transaction do
        VersionJob.perform_async(@record.class.paper_trail.version_class, attributes.merge(:item_id => @record.id, :item_type => @record.class.name))
      end
    end
  ensure
    @in_after_callback = false
  end

  def record_update(force:, in_after_callback:, is_touch:)
    return unless enabled?

    @in_after_callback = in_after_callback

    return unless force == true || changed_notably?

    data_for_update(is_touch).tap do |attributes|
      @record.class.paper_trail.version_class.after_transaction do
        VersionJob.perform_async(@record.class.paper_trail.version_class, attributes.merge(:item_id => @record.id, :item_type => @record.class.name))
      end
    end
  ensure
    @in_after_callback = false
  end
end

PaperTrail::RecordTrail.prepend(PaperTrailRecordTrailBackground)
