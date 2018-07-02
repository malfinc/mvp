class AlterTypeUuidOwnerToSelf < ActiveRecord::Migration[5.1]
  def change
    safety_assured do
      execute(%(ALTER TYPE uuid OWNER TO CURRENT_USER))
    end
  end
end
