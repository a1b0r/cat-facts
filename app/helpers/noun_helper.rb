module NounHelper
  # count whole words beginning with a capital letter in the string
  def count_words(text)
    text.split.select { |word| word.match(/^[A-Z]/) }.size
  end

  def reading_time(nouns, wpm = 50.0)
    (nouns / wpm)
  end
  
  def info_for_noun(text)
    nouns = count_words(text)
    {
      reading_time: reading_time(nouns),
      word_count: nouns
    }
  end
  # info string with noun count and reading time
  def noun_html_info(text)
    info = info_for_noun(text)
    "#{info[:word_count]} nouns, ~ #{info[:reading_time]} minutes"
  end
end

