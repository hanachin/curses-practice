require_relative 'handler'

class EditHandler
  def execute(windows, input_ch)
    case input_ch
    when 27
      Handler.new
    else
      window.input(input_ch)
    end
    self
  end
end
