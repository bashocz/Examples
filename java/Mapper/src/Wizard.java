import java.awt.*;
import javax.swing.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import javax.swing.border.TitledBorder;

public class Wizard extends JDialog {

  private JComponent getImage(){
	  JPanel panel = new JPanel(new BorderLayout());
      panel.add(new JLabel("   "), BorderLayout.WEST);
      ImageIcon icon = new ImageIcon(getClass().getResource("/resources/checkin.jpg"));
      JLabel image = new JLabel(icon);
      panel.add(image, BorderLayout.EAST);
	  return panel;
  }

  private JComponent getLotText(){
      JPanel panelText = new JPanel();
      panelText.setLayout(new BoxLayout(panelText, BoxLayout.Y_AXIS));

	  JLabel labelTitle = new JLabel("Sada", JLabel.LEFT);
      JPanel panelTitle = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 0));
	  panelTitle.add(labelTitle);
      panelText.add(panelTitle);

	  JTextField field = new JTextField();
      field.setPreferredSize(new Dimension(100, vyska));
      field.setMargin(new Insets(0, 5, 0, 0));
      field.setText("P0SF639781");
      JPanel panelField = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 0));
	  panelField.add(field);
	  panelText.add(panelField);

      JPanel panel = new JPanel(new CardLayout(10, 0));
      panel.add(panelText, "card");

      return panel;
  }

  private JComponent getInkingMode(){
      JPanel panelInkMode = new JPanel();
      panelInkMode.setLayout(new BoxLayout(panelInkMode, BoxLayout.Y_AXIS));
      panelInkMode.setBorder(new TitledBorder(" Mod inkovani "));
      panelInkMode.setEnabled(false);

      ButtonGroup bgMod = new ButtonGroup();
	  radioInkArr[0] = new JRadioButton("Standardni", true);
      radioInkArr[0].setEnabled(false);
      bgMod.add(radioInkArr[0]);
      JPanel panelRadio1 = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 2));
	  panelRadio1.add(radioInkArr[0]);
      panelInkMode.add(panelRadio1);

	  radioInkArr[1] = new JRadioButton("Inkovani podle control mapy");
      radioInkArr[1].setEnabled(false);
      bgMod.add(radioInkArr[1]);
      JPanel panelRadio2 = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 2));
	  panelRadio2.add(radioInkArr[1]);
      panelInkMode.add(panelRadio2);

	  radioInkArr[2] = new JRadioButton("Rucni inkovani");
      radioInkArr[2].setEnabled(false);
      bgMod.add(radioInkArr[2]);
      JPanel panelRadio3 = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 2));
	  panelRadio3.add(radioInkArr[2]);
      panelInkMode.add(panelRadio3);

	  radioInkArr[3] = new JRadioButton("Inkovani z externich map");
      radioInkArr[3].setEnabled(false);
      bgMod.add(radioInkArr[3]);
      JPanel panelRadio4 = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 2));
	  panelRadio4.add(radioInkArr[3]);
      panelInkMode.add(panelRadio4);

      JPanel panel = new JPanel(new BorderLayout());
      panel.add(panelInkMode, BorderLayout.CENTER);

      JPanel panelW = new JPanel();
      panelW.setPreferredSize(new Dimension(30, 20));
	  panel.add(panelW, BorderLayout.WEST);

      JPanel panelE = new JPanel();
      panelE.setPreferredSize(new Dimension(5, 20));
	  panel.add(panelE, BorderLayout.EAST);

      return panel;
  }

  private JComponent getLotMode(){
      JPanel panelMode = new JPanel();
      panelMode.setLayout(new BoxLayout(panelMode, BoxLayout.Y_AXIS));
      panelMode.setBorder(new TitledBorder(" Operacni mod "));

      ButtonGroup bgMod = new ButtonGroup();
	  JRadioButton radio1 = new JRadioButton("Probovani", true);
      radio1.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                radioActionPerformed(evt);
            }
        });
      bgMod.add(radio1);
      JPanel panelRadio1 = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 2));
	  panelRadio1.add(radio1);
      panelMode.add(panelRadio1);

	  JRadioButton radio2 = new JRadioButton("Reprobovani");
      radio2.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                radioActionPerformed(evt);
            }
        });
      bgMod.add(radio2);
      JPanel panelRadio2 = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 2));
	  panelRadio2.add(radio2);
      panelMode.add(panelRadio2);

	  radioInk = new JRadioButton("Inkovani");
      radioInk.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                radioActionPerformed(evt);
            }
        });
      bgMod.add(radioInk);
      JPanel panelRadio3 = new JPanel(new FlowLayout(FlowLayout.LEFT, 0, 2));
	  panelRadio3.add(radioInk);
      panelMode.add(panelRadio3);

      panelMode.add(getInkingMode());
      enabledRadio();

      JPanel panel = new JPanel(new CardLayout(10, 10));
      panel.add(panelMode, "card");

      return panel;
  }

  private JComponent getLot(){
      JPanel panelInfo = new JPanel();
      panelInfo.setLayout(new BoxLayout(panelInfo, BoxLayout.Y_AXIS));

      panelInfo.add(getLotText());
      panelInfo.add(getLotMode());

      JPanel panel = new JPanel(new BorderLayout());
      panel.add(panelInfo, BorderLayout.NORTH);

      return panel;
  }

  private JComponent getTestPanel(JComponent label, JComponent field){
      JPanel panel = new JPanel(new GridLayout(0, 2));

      JPanel panelW = new JPanel(new CardLayout(0, 2));
      panelW.add(label, "card");
      panel.add(panelW);

      JPanel panelE = new JPanel(new CardLayout(0, 2));
      panelE.add(field, "card");
      panel.add(panelE);

      return panel;
  }

  private JComponent getTestSampleCheck(String title){
      JLabel label = new JLabel(title, JLabel.LEFT);

      checkSample = new JCheckBox("", true);
      checkSample.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                sampleActionPerformed(evt);
            }
        });

      return getTestPanel(label, checkSample);
  }

  private JComponent getTestSample(int i, String title, String text){
      JLabel label = new JLabel(title, JLabel.LEFT);

      sampleFArr[i] = new JTextField();
      sampleFArr[i].setPreferredSize(new Dimension(70, vyska));
      sampleFArr[i].setMargin(new Insets(0, 5, 0, 0));
      sampleFArr[i].setText(text);

      return getTestPanel(label, sampleFArr[i]);
  }

  private JComponent getTestSmartCheck(String title){
      JLabel label = new JLabel(title, JLabel.LEFT);

      checkSmart = new JCheckBox("", false);
      checkSmart.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                smartActionPerformed(evt);
            }
        });

      return getTestPanel(label, checkSmart);
  }

  private JComponent getTestSmart(int i, String title, String text){
     JLabel label = new JLabel(title, JLabel.LEFT);

      smartFArr[i] = new JTextField();
  	  smartFArr[i].setPreferredSize(new Dimension(70, vyska));
      smartFArr[i].setMargin(new Insets(0, 5, 0, 0));
      smartFArr[i].setText(text);

      return getTestPanel(label, smartFArr[i]);
  }

  private JComponent getTestField(String title, String text){
      JLabel label = new JLabel(title, JLabel.LEFT);

      JTextField field = new JTextField();
   	  field.setPreferredSize(new Dimension(70, vyska));
      field.setMargin(new Insets(0, 5, 0, 0));
      field.setText(text);

      return getTestPanel(label, field);
  }

  private JComponent getTestDevice(String title){
      JLabel label = new JLabel(title, JLabel.LEFT);

      String[] items = new String[5];
      items[0] = "A5631K24P.02";
      items[1] = "NCP4001.01";
      items[2] = "W777B-10.01.01";
      items[3] = "WTELM317-230B.01";
      items[4] = "WTELP2951-501N.01";
      JComboBox field = new JComboBox(items);
      field.setPreferredSize(new Dimension(70, vyska));

      return getTestPanel(label, field);
  }

  private JComponent getTestLimit(){
      JPanel panelLimit = new JPanel();
      panelLimit.setLayout(new BoxLayout(panelLimit, BoxLayout.Y_AXIS));
      panelLimit.setBorder(new TitledBorder(" Podminky mereni "));

	  panelLimit.add(getTestDevice("Sortiment"));
	  panelLimit.add(getTestField("Pocet", "686"));
	  panelLimit.add(getTestField("Minimum dobrych", "445"));

      JPanel panelSample = new JPanel();
      panelSample.setLayout(new BoxLayout(panelSample, BoxLayout.Y_AXIS));
      panelSample.setBorder(new TitledBorder(" Samplovani "));

      panelSample.add(getTestSampleCheck("Povolit"));
      sampleFArr = new JTextField[1];
      panelSample.add(getTestSample(0, "Limit prepnuti", "8"));
      enabledSample();

      panelLimit.add(panelSample);

      JPanel panelSmart = new JPanel();
      panelSmart.setLayout(new BoxLayout(panelSmart, BoxLayout.Y_AXIS));
      panelSmart.setBorder(new TitledBorder(" Chytre samplovani "));

      panelSmart.add(getTestSmartCheck("Povolit"));
      smartFArr = new JTextField[7];
      panelSmart.add(getTestSmart(0, "Krok X pro class", "8"));
      panelSmart.add(getTestSmart(1, "Krok Y pro class", "8"));
      panelSmart.add(getTestSmart(2, "Krok X pro smart", "4"));
      panelSmart.add(getTestSmart(3, "Krok Y pro smart", "4"));
      panelSmart.add(getTestSmart(4, "Dolni limit pro smart", "50"));
      panelSmart.add(getTestSmart(5, "Limit pro smart", "80"));
      panelSmart.add(getTestSmart(6, "Horni limit pro smart", "98"));
      enabledSmart();

      panelLimit.add(panelSmart);

      panelLimit.add(new JPanel());

      JPanel panel = new JPanel(new CardLayout(10, 0));
      panel.add(panelLimit, "card");

      return panel;
  }

  private JComponent getLimit(){
      JPanel panelInfo = new JPanel();
      panelInfo.setLayout(new BoxLayout(panelInfo, BoxLayout.Y_AXIS));

      panelInfo.add(getTestLimit());

      JPanel panel = new JPanel(new BorderLayout());
      panel.add(panelInfo, BorderLayout.NORTH);

      return panel;
  }

  private JComponent getWafer(){
      JTable table = new JTable();
      table.setModel(new javax.swing.table.DefaultTableModel(
          new Object [][] {
              {"1", true, "#01", "Poznamka 1"},
              {"2", true, "#02", "Poznamka 2"},
              {"3", false, "#03", "Poznamka 3"},
              {"4", false, "#04", "Poznamka 4"}
          },
          new String [] {
              "Slot", "Povolit", "VID", "Poznamka"
          }
      ) {
          Class[] types = new Class [] {
              java.lang.String.class, java.lang.Boolean.class, java.lang.String.class, java.lang.String.class
          };
          boolean[] canEdit = new boolean [] {
              false, true, true, false
          };

          @Override
          public Class getColumnClass(int columnIndex) {
              return types [columnIndex];
          }

          @Override
          public boolean isCellEditable(int rowIndex, int columnIndex) {
              return canEdit [columnIndex];
          }
      });
      table.getColumnModel().getColumn(0).setMinWidth(40);
      table.getColumnModel().getColumn(1).setMinWidth(50);
      table.getColumnModel().getColumn(2).setMinWidth(40);
      table.getColumnModel().getColumn(0).setMaxWidth(40);
      table.getColumnModel().getColumn(1).setMaxWidth(50);
      table.getColumnModel().getColumn(2).setMaxWidth(40);
      table.getColumnModel().getColumn(0).setPreferredWidth(40);
      table.getColumnModel().getColumn(1).setPreferredWidth(50);
      table.getColumnModel().getColumn(2).setPreferredWidth(40);
      table.setRowHeight(vyska);

      JScrollPane scroll = new JScrollPane();
      scroll.setViewportView(table);

      JPanel panel = new JPanel(new CardLayout(8, 8));
      panel.setBorder(new TitledBorder(" Vyber desek "));
      panel.add(scroll, "card");

      return panel;
  }

  private JComponent getSetup(){
      JPanel panelSetup = new JPanel(new BorderLayout());
      panelSetup.setBorder(new TitledBorder(" Setup "));

      String[] items = new String[40];
      for (int i = 0; i < 40; i++)
          items[i] = "Setup " + Integer.toString(i + 1);
      JList listSetup = new JList(items);
      listSetup.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
      JScrollPane scrollSetup = new JScrollPane();
      scrollSetup.setViewportView(listSetup);
      panelSetup.add(scrollSetup);

      JPanel panelProbe = new JPanel(new BorderLayout());
      panelProbe.setBorder(new TitledBorder(" Probovaci karta "));

      items = new String[20];
      for (int i = 0; i < 20; i++)
          items[i] = "Probovaci karta " + Integer.toString(i + 1);
      JList listProbe = new JList(items);
      listProbe.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
      JScrollPane scrollProbe = new JScrollPane();
      scrollProbe.setViewportView(listProbe);
      panelProbe.add(scrollProbe, BorderLayout.CENTER);

      JPanel panelG = new JPanel(new GridLayout(0, 2));
      panelG.add(panelSetup);
      panelG.add(panelProbe);

      JPanel panel = new JPanel(new CardLayout(8, 0));
      panel.add(panelG, "card");

      return panel;
  }

  private JComponent getPage0(){
      JPanel panel = new JPanel(new BorderLayout());

	  panel.add(getImage(), BorderLayout.WEST);
	  panel.add(getLot(), BorderLayout.CENTER);

      return panel;
  }

  private JComponent getPage1(){
      JPanel panel = new JPanel(new BorderLayout());

	  panel.add(getImage(), BorderLayout.WEST);
	  panel.add(getLimit(), BorderLayout.CENTER);

      return panel;
  }

  private JComponent getPage2(){
      JPanel panel = new JPanel(new BorderLayout());

	  panel.add(getWafer(), BorderLayout.CENTER);

      return panel;
  }

  private JComponent getPage3(){
      JPanel panel = new JPanel(new BorderLayout());

	  panel.add(getSetup(), BorderLayout.CENTER);

      return panel;
  }

  private void getPage(int stranka){
      panelPage.removeAll();
      switch (stranka){
          case 0:
              setTitle("Pruvodce nastavenim programu mereni 1/4");
              panelPage.add(getPage0(), "card");
              break;
          case 1:
              setTitle("Pruvodce nastavenim programu mereni 2/4");
              panelPage.add(getPage1(), "card");
              break;
          case 2:
              setTitle("Pruvodce nastavenim programu mereni 3/4");
              panelPage.add(getPage2(), "card");
              break;
          default:
              setTitle("Pruvodce nastavenim programu mereni 4/4");
              panelPage.add(getPage3(), "card");
              break;
      }
      panelPage.updateUI();
  }

  private void switchPage(int i){
      if ((i < 0) && (page > 0))
          page--;
      if ((i > 0) && (page < 3))
          page++;
      getPage(page);

      buttonPrev.setEnabled(page > 0);
      buttonNext.setText((page < 3) ? "Dalsi" : "Spustit");
  }
  
  private JComponent getButtons(){
      JPanel panel = new JPanel(new FlowLayout(FlowLayout.RIGHT));

      buttonPrev = new JButton("Predchozi");
      buttonPrev.setPreferredSize(new Dimension(85, 23));
      buttonPrev.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                prevActionPerformed(evt);
            }
        });
      panel.add(buttonPrev);

      buttonNext = new JButton("Dalsi");
      buttonNext.setPreferredSize(new Dimension(85, 23));
      buttonNext.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                nextActionPerformed(evt);
            }
        });
      panel.add(buttonNext);

      buttonCanc = new JButton("Storno");
      buttonCanc.setPreferredSize(new Dimension(85, 23));
      buttonCanc.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                dispose();
            }
        });
      panel.add(buttonCanc);

      return panel;
  }

  private void enabledRadio(){
      for (int i = 0; i < radioInkArr.length; i++)
        radioInkArr[i].setEnabled(radioInk.isSelected());
  }

  private void radioActionPerformed(ActionEvent evt) {
      enabledRadio();
  }

  private void enabledSample(){
      for (int i = 0; i < sampleFArr.length; i++)
        sampleFArr[i].setEnabled(checkSample.isSelected());
  }

  private void sampleActionPerformed(ActionEvent evt) {
      enabledSample();
  }

  private void enabledSmart(){
      for (int i = 0; i < smartFArr.length; i++)
        smartFArr[i].setEnabled(checkSmart.isSelected());
  }

  private void smartActionPerformed(ActionEvent evt) {
      enabledSmart();
  }

  private void prevActionPerformed(ActionEvent evt) {
      if (page > 0)
          switchPage(-1);
  }

  private void nextActionPerformed(ActionEvent evt) {
      if (page < 3)
          switchPage(1);
      else
          dispose();
  }

  int vyska;

  int page = 0;
  
  JPanel panelPage = null;
  JButton buttonPrev = null;
  JButton buttonNext = null;
  JButton buttonCanc = null;

  JRadioButton radioInk = null;
  JRadioButton radioInkArr[] = new JRadioButton[4];

  JCheckBox checkSample = null;
  JTextField sampleFArr[];

  JCheckBox checkSmart = null;
  JTextField smartFArr[];

  public Wizard (JFrame parent, boolean modal, int vyska){
	  super(parent, modal);
      this.vyska = vyska;

      Container obsah = getContentPane();

      panelPage = new JPanel(new CardLayout(4, 10));

      obsah.add(getButtons(), BorderLayout.SOUTH);
      obsah.add(panelPage, BorderLayout.CENTER);
      switchPage(0);
      
      pack();
      setLocationRelativeTo(parent);
  }
}