require 'gmail'

class Email
  def initialize(user, password)
    @gmail = Gmail.connect(user, password)

    if @gmail.logged_in?.eql? false
      raise "Could not log in in Gmail, check user or password!!! USER: [#{user}] PASSWORD: [#{password}]"
    end
  end

  def get_email_message(date, from)

    found_message = false
    count = 0

    while found_message.eql? false do

      email = @gmail.inbox.emails(:on => Date.parse(date), :from => from)

      if email[0].eql? nil
        found_message = false
        sleep 1
        count = count +1
      else
        found_message = true
      end

      if count.eql? 120
        raise "There is no message searching by date [#{date}] and from [#{from}]"
      end
    end

    email[0].message.body.decoded.to_s
  end

  def get_purchase_link(date, from)
    email_body = get_email_message(date, from)

    string_begin = "9px;\" href=\""
    string_end = "\" title"

    email_body[/#{string_begin}(.*?)#{string_end}/m, 1]
  end
end
