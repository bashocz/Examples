tk windowingsystem;
wm title . "Mapper"

#---------------------------
  
set font [font create -size 8 -weight normal -slant roman]
set boldfont [font create -size 8 -weight bold -slant roman]
set bigfont [font create -size 16 -weight bold -slant roman]
image create photo waferimg -file "wafer.gif"
image create photo wizardimg -file "wizard.gif"
image create photo startimg -file "start.gif"
image create photo pauseimg -file "pause.gif"
image create photo checkinimg -file "checkin.gif"

#---------------------------
  
set zm1 0
set zm2 1
set zm3 0
set zm4 1
set zm5 1

set lot "P0SF639781"
set wafer "#01 (06BEA063SED4)"
set mod 1
set imod 1

set pdpw 686
set limit 445
set samplee 0
set samplelimit 8
set smarte 0
set smartx1 8
set smarty1 8
set smartx2 4
set smarty2 4
set smartl1 50
set smartl2 80
set smartl3 98

set wafer1 "#01"
set wafer2 "#02"
set wafer3 "#03"
set wafer4 "#04"
set iswafer1 1
set iswafer2 1
set iswafer3 1
set iswafer4 1

#---------------------------
  
option add *tearOff 0
  
set m .menubar
menu $m
. configure -menu $m

menu $m.file
menu $m.view
menu $m.oper
menu $m.tool
menu $m.help
$m add cascade -label "Soubor" -menu $m.file
$m add cascade -label "Zobraz" -menu $m.view
$m add cascade -label "Operace" -menu $m.oper
$m add cascade -label "Nastroje" -menu $m.tool
$m add cascade -label "Pomoc" -menu $m.help

set mf $m.file
  $mf add command -label "Zobraz logovaci soubor ..." -state disabled
  $mf add separator
  $mf add command -label "Konec" -command "exit"
set mv $m.view
  $mv add checkbutton -label "Pouze dve barvy binu" -variable zm1 -onvalue 1 -offvalue 0
  $mv add checkbutton -label "Mrizka" -variable zm2 -onvalue 1 -offvalue 0
  $mv add checkbutton -label "Kruznice kolem desky" -variable zm3 -onvalue 1 -offvalue 0
  $mv add checkbutton -label "Automaticky pohyb pri zvetseni" -variable zm4 -onvalue 1 -offvalue 0
  $mv add checkbutton -label "Statistika vyteznosti" -variable zm5 -onvalue 1 -offvalue 0
  $mv add separator
  $mv add command -label "Pozice situ ..." -state disabled
  $mv add command -label "Pozice kapani ..." -state disabled
set mo $m.oper
  $mo add command -label "Prihlaseni ..." -state disabled
  $mo add command -label "Odhlaseni" -state disabled
  $mo add separator
  $mo add command -label "Pruvodce nastavenim programu mereni ..." -command "wizard"
  $mo add separator
  $mo add command -label "Start mereni" -state disabled
  $mo add command -label "Stop mereni" -state disabled
set mt $m.tool
  $mt add command -label "Rucni ovladani mericich zarizeni ..." -state disabled
  $mt add separator
  $mt add command -label "Nastaveni ..." -state disabled
set mh $m.help
  $mh add command -label "O aplikaci ..." -state disabled
  
#---------------------------
  
set t .tool
ttk::frame $t -relief groove -borderwidth 2
  ttk::button $t.btn1 -text "Wizard" -command "wizard" -image wizardimg -compound top
  ttk::button $t.btn2 -text "Start" -image startimg -compound top
  ttk::button $t.btn3 -text "Stop" -image pauseimg -compound top

#---------------------------
  
set i .info
ttk::frame $i -relief groove -borderwidth 2
  ttk::label $i.vers -width 16 -anchor w -text "Version:"
  ttk::label $i.version -font $bigfont -width 16 -background "#99ccff" -text "Mapper 3.2.1"
  ttk::label $i.prob -width 16 -anchor w -text "Prober ID:"
  ttk::label $i.prober -font $bigfont -width 16 -background "#ff9999" -text "EG2001.01"
  ttk::label $i.test -width 16 -anchor w -text "Tester ID:"
  ttk::label $i.tester -font $bigfont -width 16 -background "#ffffcc" -text "ETS300.05"
  
  set s1 $i.sep1
  ttk::frame $s1 -relief flat -padding "2 10"
  ttk::frame $s1.frm -relief groove -borderwidth 2 -padding "5 5"
  ttk::label $s1.frm.lbl1 -font $font -width 16 -anchor w -text "Sada"
  ttk::entry $s1.frm.lbl2 -font $font -width 16 -textvariable lot -state readonly
  ttk::frame $s1.frm.frm -relief flat -padding "0 10"
  ttk::progressbar $s1.frm.frm.pb -orient horizontal -length 200 -mode determinate -value 33
  
  set s2 $i.sep2
  ttk::frame $s2 -relief flat -padding "2 10"
  ttk::frame $s2.frm -relief groove -padding "5 5"
  ttk::label $s2.frm.lbl1 -width 16 -anchor w -text "Deska"
  ttk::entry $s2.frm.lbl2 -width 16 -textvariable wafer -state readonly
  ttk::frame $s2.frm.frm -relief flat -padding "0 10"
  ttk::progressbar $s2.frm.frm.pb -orient horizontal -length 200 -mode determinate -value 85

#---------------------------
  
set w .wafer  
label $w -image waferimg

#---------------------------
  
set s .status
frame $s -relief groove -bd 2
  label $s.info -font $boldfont -width 16 -bd 4 -anchor w -text "  Priklad GUI pro mereni desek."
  
#---------------------------
  
pack $t -side top -fill x
  pack $t.btn1 -side left -fill x
  pack $t.btn2 -side left -fill x
  pack $t.btn3 -side left -fill x
  
pack $s -side bottom -fill x
  pack $s.info -side top -fill x

pack $i -side right -fill x
  pack $i.vers -side top -fill x
  pack $i.version -side top -fill x
  pack $i.prob -side top -fill x
  pack $i.prober -side top -fill x
  pack $i.test -side top -fill x
  pack $i.tester -side top -fill x
  pack $s1 -side top -fill x
  pack $s1.frm -side top -fill x
  pack $s1.frm.lbl1 -side top -fill x
  pack $s1.frm.lbl2 -side top -fill x
  pack $s1.frm.frm -side top -fill x
  pack $s1.frm.frm.pb -side top -fill x
  pack $s2 -side top -fill x
  pack $s2.frm -side top -fill x
  pack $s2.frm.lbl1 -side top -fill x
  pack $s2.frm.lbl2 -side top -fill x
  pack $s2.frm.frm -side top -fill x
  pack $s2.frm.frm.pb -side top -fill x
  
pack $w -side left -fill x

proc win1 {} {
set w1 .win1
toplevel $w1
wm title $w1 "Pruvodce nastavenim programu mereni 1/4"

#---------------------------
  
set w1b $w1.btn
ttk::frame $w1b -relief flat -padding "10 10"
  ttk::button $w1b.btn1 -text "Predchozi" -state disabled
  ttk::button $w1b.btn2 -text "Dalsi" -command "next1"
  ttk::button $w1b.btn3 -text "Storno" -command "cancel1"

#---------------------------
  
set w1f $w1.frm
ttk::frame $w1f -relief flat -borderwidth 2 -padding "10 10"
  ttk::label $w1f.lbl -width 16 -anchor w -text "Sada"
  ttk::entry $w1f.ent -textvariable lot
  
  set w1f1 $w1f.frm
  ttk::labelframe $w1f1 -relief groove -borderwidth 2 -padding "10 10" -text " Operacni mod "
  ttk::radiobutton $w1f1.r1 -text "Probovani" -variable mod -value 1
  ttk::radiobutton $w1f1.r2 -text "Reprobovani" -variable mod -value 2
  ttk::radiobutton $w1f1.r3 -text "Inkovani" -variable mod -value 3

  ttk::frame $w1f1.frm -relief flat -borderwidth 2 -padding "30 2 2 2"
  set w1f2 $w1f1.frm.frm
  ttk::labelframe $w1f2 -relief groove -borderwidth 2 -padding "10 10" -text " Mod inkonvani "
  ttk::radiobutton $w1f2.r1 -text "Standardni" -variable imod -value 1
  ttk::radiobutton $w1f2.r2 -text "Inkovani podle controp mapy" -variable imod -value 2
  ttk::radiobutton $w1f2.r3 -text "Rucni inkovani" -variable imod -value 3
  ttk::radiobutton $w1f2.r4 -text "Inkovani z externich map" -variable imod -value 4
  
#---------------------------
  
set w1c $w1.checkin
ttk::label $w1c -image checkinimg

#---------------------------
  
pack $w1b -side bottom -fill x
  pack $w1b.btn3 -side right -fill x
  pack $w1b.btn2 -side right -fill x
  pack $w1b.btn1 -side right -fill x
  
pack $w1f -side right -fill x
  pack $w1f.lbl -side top -fill x
  pack $w1f.ent -side top -fill x
  pack $w1f1 -side top -fill x
  pack $w1f1.r1 -side top -fill x -anchor w
  pack $w1f1.r2 -side top -fill x -anchor w
  pack $w1f1.r3 -side top -fill x -anchor w
  pack $w1f1.frm -side top -fill x
  pack $w1f2 -side top -fill x
  pack $w1f2.r1 -side top -fill x -anchor w
  pack $w1f2.r2 -side top -fill x -anchor w
  pack $w1f2.r3 -side top -fill x -anchor w
  pack $w1f2.r4 -side top -fill x -anchor w
  
pack $w1c -side left -fill x
}

proc win2 {} {
set w2 .win2
toplevel $w2
wm title $w2 "Pruvodce nastavenim programu mereni 2/4"

#---------------------------
  
set w2b $w2.btn
ttk::frame $w2b -relief flat -padding "10 10"
  ttk::button $w2b.btn1 -text "Predchozi" -command "prev2"
  ttk::button $w2b.btn2 -text "Dalsi" -command "next2"
  ttk::button $w2b.btn3 -text "Storno" -command "cancel2"

#---------------------------
  
ttk::frame $w2.frm -relief flat -padding "10 10"
set w2f $w2.frm.frm
ttk::labelframe $w2f -relief groove -borderwidth 2 -padding "10 10" -text " Podminky mereni "

  set w2f1 $w2f.frm1
  ttk::frame $w2f1 -relief flat
  ttk::label $w2f1.lbl1 -width 16 -anchor w -text "Sortiment"
  ttk::combobox $w2f1.cbx1 -width 16 -values [list "A5631K24P.02" "NCP4001.01" "W777B-10.01.01" "WTELM317-230B.01" "WTELP2951-501N.01"]
  $w2f1.cbx1 set "A5631K24P.02"
  ttk::label $w2f1.lbl2 -width 16 -anchor w -text "Pocet"
  ttk::entry $w2f1.ent2 -width 20 -textvariable pdpw
  ttk::label $w2f1.lbl3 -width 16 -anchor w -text "Minimum dobrych"
  ttk::entry $w2f1.ent3 -width 20 -textvariable limit
  
  set w2f2 $w2f.frm2
  ttk::labelframe $w2f2 -relief groove -borderwidth 2 -padding "2 10" -text " Samplovani "
  ttk::label $w2f2.lbl1 -width 16 -anchor w -text "Povolit"
  ttk::checkbutton $w2f2.cbx1 -variable samplee
  ttk::label $w2f2.lbl2 -width 16 -anchor w -text "Limit prepnuti"
  ttk::entry $w2f2.ent2 -width 20 -textvariable samplelimit
 
  set w2f3 $w2f.frm3
  ttk::labelframe $w2f3 -relief groove -borderwidth 2 -padding "2 10" -text " Samplovani "
  ttk::label $w2f3.lbl1 -width 16 -anchor w -text "Povolit"
  ttk::checkbutton $w2f3.cbx1 -variable smarte
  ttk::label $w2f3.lbl2 -width 16 -anchor w -text "Krok X pro class"
  ttk::entry $w2f3.ent2 -width 20 -textvariable smartx1
  ttk::label $w2f3.lbl3 -width 16 -anchor w -text "Krok Y pro class"
  ttk::entry $w2f3.ent3 -width 20 -textvariable smarty1
  ttk::label $w2f3.lbl4 -width 16 -anchor w -text "Krok X pro smart"
  ttk::entry $w2f3.ent4 -width 20 -textvariable smartx2
  ttk::label $w2f3.lbl5 -width 16 -anchor w -text "Krok Y pro smart"
  ttk::entry $w2f3.ent5 -width 20 -textvariable smarty2
  ttk::label $w2f3.lbl6 -width 16 -anchor w -text "Dolni limit pro smart"
  ttk::entry $w2f3.ent6 -width 20 -textvariable smartl1
  ttk::label $w2f3.lbl7 -width 16 -anchor w -text "Limit pro smart"
  ttk::entry $w2f3.ent7 -width 20 -textvariable smartl2
  ttk::label $w2f3.lbl8 -width 16 -anchor w -text "Horni limit pro smart"
  ttk::entry $w2f3.ent8 -width 20 -textvariable smartl3
 
#---------------------------
  
set w2c $w2.checkin
ttk::label $w2c -image checkinimg

#---------------------------
  
pack $w2b -side bottom -fill x
  pack $w2b.btn3 -side right -fill x
  pack $w2b.btn2 -side right -fill x
  pack $w2b.btn1 -side right -fill x
  
pack $w2.frm -side right -fill x
pack $w2f -side top -fill x
  pack $w2f1 -side top -fill x
  grid $w2f1.lbl1 -column 0 -row 0 -pady 2
  grid $w2f1.cbx1 -column 1 -row 0 -pady 2
  grid $w2f1.lbl2 -column 0 -row 1 -pady 2
  grid $w2f1.ent2 -column 1 -row 1 -pady 2
  grid $w2f1.lbl3 -column 0 -row 2 -pady 2
  grid $w2f1.ent3 -column 1 -row 2 -pady 2
  
  pack $w2f2 -side top -fill x
  grid $w2f2.lbl1 -column 0 -row 0 -pady 2
  grid $w2f2.cbx1 -column 1 -row 0 -pady 2 -sticky w
  grid $w2f2.lbl2 -column 0 -row 1 -pady 2
  grid $w2f2.ent2 -column 1 -row 1 -pady 2
  
  pack $w2f3 -side top -fill x
  grid $w2f3.lbl1 -column 0 -row 0 -pady 2
  grid $w2f3.cbx1 -column 1 -row 0 -pady 2 -sticky w
  grid $w2f3.lbl2 -column 0 -row 1 -pady 2
  grid $w2f3.ent2 -column 1 -row 1 -pady 2
  grid $w2f3.lbl3 -column 0 -row 2 -pady 2
  grid $w2f3.ent3 -column 1 -row 2 -pady 2
  grid $w2f3.lbl4 -column 0 -row 3 -pady 2
  grid $w2f3.ent4 -column 1 -row 3 -pady 2
  grid $w2f3.lbl5 -column 0 -row 4 -pady 2
  grid $w2f3.ent5 -column 1 -row 4 -pady 2
  grid $w2f3.lbl6 -column 0 -row 5 -pady 2
  grid $w2f3.ent6 -column 1 -row 5 -pady 2
  grid $w2f3.lbl7 -column 0 -row 6 -pady 2
  grid $w2f3.ent7 -column 1 -row 6 -pady 2
  grid $w2f3.lbl8 -column 0 -row 7 -pady 2
  grid $w2f3.ent8 -column 1 -row 7 -pady 2
  
pack $w2c -side left -fill x
}

proc win3 {} {
set boldfont [font create -size 8 -weight bold -slant roman]

set w3 .win3
toplevel $w3
wm title $w3 "Pruvodce nastavenim programu mereni 3/4"

#---------------------------
  
set w3b $w3.btn
ttk::frame $w3b -relief flat -padding "10 10"
  ttk::button $w3b.btn1 -text "Predchozi" -command "prev3"
  ttk::button $w3b.btn2 -text "Dalsi" -command "next3"
  ttk::button $w3b.btn3 -text "Storno" -command "cancel3"

#---------------------------
  
ttk::frame $w3.frm -relief flat -padding "10 10"
  set w3f $w3.frm.frm
  ttk::labelframe $w3f -relief groove -borderwidth 2 -padding "10 10" -text " Vyber desek "

  ttk::label $w3f.lbl01 -font $boldfont -width 4 -anchor w -text "Slot"
  ttk::label $w3f.lbl02 -font $boldfont -width 8 -anchor w -text "Povolit"
  ttk::label $w3f.lbl03 -font $boldfont -width 4 -anchor w -text "VID"
  ttk::label $w3f.lbl04 -font $boldfont -width 32 -anchor w -text "Poznamka"
  
  ttk::label $w3f.lbl11 -width 4 -anchor w -text "1"
  ttk::checkbutton $w3f.cbx12 -variable iswafer1
  ttk::entry $w3f.ent13 -width 4 -textvariable wafer1
  ttk::label $w3f.lbl14 -width 32 -anchor w -text "Poznamka 1"
  
  ttk::label $w3f.lbl21 -width 4 -anchor w -text "2"
  ttk::checkbutton $w3f.cbx22 -variable iswafer2
  ttk::entry $w3f.ent23 -width 4 -textvariable wafer1
  ttk::label $w3f.lbl24 -width 32 -anchor w -text "Poznamka 2"
  
  ttk::label $w3f.lbl31 -width 4 -anchor w -text "3"
  ttk::checkbutton $w3f.cbx32 -variable iswafer3
  ttk::entry $w3f.ent33 -width 4 -textvariable wafer1
  ttk::label $w3f.lbl34 -width 32 -anchor w -text "Poznamka 3"
  
  ttk::label $w3f.lbl41 -width 4 -anchor w -text "4"
  ttk::checkbutton $w3f.cbx42 -variable iswafer4
  ttk::entry $w3f.ent43 -width 4 -textvariable wafer1
  ttk::label $w3f.lbl44 -width 32 -anchor w -text "Poznamka 4"
  
#---------------------------
  
pack $w3b -side bottom -fill x
  pack $w3b.btn3 -side right -fill x
  pack $w3b.btn2 -side right -fill x
  pack $w3b.btn1 -side right -fill x
  
pack $w3.frm -side top -fill x
  pack $w3f -side top -fill x
  grid $w3f.lbl01 -column 0 -row 0
  grid $w3f.lbl02 -column 1 -row 0
  grid $w3f.lbl03 -column 2 -row 0
  grid $w3f.lbl04 -column 3 -row 0
  grid $w3f.lbl11 -column 0 -row 1
  grid $w3f.cbx12 -column 1 -row 1
  grid $w3f.ent13 -column 2 -row 1
  grid $w3f.lbl14 -column 3 -row 1
  grid $w3f.lbl21 -column 0 -row 2
  grid $w3f.cbx22 -column 1 -row 2
  grid $w3f.ent23 -column 2 -row 2
  grid $w3f.lbl24 -column 3 -row 2
  grid $w3f.lbl31 -column 0 -row 3
  grid $w3f.cbx32 -column 1 -row 3
  grid $w3f.ent33 -column 2 -row 3
  grid $w3f.lbl34 -column 3 -row 3
  grid $w3f.lbl41 -column 0 -row 4
  grid $w3f.cbx42 -column 1 -row 4
  grid $w3f.ent43 -column 2 -row 4
  grid $w3f.lbl44 -column 3 -row 4
}

proc win4 {} {
set w4 .win4
toplevel $w4
wm title $w4 "Pruvodce nastavenim programu mereni 4/4"

#---------------------------
  
set w4b $w4.btn
ttk::frame $w4b -relief flat -padding "10 10"
  ttk::button $w4b.btn1 -text "Predchozi" -command "prev4"
  ttk::button $w4b.btn2 -text "Dalsi" -command "next4"
  ttk::button $w4b.btn3 -text "Storno" -command "cancel4"

#---------------------------
  
ttk::frame $w4.frm -relief flat -padding "10 10"
  ttk::frame $w4.frm.frm1 -relief flat -padding "4 0"
  set w4f1 $w4.frm.frm1.frm
  ttk::labelframe $w4f1 -relief groove -borderwidth 2 -padding "10 10" -text " Setup "
  tk::listbox $w4f1.lb -height 30 -width 30
  for {set i 1} {$i<41} {incr i} {
    $w4f1.lb insert end "Setup $i"
  }
  ttk::scrollbar $w4f1.sb -orient vertical -command "$w4f1.lb yview"
  $w4f1.lb configure -yscrollcommand "$w4f1.sb set"

  ttk::frame $w4.frm.frm2 -relief flat -padding "4 0"
  set w4f2 $w4.frm.frm2.frm
  ttk::labelframe $w4f2 -relief groove -borderwidth 2 -padding "10 10" -text " Probovaci karta "
  tk::listbox $w4f2.lb -height 30 -width 30
  for {set i 1} {$i<31} {incr i} {
    $w4f2.lb insert end "Probovaci karta $i"
  }
  ttk::scrollbar $w4f2.sb -orient vertical -command "$w4f2.lb yview"
  $w4f2.lb configure -yscrollcommand "$w4f2.sb set"

#---------------------------
  
pack $w4b -side bottom -fill x
  pack $w4b.btn3 -side right -fill x
  pack $w4b.btn2 -side right -fill x
  pack $w4b.btn1 -side right -fill x
  
pack $w4.frm -side top -fill x
  pack $w4.frm.frm1 -side left -fill x
  pack $w4f1 -side top -fill x
  grid $w4f1.lb -column 0 -row 0 -sticky nwes
  grid $w4f1.sb -column 1 -row 0 -sticky ns
  
  pack $w4.frm.frm2 -side right -fill x
  pack $w4f2 -side top -fill x
  grid $w4f2.lb -column 0 -row 0 -sticky nwes
  grid $w4f2.sb -column 1 -row 0 -sticky ns
}

proc exit {} {
  destroy .
}

proc wizard {} {
  win1
}

proc prev1 {} {
}

proc next1 {} {
  destroy global .win1
  win2
}

proc cancel1 {} {
  destroy .win1
}

proc prev2 {} {
  destroy .win2
  win1
}

proc next2 {} {
  destroy .win2
  win3
}

proc cancel2 {} {
  destroy .win2
}

proc prev3 {} {
  destroy .win3
  win2
}

proc next3 {} {
  destroy .win3
  win4
}

proc cancel3 {} {
  destroy .win3
}

proc prev4 {} {
  .destroy .win4
  win3
}

proc next4 {} {
  destroy .win4
}

proc cancel4 {} {
  destroy .win4
}