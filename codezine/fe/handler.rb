require_relative 'edit_window'
require_relative 'edit_handler'

class Handler
  def execute(window, input_ch)
    case input_ch
    when 27
      EditHandler.new
    when ?x
      window.delete
    when ?s
      window.cursor_down
    when ?w
      window.cursor_up
    when ?a
      window.cursor_left
    when ?d
      window.cursor_right
    when ?q
      raise 'force quit!'
    end
    self
  end
end
