require 'bookmeter_scraper'
require 'thor'

class BookmeterScraperCLI < Thor
  desc 'read-books MAIL PASSWORD', 'Fetch read books'
  option :y, type: :numeric, banner: '<year>'
  option :m, type: :numeric, banner: '<month>'
  def read_books(mail, password)
    setup(mail, password)
    books = if options[:y] && options[:m]
              @bookmeter.read_books_in(options[:y], options[:m])
            else
              @bookmeter.read_books
            end
    puts books_summary_text(books, :read)
  end

  desc 'reading-books MAIL PASSWORD', 'Fetch reading books'
  def reading_books(mail, password)
    setup(mail, password)
    puts books_summary_text(@bookmeter.reading_books, :reading)
  end

  desc 'tsundoku MAIL PASSWORD', 'Fetch tsundoku books'
  def tsundoku(mail, password)
    setup(mail, password)
    puts books_summary_text(@bookmeter.tsundoku, :tsundoku)
  end

  desc 'wish-list MAIL PASSWORD', 'Fetch wish list'
  def wish_list(mail, password)
    setup(mail, password)
    puts books_summary_text(@bookmeter.wish_list, :wish)
  end

  desc 'profile USER_ID', 'Fetch a specified user profile'
  def profile(user_id)
    setup
    puts profile_summary_text(@bookmeter.profile(user_id))
  end

  private

  def setup(mail = nil, password = nil)
    if !mail.nil? && !password.nil?
      @bookmeter = BookmeterScraper::Bookmeter.log_in(mail, password)
    else
      @bookmeter = BookmeterScraper::Bookmeter.new
    end
  end

  BOOKS_TYPE = { read: '読んだ本', reading: '読んでる本', tsundoku: '積読本', wish: '読みたい本' }

  def books_summary_text(books, type)
    raise unless BOOKS_TYPE.include?(type)
    if type == :read
      read_books_summary(books)
    else
      books_summary(books, type)
    end
  end

  def read_books_summary(books)
    result = "読んだ本\n"
    books.each do |book|
      date_s = book.read_dates[0].strftime('%Y年%m月%d日')
      result << "#{book.name}\n読了日：#{date_s}\n"
    end
    result
  end

  def books_summary(books, type)
    result = "#{BOOKS_TYPE[type]}\n"
    books.each do |book|
      result << "#{book.name}\n"
    end
    result
  end

  def profile_summary_text(profile)
    result = "#{profile.name}\n"
    BookmeterScraper::Bookmeter::JP_ATTRIBUTE_NAMES.each do |en_name, jp_name|
      result << "#{jp_name}：#{profile[en_name]}\n" unless profile[en_name].nil?
    end
    result
  end
end

BookmeterScraperCLI.start(ARGV)
