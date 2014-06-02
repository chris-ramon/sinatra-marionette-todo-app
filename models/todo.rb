require 'ohm'


class Todo < Ohm::Model
  attribute :text
  attribute :status
end