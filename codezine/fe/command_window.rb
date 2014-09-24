class CommandWindow
  HEIGHT = 3

  def initialize(window, filename)
    maxy, maxx = window.maxy, window.maxx
    beginy = maxy - HEIGHT
    window.setpos(beginy, 0)

    window.standout
    window.addstr(' ' * maxx)
    window.standend

    window.setpos(beginy, (maxx / 2) - (filename.size / 2))
    window.addstr(filename)
    @window = window.subwin((maxy - beginy), maxx, beginy, 0)
    @window.refresh
  end
end
