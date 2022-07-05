local awful = require('awful')
local left_panel = require('layout.left-panel')
local top_panel = require('layout.top-panel')

local wibox = require('wibox')
local beautiful = require('beautiful')
local dpi = require('beautiful').xresources.apply_dpi


-- Create a wibox for each screen and add it
awful.screen.connect_for_each_screen(
  function(s)
    if s.index == 1 then
      -- Create the left_panel
      s.left_panel = left_panel(s)
      -- Create the Top bar
      s.top_panel = top_panel(s, true)
    else
      -- Create the Top bar
      s.top_panel = top_panel(s, false)
    end
  end
)

-- add wibox to desktop
local tafel =
  awful.wibar(
    {
      ontop = false,
      screen = s,
      height = dpi(600),
      width = dpi(600),
      stretch = false,
      type = 'desktop',
      opacity = 0.7,
      bg = "transparent",
      position = 'right',   
      input_passthrough = true,   
    }
  )

local tafelanschrieb = {
  "{ {  {    {\n {   {   {  {   { \n {  { { ",
  "Ich kann auf dieser Tafel <b><i>Irgendeinen</i></b> komblett beliebigen Text abbilden ^^",
  "Mich hinzusetzen widerspricht <u>allem</u> wofuer ich stehe!!",
  "Kartoffels haben keine gefuehle",
  "Ich schwimm bis nach Birma für meine Firma",
  "sus ඞ ",
  "Haben wir noch pepps? ne? hast du die letzten genommen?",
  "Darum Liegt hier Stroh \n QED.",
  "If infinity exists, any finite quantity is infinitely small compared to infinity. This is a logical contradiction.",
  "Warum die Kinetische Energie mv² statt 1/2 mv² ist:",
  "können wir das irgendwie Aproximieren?",
  "Warum alle ungeraden Zahlen Primzahlen sind:",
  "Universität frisst Seele auf",
  "„Ich denke, also bin ich.“ \n- Til Schweiger",
  "„Wenn man ein 0:2 kassiert, dann ist ein 1:1 nicht mehr möglich.“ \n- Satz des Pythagoras",
  "„Liebe deinen Nächsten wie dich selbst.“ \n- Kurt Cobain",
  "„Niemand hat die Absicht, eine Mauer zu errichten.“ \n- Bob der Baumeister",
  "„Köpfchen in das Wasser, Schwänzchen in die Höh.“ \n- CIA-Verhörmethode",
  "„Ich sehe was, was du nicht siehst.“ \n- NSA",
  "„Das Problem mit Zitaten im Internet ist, dass man nie weiß ob sie stimmen.“ \n- Albert Einstein",
  "Ich mache jetzt was mit Medien. \n- Josef Göbbels",
  "Nachts ist es kälter als draußen",
  "können wir bei euch unsere Zelte aufbauen? - Ach ihr macht Käs? (alter Ösi)",
  "Nicht so tief Rüdiger",
  "Wein auf Bier das rat ich dir - Bier auf Wein, das rat ich dir auch.",
  "Penis\n\n 8=====D\n\n\n\t hihi",
  "Was Schlaues - Frederik",
  "Reden ist schweigen und Silber ist Gold.",
  "wann Bubatz legal?",
  "Niemand hat die Absicht diese Tafel zu wischen",
  "Fundamentales Theorem der Ingineurs- wissenschaften:\n\nπ = e = 3",
  "Annie are you -273,15°C?",
  "25 - 5 / 5 = 4!"
}

math.randomseed(os.time())

tafel:setup {
  layout = wibox.layout.align.horizontal,
  wibox.widget{
    markup = tafelanschrieb[math.random(#tafelanschrieb)],
    align  = 'center',
    valign = 'top',
    wrap = 'word',
    font= 'Chalktastic, Regular 40',
    widget = wibox.widget.textbox
  }
}


-- Hide bars when app go fullscreen
function updateBarsVisibility()
  for s in screen do
    if s.selected_tag then
      local fullscreen = s.selected_tag.fullscreenMode
      -- Order matter here for shadow
      s.top_panel.visible = not fullscreen
      if s.left_panel then
        s.left_panel.visible = not fullscreen
      end
    end
  end
end

_G.tag.connect_signal(
  'property::selected',
  function(t)
    updateBarsVisibility()
  end
)

_G.client.connect_signal(
  'property::fullscreen',
  function(c)
    c.screen.selected_tag.fullscreenMode = c.fullscreen
    updateBarsVisibility()
  end
)

_G.client.connect_signal(
  'unmanage',
  function(c)
    if c.fullscreen then
      c.screen.selected_tag.fullscreenMode = false
      updateBarsVisibility()
    end
  end
)
