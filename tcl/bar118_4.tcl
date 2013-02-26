#------------------------------------------------------------------------------#
# URO 2008                                                eduard.sojka@vsb.cz  #
#------------------------------------------------------------------------------#
#-----------------   Definice prvku a struktury rozhrani   --------------------#

wm title . "Calculator"
wm resizable . 0 0
set myfont [font create -family {Helvetica} -size 10 -weight normal -slant roman]

label .en -font $myfont -width 10 -anchor e -relief sunken -bd 4 -background white -textvariable visNum
frame .opts -relief groove -bd 2
  radiobutton .opts.normal -text Normal -font $myfont -var appar -val "normal" -command normalform
  radiobutton .opts.big -text Big -font $myfont -var appar -val "big" -command bigform
frame .opbts
  button .opbts.clr  -text Clr -font $myfont -width 3 -foreground #0050d0 -command bClr
  button .opbts.add  -text + -font $myfont -width 3 -height 3 -foreground #0050d0 -command bAdd
  button .opbts.sub  -text - -font $myfont -width 3 -foreground #0050d0 -command bAdd
  button .opbts.mul  -text * -font $myfont -width 3 -foreground #0050d0 -command bAdd
  button .opbts.div  -text / -font $myfont -width 3 -foreground #0050d0 -command bAdd
  button .opbts.eqv  -text = -font $myfont -width 3 -height 3 -foreground #0050d0 -command bEqv
  button .opbts.dot  -text . -font $myfont -width 3 -foreground #0050d0 -command "insKey ."
  button .opbts.b0  -text 0 -font $myfont -width 8 -command "insKey 0"
  button .opbts.b1  -text 1 -font $myfont -width 3 -command "insKey 1"
  button .opbts.b2  -text 2 -font $myfont -width 3 -command "insKey 2"
  button .opbts.b3  -text 3 -font $myfont -width 3 -command "insKey 3"
  button .opbts.b4  -text 4 -font $myfont -width 3 -command "insKey 4"
  button .opbts.b5  -text 5 -font $myfont -width 3 -command "insKey 5"
  button .opbts.b6  -text 6 -font $myfont -width 3 -command "insKey 6"
  button .opbts.b7  -text 7 -font $myfont -width 3 -command "insKey 7"
  button .opbts.b8  -text 8 -font $myfont -width 3 -command "insKey 8"
  button .opbts.b9  -text 9 -font $myfont -width 3 -command "insKey 9"
frame .namets -relief groove -bd 2
  label .namets.name -font $myfont -width 16 -bd 4 -text "bar118@vsb.cz"

#-------------   Formatovani prenechame prikazum pack a grid   ----------------#

pack .en -side top -fill x
pack .opts -fill x -pady 2
  pack .opts.normal -side left -padx 2 -pady 2
  pack .opts.big -side left -padx 2 -pady 2
pack .opbts -side top -padx 2 -pady 2
  grid .opbts.clr -row 0 -column 0 -padx 2 -pady 2
  grid .opbts.div -row 0 -column 1 -padx 2 -pady 2
  grid .opbts.mul -row 0 -column 2 -padx 2 -pady 2
  grid .opbts.sub -row 0 -column 3 -padx 2 -pady 2
  grid .opbts.add -row 1 -column 3 -rowspan 2 -padx 2 -pady 2
  grid .opbts.eqv -row 3 -column 3 -rowspan 2 -padx 2 -pady 2
  grid .opbts.dot -row 4 -column 2 -padx 2 -pady 2
  grid .opbts.b0 -row 4 -column 0 -columnspan 2 -padx 2 -pady 2
  grid .opbts.b1 -row 3 -column 0 -padx 2 -pady 2
  grid .opbts.b2 -row 3 -column 1 -padx 2 -pady 2
  grid .opbts.b3 -row 3 -column 2 -padx 2 -pady 2
  grid .opbts.b4 -row 2 -column 0 -padx 2 -pady 2
  grid .opbts.b5 -row 2 -column 1 -padx 2 -pady 2
  grid .opbts.b6 -row 2 -column 2 -padx 2 -pady 2
  grid .opbts.b7 -row 1 -column 0 -padx 2 -pady 2
  grid .opbts.b8 -row 1 -column 1 -padx 2 -pady 2
  grid .opbts.b9 -row 1 -column 2 -padx 2 -pady 2
pack .namets  -padx 4 -pady 2
  pack .namets.name -side top -padx 2 -pady 2

#------------------------------------------------------------------------------#

.opts.normal select

proc normalform {} {
}

proc bigform {} {
}

proc bClr {} {
  global visNum
  set visNum ""
  set numOne 0
  set numTwo 0
}

proc bAdd {} {
  global operator
  global numOne
  global visNum
  set numOne $visNum
  set visNum ""
  set operator +
}

proc bSub {} {
}

proc bMul {} {
}

proc bDiv {} {
}

proc bEqv {} {
  global visNum
  global numOne
  global operator
  if {$operator == "+"} { 
    set visNum [expr {$numOne + $visNum }]
   }
}

proc insKey {key} {
  global visNum
  append visNum $key
}

#append visNum $znak

#------------------------------------------------------------------------------#







