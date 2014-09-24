require 'curses'

class EditWindow
  def initialize(window)
    @window = window.subwin(window.maxy - CommandWindow::HEIGHT, window.maxx, 0, 0)
    @window.scrollok(true)
  end

  def display(filename)
    File.open(filename, 'a+') do |file|
      @data = file.map(&:chomp)
    end
    @data.take(@window.maxy).each_with_index do |line, index|
      @window.setpos(index, 0)
      @window.addstr(line)
    end
    @window.setpos(0, 0)
    @window.refresh
  end

  def getch
    @window.getch
  end
end
