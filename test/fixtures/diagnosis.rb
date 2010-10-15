require 'rubygems'
require 'active_record'

class Diagnosis < ActiveRecord::Base
  extend NamedInstances
  has_named_instances :name
end

ActiveRecord::Base.establish_connection :adapter => 'sqlite3', :database => 'test/test.db'

ActiveRecord::Schema.define do
  create_table :diagnoses, :force => true do |t|
    t.string :name
    t.timestamps
  end

  Diagnosis.create :name => "Hypertension"
  Diagnosis.create :name => "Diabetes Mellitus"
end
