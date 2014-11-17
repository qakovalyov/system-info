class SystemInfo
  include Mongoid::Document

  field :task, type: String
  field :info, type: String
end