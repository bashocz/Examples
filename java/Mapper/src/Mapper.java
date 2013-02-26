import java.awt.*;
import javax.swing.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.awt.font.FontRenderContext;

public class Mapper extends JFrame {

  private JMenuBar getMenu(){
      JMenuBar menuBar = new JMenuBar();

      JMenu menu = new JMenu("Soubor");
      menuBar.add(menu);
      JMenuItem item = new JMenuItem("Zobraz logovaci soubor ...");
      item.setEnabled(false);
      menu.add(item);
      JSeparator separator = new JSeparator();
      menu.add(separator);
      item = new JMenuItem("Konec");
      item.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                System.exit(0);
            }
        });
      menu.add(item);

      menu = new JMenu("Zobraz");
      menuBar.add(menu);
      JCheckBoxMenuItem cbItem = new JCheckBoxMenuItem("Pouze dve barvy binu");
      menu.add(cbItem);
      cbItem = new JCheckBoxMenuItem("Mrizka");
      cbItem.setState(true);
      menu.add(cbItem);
      cbItem = new JCheckBoxMenuItem("Kruznice kolem desky");
      menu.add(cbItem);
      cbItem = new JCheckBoxMenuItem("Automaticky pohyb pri zvetseni");
      cbItem.setState(true);
      menu.add(cbItem);
      cbItem = new JCheckBoxMenuItem("Statistika vyteznosti");
      cbItem.setState(true);
      menu.add(cbItem);
      separator = new JSeparator();
      menu.add(separator);
      item = new JMenuItem("Pozice situ ...");
      item.setEnabled(false);
      menu.add(item);
      item = new JMenuItem("Pozice kapani ...");
      item.setEnabled(false);
      menu.add(item);

      menu = new JMenu("Operace");
      menuBar.add(menu);
      item = new JMenuItem("Prihlaseni ...");
      item.setEnabled(false);
      menu.add(item);
      item = new JMenuItem("Odhlaseni");
      item.setEnabled(false);
      menu.add(item);
      separator = new JSeparator();
      menu.add(separator);
      item = new JMenuItem("Pruvodce nastavenim programu mereni ...");
      item.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                buttonActionPerformed(evt);
            }
        });
      menu.add(item);
      separator = new JSeparator();
      menu.add(separator);
      item = new JMenuItem("Start mereni");
      item.setEnabled(false);
      menu.add(item);
      item = new JMenuItem("Stop mereni");
      item.setEnabled(false);
      menu.add(item);

      menu = new JMenu("Nastroje");
      menuBar.add(menu);
      item = new JMenuItem("Rucni ovladani mericich zarizeni ...");
      item.setEnabled(false);
      menu.add(item);
      separator = new JSeparator();
      menu.add(separator);
      item = new JMenuItem("Nastaveni ...");
      item.setEnabled(false);
      menu.add(item);

      menu = new JMenu("Pomoc");
      menuBar.add(menu);
      item = new JMenuItem("O aplikaci ...");
      item.setEnabled(false);
      menu.add(item);

      return menuBar;
  }
  
  private JComponent getToolBar(){
      JPanel panel = new JPanel(new BorderLayout());

      JToolBar tool = new JToolBar();

      ImageIcon icon = new ImageIcon(getClass().getResource("/resources/wizard.png"));
      JButton button = new JButton(icon);
      button.setToolTipText("Pruvodce nastavenim programu mereni ...");
      button.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent evt) {
                buttonActionPerformed(evt);
            }
        });
      tool.add(button);
      JToolBar.Separator toolSep = new JToolBar.Separator();
      tool.add(toolSep);
      icon = new ImageIcon(getClass().getResource("/resources/start.png"));
      button = new JButton(icon);
      button.setEnabled(false);
      button.setToolTipText("Start mereni");
      tool.add(button);

      icon = new ImageIcon(getClass().getResource("/resources/pause.png"));
      button = new JButton(icon);
      button.setEnabled(false);
      button.setToolTipText("Stop mereni");
      tool.add(button);

      panel.add(tool, BorderLayout.NORTH);

      JSeparator separator = new JSeparator();
      panel.add(separator, BorderLayout.SOUTH);

      return panel;
  }

  private JComponent getMenuToolBar(){
      JPanel panel = new JPanel(new BorderLayout());
      panel.add(getMenu(), BorderLayout.NORTH);
      panel.add(getToolBar(), BorderLayout.SOUTH);
      return panel;
  }
  
  private JComponent getWafer(){
	  JPanel panel = new JPanel(new BorderLayout());
      ImageIcon icon = new ImageIcon(getClass().getResource("/resources/wafer.png"));
      JLabel image = new JLabel(icon);
      panel.add(image, BorderLayout.CENTER);
	  return panel;
  }

  private JComponent getInfoEquip(String title, String text, Color color){
      JPanel panelTitle = new JPanel(new BorderLayout());
	  JLabel labelTitle = new JLabel(title, JLabel.LEFT);
	  panelTitle.add(labelTitle, BorderLayout.NORTH);

	  JLabel labelText = new JLabel(text, JLabel.CENTER);
      labelText.setFont(labelText.getFont().deriveFont(Font.BOLD, 20.0f));

      JPanel panelText = new JPanel(new CardLayout(10, 4));
      panelText.setBackground(color);
	  panelText.add(labelText, "card");
      panelTitle.add(panelText, BorderLayout.SOUTH);

      JPanel panel = new JPanel(new CardLayout(8, 1));
      panel.add(panelTitle, "card");

      return panel;
  }

  private JComponent getInfoProgress(String title, String text, int value){
      JPanel panelProgress = new JPanel(new BorderLayout());
      panelProgress.setLayout(new BoxLayout(panelProgress, BoxLayout.Y_AXIS));

	  JLabel labelTitle = new JLabel(title, JLabel.LEFT);
      JPanel panelTitle = new JPanel(new BorderLayout());
	  panelTitle.add(labelTitle, BorderLayout.WEST);
      panelProgress.add(panelTitle);

	  JTextField field = new JTextField();
   	  field.setPreferredSize(new Dimension(70, vyska));
      field.setMargin(new Insets(0, 5, 0, 0));
	  field.setEditable(false);
	  field.setHorizontalAlignment(JTextField.LEFT);
      field.setText(text);
	  panelProgress.add(field);

      JPanel panelSep = new JPanel();
      panelSep.setPreferredSize(new Dimension(30, 8));
	  panelProgress.add(panelSep);

      JProgressBar progress = new JProgressBar();
      progress.setMaximum(100);
      progress.setValue(value);
      panelProgress.add(progress);

      JPanel panel = new JPanel(new CardLayout(8, 0));
      panel.add(panelProgress, "card");

      return panel;
  }

  private JComponent getInfoSeparator(){
      JPanel panel = new JPanel(new CardLayout(8, 8));

      JSeparator separator = new JSeparator();
      panel.add(separator, "card");

      return panel;
  }

  private JComponent getInfo(){
      JPanel panelInfo = new JPanel();
      panelInfo.setLayout(new BoxLayout(panelInfo, BoxLayout.Y_AXIS));

      panelInfo.add(getInfoEquip("Version:", "MAPPER 3.2.0", new Color(153, 204, 255)));
      panelInfo.add(getInfoEquip("Prober ID:", "EG2001.01", new Color(255, 153, 153)));
      panelInfo.add(getInfoEquip("Tester ID:", "ETS300.05", new Color(255, 255, 204)));

      panelInfo.add(getInfoSeparator());
      panelInfo.add(getInfoProgress("Sada:", "P0SF639781", 33));
      panelInfo.add(getInfoSeparator());
      panelInfo.add(getInfoProgress("Deska:", "#01 (06BEA063SED4)", 85));
      panelInfo.add(getInfoSeparator());

      JPanel panelE = new JPanel(new BorderLayout());
      panelE.add(panelInfo, BorderLayout.NORTH);
      
	  JPanel panel = new JPanel(new BorderLayout());
      panel.add(panelE, BorderLayout.EAST);

      JSeparator separator = new JSeparator();
      separator.setOrientation(JSeparator.VERTICAL);
      panel.add(separator, BorderLayout.WEST);

      return panel;
  }
  
  private JComponent getStatus(){
	  JPanel status = new JPanel(new BorderLayout());
      status.setPreferredSize(new Dimension(100, 24));

      JSeparator separator = new JSeparator();
      status.add(separator, BorderLayout.NORTH);

      JLabel label = new JLabel("  Priklad GUI pro mereni desek.", JLabel.LEFT);
      label.setFont(label.getFont().deriveFont(Font.BOLD));
      status.add(label, BorderLayout.WEST);

	  return status;
  }
  
  private void buttonActionPerformed(ActionEvent evt) {
      Wizard dialog = new Wizard(this, true, vyska);
      dialog.setVisible(true);
  }

  int vyska;

  public Mapper (){
	  super("Mapper");

      JTextField field = new JTextField();
      vyska = (int)Math.round(field.getFont().getStringBounds("P0SF", new FontRenderContext(field.getFont().getTransform(), false, false)).getHeight());
      vyska += 7;

	  Container obsah = getContentPane();
	  obsah.add(getMenuToolBar(), BorderLayout.NORTH);
	  obsah.add(getWafer(), BorderLayout.CENTER);
	  obsah.add(getInfo(), BorderLayout.EAST);
	  obsah.add(getStatus(), BorderLayout.SOUTH);

	  pack();
      setLocationRelativeTo(null);
  }
  
  public static void main(String[] args) {
      try{
          UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
      }
      catch (Exception e) {}
	  Mapper mapper = new Mapper();
	  mapper.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	  mapper.setVisible(true);
  }
}