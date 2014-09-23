require 'curses'

begin
  Curses.init_screen
  window = Curses.stdscr.subwin(5, 30, 2, 2)
  window.box(?|, ?-, ?@)
  window.setpos(2, 2)
  window.addstr('さぶうぃんどう')
  window.refresh
  Curses.getch
ensure
  Curses.close_screen
end
