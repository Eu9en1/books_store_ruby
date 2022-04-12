# frozen_string_literal: true

require 'tty-prompt'
require_relative '..\lib\reader'
require_relative '..\lib\books_store'
require_relative '..\lib\alphabet'

def main
  @prompt = TTY::Prompt.new
  menu_item_lvl_3 = ['Выход', 'Начать поиск заново', 'Выбрать другого автора']
  menu_language = ['en', 'ru', 'Завершить работу приложения']
  books_store = Reader.read

  loop do
    # 1 уровень
    language = @prompt.enum_select('Выберите язык',
                                   menu_language)
    case language
    when 'en'
      letter = @prompt.enum_select('Выберите первую букву фамилии автора',
                                   Alphabet.english)
    when 'ru'
      letter = @prompt.enum_select('Выберите первую букву фамилии автора',
                                   Alphabet.russian)
    when 'Завершить работу приложения'
      puts '> Завершаю работу'
      break
    end

    authors = books_store.info_author_by_letter(letter)
    if authors.size.zero?
      puts "\n> Нет авторов, фамилия которых начинается на букву #{letter}\n\n"
    else
      loop do
        author = @prompt.enum_select('Выберите автора', authors)
        puts "> Количество книг автора: #{books_store.count_books_author(author.id)}"
        puts "> Количество книг где учавствовал автор: #{books_store.count_books_coauthored(author.id)}"
        puts "> Соавторы:\n#{books_store.coauthoreds(author.id)}\n"
        puts "> Книги автора\n#{books_store.all_books_author(author.id)}\n"
        choose = @prompt.enum_select('Выберите действие', menu_item_lvl_3)
        case choose
        when 'Выбрать другого автора'
          next
        when 'Начать поиск заново'
          break
        when 'Выход'
          return
        end
      end
    end
  end
end

main if __FILE__ == $PROGRAM_NAME
