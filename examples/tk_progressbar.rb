require 'tk'
require 'tkextlib/bwidget'

root = TkRoot.new
root.title = "Window"

progressBar = Tk::BWidget::ProgressBar.new(root)

variable = TkVariable.new
progressBar.variable = variable

variable.value = 33

progressBar.maximum = 100
progressBar.place('height' => 25,
                  'width'  => 100,
                  'x'      => 10,
                  'y'      => 10)

Tk.mainloop