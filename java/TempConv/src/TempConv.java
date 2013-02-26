import java.awt.*;
import javax.swing.*;
import java.awt.event.ActionListener;
import java.awt.event.ActionEvent;
import java.text.DecimalFormat;
import java.text.NumberFormat;

public class TempConv extends JFrame implements ActionListener {

    private static final long serialVersionUID = 1;

    /** Volba smeru prevodu Celsius -> Fahrenheit. */
    JRadioButton rbtC2F;
    /** Volba smeru prevodu Fahrenheit -> Celsius. */
    JRadioButton rbtF2C;
    /** Volba poctu zobrazovanych desetinnych mist ve vysledku. */
    JComboBox cmbPrec;
    /** Vstupni pole. */
    JTextField txtIn;
    /** Vystupni pole s vysledkem prevodu. */
    JTextField txtOut;


	
    public void actionPerformed(ActionEvent e) {
        double temp = 0.0;
        try {
            temp = Double.parseDouble(txtIn.getText().replace(',', '.'));
        } catch (java.lang.NumberFormatException nfe) {
            txtOut.setText("");
            return;
        }

	    if (rbtC2F.isSelected())
		    temp = temp * 9.0 / 5.0 + 32.0;
	    else
		    temp = (temp - 32.0) * 5.0 / 9.0;

        switch (cmbPrec.getSelectedIndex())
        {
            case 4:
                txtOut.setText(String.format("%1.4f", temp));
                break;
            case 3:
                txtOut.setText(String.format("%1.3f", temp));
                break;
            case 2:
                txtOut.setText(String.format("%1.2f", temp));
                break;
            case 1:
                txtOut.setText(String.format("%1.1f", temp));
                break;
            default:
                txtOut.setText(String.format("%1.0f", temp));
                break;
        }
    }
  
    protected JComponent getLista(){
	    JLabel label1=new JLabel("<html><b>Priklad GUI pro prevod teplot.</b></html>", JLabel.LEFT);
	    JPanel lista=new JPanel(new BorderLayout());
	    lista.add(label1, BorderLayout.WEST);
	    JLabel label2=new JLabel("<html><i>URO 2009</i></html>", JLabel.LEFT);
	    lista.add(label2, BorderLayout.EAST);
	    return lista;
    }
    protected JComponent getSmer(){
	    JPanel panel=new JPanel();
	    panel.setBorder(BorderFactory.createTitledBorder("Smer prevodu"));

        ButtonGroup btgDir = new ButtonGroup();
        rbtC2F = new JRadioButton("stC na stF");
        rbtC2F.setSelected(true);
        btgDir.add(rbtC2F);
        panel.add(rbtC2F);
        rbtF2C = new JRadioButton("stF na stC");
        btgDir.add(rbtF2C);
        panel.add(rbtF2C);

 	    return panel;
    }

    protected JComponent getPresnost(){
        JLabel l = new JLabel("Pocet desetinnych mist:", JLabel.LEFT);

        String[] items = new String[5];
        items[0] = "0";
        items[1] = "1";
        items[2] = "2";
        items[3] = "3";
        items[4] = "4";
        cmbPrec = new JComboBox(items);
        cmbPrec.setEditable(false);
        cmbPrec.setSelectedIndex(2);

        JPanel panel = new JPanel(new FlowLayout());
        panel.add(l);
        panel.add(cmbPrec);

	    return panel;
    }
  
    protected JComponent getImage(){
        ImageIcon i = new ImageIcon(getClass().getResource("thermo2.png"));
        JLabel I = new JLabel(i);

	    JPanel panel = new JPanel();
        panel.add(I);
	    return panel;
    }

    protected JComponent getPanel(){
	    JPanel p1 = new JPanel();
        p1.setLayout(new BoxLayout(p1, BoxLayout.Y_AXIS));
	    JLabel l1=new JLabel("Vstup", JLabel.LEFT);
	    p1.add(l1);
	    txtIn = new JTextField();
	    txtIn.setPreferredSize(new Dimension(70, 20));
	    txtIn.setHorizontalAlignment(JTextField.RIGHT);
        p1.add(txtIn);
        JPanel cp1 = new JPanel(new CardLayout(10, 10));
        cp1.add(p1, "card");
          
	    JPanel p2 = new JPanel();
        p2.setLayout(new BoxLayout(p2, BoxLayout.Y_AXIS));
	    JLabel l2=new JLabel("Vystup", JLabel.LEFT);
	    p2.add(l2);
	    txtOut = new JTextField();
	    txtOut.setPreferredSize(new Dimension(70, 20));
	    txtOut.setEditable(false);
	    txtOut.setHorizontalAlignment(JTextField.RIGHT);
        p2.add(txtOut);
        JPanel cp2 = new JPanel(new CardLayout(10, 10));
        cp2.add(p2, "card");

	    JPanel panel = new JPanel();

	    panel.setLayout(new GridBagLayout());
	    GridBagConstraints c = new GridBagConstraints();
	    panel.add(cp1, c);
	    panel.add(cp2, c);
      
	    return panel;
    }

    protected JComponent getPotvrd(){

        JPanel panel = new JPanel();
        JButton b = new JButton("Prevod");
        b.addActionListener(this);
        panel.add(b);

        return panel;
    }

    public TempConv (){
	    super("Prevod teplot");

        Container obsah = getContentPane();
	    obsah.add(getLista(), BorderLayout.SOUTH);
	    JPanel hlavni=new JPanel();
	    hlavni.setLayout(new BoxLayout(hlavni, BoxLayout.Y_AXIS));
	    hlavni.add(getSmer());
	    hlavni.add(getPanel());
        hlavni.add(getPresnost());
	    hlavni.add(getPotvrd());
	  
	    obsah.add(hlavni, BorderLayout.WEST);
	    obsah.add(getImage(), BorderLayout.EAST);
    }
  
    public static void main(String[] args) {
        try{
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        }
        catch (Exception e) {}
	    TempConv conv = new TempConv();
	    conv.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	    conv.pack();
	    conv.setVisible(true);
    }
}