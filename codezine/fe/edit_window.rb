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

    @cursor_y, @cursor_x = 0, 0
    @top_statement = 0

    @window.setpos(0, 0)
    @window.refresh
  end

  def getch
    @window.getch
  end

  def input(input_ch)
    @window.insch(input_ch)
    @window.setpos(@cursor_y, @cursor_x += 1)
  end

  def delete
    @window.delch
  end

  def cursor_down
    if @cursor_y >= (@window.maxy - 1)
      scroll_down
    elsif @cursor_y >= (@data.size - 1)
    else
      @cursor_y += 1
    end
    if @cursor_x > (@data[@cursor_y + @top_statement].size)
      @cursor_x = @data[@cursor_y + @top_statement].size
    end
    @window.setpos(@cursor_y, @cursor_x)
    @window.refresh
  end

  def cursor_up
    if @cursor_y <= 0
      scroll_up
    else
      @cursor_y -= 1
    end
    if @cursor_x > (@data[@cursor_y + @top_statement].size)
      @cursor_x = @data[@cursor_y + @top_statement].size
    end
    @window.setpos(@cursor_y, @cursor_x)
    @window.refresh
  end

  def cursor_left
    if @cursor_x > 0
      @cursor_x -= 1
    end
    @window.setpos(@cursor_y, @cursor_x)
    @window.refresh
  end

  def cursor_right
    if @cursor_x < @data[@cursor_y + @top_statement].size
      @cursor_x += 1
    end
    @window.setpos(@cursor_y, @cursor_x)
    @window.refresh
  end

  def scroll_up
    if @top_statement > 0
      @window.scrl(-1)
      @top_statement -= 1
      if str = @data[@top_statement]
        @window.setpos(0, 0)
        @window.addstr(str)
      end
    end
  end

  def scroll_down
    if @top_statement + @window.maxy < @data.size
      @window.scrl(1)
      if str = @data[@top_statement + @window.maxy]
        @window.setpos(@window.maxy - 1, 0)
        @window.addstr(str)
      end
      @top_statement += 1
    end
  end
end
