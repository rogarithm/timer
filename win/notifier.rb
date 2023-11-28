require 'fox16'
include Fox

class Notifier < FXMainWindow
  def initialize(app)
    super(app, "Time out!", :width => 500, :height => 300)
  end
  def create
    super
    show(PLACEMENT_SCREEN)
  end
end

`sleep #{30 * 60}`
app = FXApp.new
Notifier.new(app)
app.create
app.run
