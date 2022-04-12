# frozen_string_literal: true

class Author
  attr_reader :name, :letter, :id

  def initialize(id, name, letter)
    @id = id
    @name = name
    @letter = letter
  end

  def to_s
    "ФИО автора: #{name}\n" \
      "Первая буква фамилии: #{letter}\n\n"
  end
end
