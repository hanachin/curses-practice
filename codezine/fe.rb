require 'curses'
require_relative './fe/edit_window'
require_relative './fe/command_window'

unless filename = ARGV[0]
  puts 'usage: fe filename'
  exit
end

begin
  Curses.init_screen
  Curses.cbreak
  Curses.noecho

  standard_window = Curses.stdscr
  edit_window = EditWindow.new(standard_window)
  command_window = CommandWindow.new(standard_window, filename)
  edit_window.display(filename)
  edit_window.getch
ensure
  Curses.close_screen
end
