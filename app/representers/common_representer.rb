class CommonRepresenter
  def initialize(code: 200, message: "success", data: nil)
    @code = code
    @message = message
    @data = data
  end
  def as_json
    {
        code: code,
        message: message,
        data: data,
        current_page: nil,
        per_page: nil,
        total_page: nil,
        total_count: nil
    }
  end
  private
  attr_reader :data, :code, :message
end