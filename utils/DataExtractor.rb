class DataExtractor
  def self.get_data(data, string_begin, string_end)
    # new_data = data[/#{string_begin}(.*?)#{string_end}/m, 1]
    # a = data[/"21"(.*?)"com"/m, 1]

    data = "foo@example.com"
    a = data[/[[:upper:]][[:lower:]]/]
    p "NEW : #{a}"
  end
end
