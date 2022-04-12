# frozen_string_literal: true

class Book
  attr_reader :attributes, :relationships

  def initialize(id, attributes, relationships)
    @id = id
    @attributes = attributes
    @relationships = relationships
  end

  def to_s
    "Название книги: #{@attributes['name']}\n"
  end
end
