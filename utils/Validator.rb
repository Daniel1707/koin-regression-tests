class Validator
  def self.check(data_received, data_expected, error_message)
    if !data_received.eql? data_expected
      raise "<---[LOG-ERROR]: [DATA-RECEIVED]: #{data_received}, [DATA-EXPECTED]: #{data_expected}. [ERROR]: #{error_message}--->"
    end
  end
end
