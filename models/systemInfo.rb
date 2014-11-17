class SystemInfo
  include Mongoid::Document

  field :memory, type: String
  field :disk, type: String
end