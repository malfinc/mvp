class AddVarcharToUuidCast < ActiveRecord::Migration[5.1]
  def change
    safety_assured do
      execute(%(CREATE CAST (varchar AS uuid) WITH INOUT AS IMPLICIT))
    end
  end
end
