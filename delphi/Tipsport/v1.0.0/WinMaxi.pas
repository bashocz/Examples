unit WinMaxi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Spin, Grids,
  TipTypes, Buttons;

type
  TFormMaxi = class(TForm)
    LabelTab: TLabel;
    GridTab: TStringGrid;
    BoxConst: TGroupBox;
    LabelMa1: TLabel;
    LabelTi1: TLabel;
    LabelRa1: TLabel;
    LabelMa2: TLabel;
    LabelTi2: TLabel;
    LabelRa2: TLabel;
    PanelA01: TPanel;
    LabelM01: TLabel;
    Button011: TSpeedButton;
    Button012: TSpeedButton;
    Button013: TSpeedButton;
    Button014: TSpeedButton;
    Button015: TSpeedButton;
    PanelM01: TPanel;
    PanelR01: TPanel;
    PanelA02: TPanel;
    LabelM02: TLabel;
    Button021: TSpeedButton;
    Button022: TSpeedButton;
    Button023: TSpeedButton;
    Button024: TSpeedButton;
    Button025: TSpeedButton;
    PanelM02: TPanel;
    PanelR02: TPanel;
    PanelA03: TPanel;
    LabelM03: TLabel;
    Button031: TSpeedButton;
    Button032: TSpeedButton;
    Button033: TSpeedButton;
    Button034: TSpeedButton;
    Button035: TSpeedButton;
    PanelM03: TPanel;
    PanelR03: TPanel;
    PanelA04: TPanel;
    LabelM04: TLabel;
    Button041: TSpeedButton;
    Button042: TSpeedButton;
    Button043: TSpeedButton;
    Button044: TSpeedButton;
    Button045: TSpeedButton;
    PanelM04: TPanel;
    PanelR04: TPanel;
    PanelA05: TPanel;
    LabelM05: TLabel;
    Button051: TSpeedButton;
    Button052: TSpeedButton;
    Button053: TSpeedButton;
    Button054: TSpeedButton;
    Button055: TSpeedButton;
    PanelM05: TPanel;
    PanelR05: TPanel;
    PanelA06: TPanel;
    LabelM06: TLabel;
    Button061: TSpeedButton;
    Button062: TSpeedButton;
    Button063: TSpeedButton;
    Button064: TSpeedButton;
    Button065: TSpeedButton;
    PanelM06: TPanel;
    PanelR06: TPanel;
    PanelA07: TPanel;
    LabelM07: TLabel;
    Button071: TSpeedButton;
    Button072: TSpeedButton;
    Button073: TSpeedButton;
    Button074: TSpeedButton;
    Button075: TSpeedButton;
    PanelM07: TPanel;
    PanelR07: TPanel;
    PanelA08: TPanel;
    LabelM08: TLabel;
    Button081: TSpeedButton;
    Button082: TSpeedButton;
    Button083: TSpeedButton;
    Button084: TSpeedButton;
    Button085: TSpeedButton;
    PanelM08: TPanel;
    PanelR08: TPanel;
    PanelA09: TPanel;
    LabelM09: TLabel;
    Button091: TSpeedButton;
    Button092: TSpeedButton;
    Button093: TSpeedButton;
    Button094: TSpeedButton;
    Button095: TSpeedButton;
    PanelM09: TPanel;
    PanelR09: TPanel;
    PanelA10: TPanel;
    LabelM10: TLabel;
    Button101: TSpeedButton;
    Button102: TSpeedButton;
    Button103: TSpeedButton;
    Button104: TSpeedButton;
    Button105: TSpeedButton;
    PanelM10: TPanel;
    PanelR10: TPanel;
    PanelA11: TPanel;
    LabelM11: TLabel;
    Button111: TSpeedButton;
    Button112: TSpeedButton;
    Button113: TSpeedButton;
    Button114: TSpeedButton;
    Button115: TSpeedButton;
    PanelM11: TPanel;
    PanelR11: TPanel;
    PanelA12: TPanel;
    LabelM12: TLabel;
    Button121: TSpeedButton;
    Button122: TSpeedButton;
    Button123: TSpeedButton;
    Button124: TSpeedButton;
    Button125: TSpeedButton;
    PanelM12: TPanel;
    PanelR12: TPanel;
    PanelA13: TPanel;
    LabelM13: TLabel;
    Button131: TSpeedButton;
    Button132: TSpeedButton;
    Button133: TSpeedButton;
    Button134: TSpeedButton;
    Button135: TSpeedButton;
    PanelM13: TPanel;
    PanelR13: TPanel;
    PanelA14: TPanel;
    LabelM14: TLabel;
    Button141: TSpeedButton;
    Button142: TSpeedButton;
    Button143: TSpeedButton;
    Button144: TSpeedButton;
    Button145: TSpeedButton;
    PanelM14: TPanel;
    PanelR14: TPanel;
    PanelA15: TPanel;
    LabelM15: TLabel;
    Button151: TSpeedButton;
    Button152: TSpeedButton;
    Button153: TSpeedButton;
    Button154: TSpeedButton;
    Button155: TSpeedButton;
    PanelM15: TPanel;
    PanelR15: TPanel;
    PanelA16: TPanel;
    LabelM16: TLabel;
    Button161: TSpeedButton;
    Button162: TSpeedButton;
    Button163: TSpeedButton;
    Button164: TSpeedButton;
    Button165: TSpeedButton;
    PanelM16: TPanel;
    PanelR16: TPanel;
    PanelA17: TPanel;
    LabelM17: TLabel;
    Button171: TSpeedButton;
    Button172: TSpeedButton;
    Button173: TSpeedButton;
    Button174: TSpeedButton;
    Button175: TSpeedButton;
    PanelM17: TPanel;
    PanelR17: TPanel;
    PanelA18: TPanel;
    LabelM18: TLabel;
    Button181: TSpeedButton;
    Button182: TSpeedButton;
    Button183: TSpeedButton;
    Button184: TSpeedButton;
    Button185: TSpeedButton;
    PanelM18: TPanel;
    PanelR18: TPanel;
    PanelA19: TPanel;
    LabelM19: TLabel;
    Button191: TSpeedButton;
    Button192: TSpeedButton;
    Button193: TSpeedButton;
    Button194: TSpeedButton;
    Button195: TSpeedButton;
    PanelM19: TPanel;
    PanelR19: TPanel;
    PanelA20: TPanel;
    LabelM20: TLabel;
    Button201: TSpeedButton;
    Button202: TSpeedButton;
    Button203: TSpeedButton;
    Button204: TSpeedButton;
    Button205: TSpeedButton;
    PanelM20: TPanel;
    PanelR20: TPanel;
    PanelA21: TPanel;
    LabelM21: TLabel;
    Button211: TSpeedButton;
    Button212: TSpeedButton;
    Button213: TSpeedButton;
    Button214: TSpeedButton;
    Button215: TSpeedButton;
    PanelM21: TPanel;
    PanelR21: TPanel;
    PanelA22: TPanel;
    LabelM22: TLabel;
    Button221: TSpeedButton;
    Button222: TSpeedButton;
    Button223: TSpeedButton;
    Button224: TSpeedButton;
    Button225: TSpeedButton;
    PanelM22: TPanel;
    PanelR22: TPanel;
    PanelA23: TPanel;
    LabelM23: TLabel;
    Button231: TSpeedButton;
    Button232: TSpeedButton;
    Button233: TSpeedButton;
    Button234: TSpeedButton;
    Button235: TSpeedButton;
    PanelM23: TPanel;
    PanelR23: TPanel;
    PanelA24: TPanel;
    LabelM24: TLabel;
    Button241: TSpeedButton;
    Button242: TSpeedButton;
    Button243: TSpeedButton;
    Button244: TSpeedButton;
    Button245: TSpeedButton;
    PanelM24: TPanel;
    PanelR24: TPanel;
    PanelA25: TPanel;
    LabelM25: TLabel;
    Button251: TSpeedButton;
    Button252: TSpeedButton;
    Button253: TSpeedButton;
    Button254: TSpeedButton;
    Button255: TSpeedButton;
    PanelM25: TPanel;
    PanelR25: TPanel;
    PanelA26: TPanel;
    LabelM26: TLabel;
    Button261: TSpeedButton;
    Button262: TSpeedButton;
    Button263: TSpeedButton;
    Button264: TSpeedButton;
    Button265: TSpeedButton;
    PanelM26: TPanel;
    PanelR26: TPanel;
    PanelA27: TPanel;
    LabelM27: TLabel;
    Button271: TSpeedButton;
    Button272: TSpeedButton;
    Button273: TSpeedButton;
    Button274: TSpeedButton;
    Button275: TSpeedButton;
    PanelM27: TPanel;
    PanelR27: TPanel;
    PanelA28: TPanel;
    LabelM28: TLabel;
    Button281: TSpeedButton;
    Button282: TSpeedButton;
    Button283: TSpeedButton;
    Button284: TSpeedButton;
    Button285: TSpeedButton;
    PanelM28: TPanel;
    PanelR28: TPanel;
    PanelA29: TPanel;
    LabelM29: TLabel;
    Button291: TSpeedButton;
    Button292: TSpeedButton;
    Button293: TSpeedButton;
    Button294: TSpeedButton;
    Button295: TSpeedButton;
    PanelM29: TPanel;
    PanelR29: TPanel;
    PanelA30: TPanel;
    LabelM30: TLabel;
    Button301: TSpeedButton;
    Button302: TSpeedButton;
    Button303: TSpeedButton;
    Button304: TSpeedButton;
    Button305: TSpeedButton;
    PanelM30: TPanel;
    PanelR30: TPanel;
    PanelA31: TPanel;
    LabelM31: TLabel;
    Button311: TSpeedButton;
    Button312: TSpeedButton;
    Button313: TSpeedButton;
    Button314: TSpeedButton;
    Button315: TSpeedButton;
    PanelM31: TPanel;
    PanelR31: TPanel;
    PanelA32: TPanel;
    LabelM32: TLabel;
    Button321: TSpeedButton;
    Button322: TSpeedButton;
    Button323: TSpeedButton;
    Button324: TSpeedButton;
    Button325: TSpeedButton;
    PanelM32: TPanel;
    PanelR32: TPanel;
    PanelA33: TPanel;
    LabelM33: TLabel;
    Button331: TSpeedButton;
    Button332: TSpeedButton;
    Button333: TSpeedButton;
    Button334: TSpeedButton;
    Button335: TSpeedButton;
    PanelM33: TPanel;
    PanelR33: TPanel;
    PanelA34: TPanel;
    LabelM34: TLabel;
    Button341: TSpeedButton;
    Button342: TSpeedButton;
    Button343: TSpeedButton;
    Button344: TSpeedButton;
    Button345: TSpeedButton;
    PanelM34: TPanel;
    PanelR34: TPanel;
    PanelA35: TPanel;
    LabelM35: TLabel;
    Button351: TSpeedButton;
    Button352: TSpeedButton;
    Button353: TSpeedButton;
    Button354: TSpeedButton;
    Button355: TSpeedButton;
    PanelM35: TPanel;
    PanelR35: TPanel;
    PanelA36: TPanel;
    LabelM36: TLabel;
    Button361: TSpeedButton;
    Button362: TSpeedButton;
    Button363: TSpeedButton;
    Button364: TSpeedButton;
    Button365: TSpeedButton;
    PanelM36: TPanel;
    PanelR36: TPanel;
    PanelA37: TPanel;
    LabelM37: TLabel;
    Button371: TSpeedButton;
    Button372: TSpeedButton;
    Button373: TSpeedButton;
    Button374: TSpeedButton;
    Button375: TSpeedButton;
    PanelM37: TPanel;
    PanelR37: TPanel;
    PanelA38: TPanel;
    LabelM38: TLabel;
    Button381: TSpeedButton;
    Button382: TSpeedButton;
    Button383: TSpeedButton;
    Button384: TSpeedButton;
    Button385: TSpeedButton;
    PanelM38: TPanel;
    PanelR38: TPanel;
    PanelA39: TPanel;
    LabelM39: TLabel;
    Button391: TSpeedButton;
    Button392: TSpeedButton;
    Button393: TSpeedButton;
    Button394: TSpeedButton;
    Button395: TSpeedButton;
    PanelM39: TPanel;
    PanelR39: TPanel;
    PanelA40: TPanel;
    LabelM40: TLabel;
    Button401: TSpeedButton;
    Button402: TSpeedButton;
    Button403: TSpeedButton;
    Button404: TSpeedButton;
    Button405: TSpeedButton;
    PanelM40: TPanel;
    PanelR40: TPanel;
    BoxGroup: TGroupBox;
    LabelMa3: TLabel;
    LabelTi3: TLabel;
    LabelRa3: TLabel;
    LabelMa4: TLabel;
    LabelTi4: TLabel;
    LabelRa4: TLabel;
    PanelGrA: TPanel;
    LabelGrA: TLabel;
    ButtonA11: TSpeedButton;
    ButtonA12: TSpeedButton;
    ButtonA13: TSpeedButton;
    ButtonA14: TSpeedButton;
    ButtonA15: TSpeedButton;
    ButtonA21: TSpeedButton;
    ButtonA22: TSpeedButton;
    ButtonA23: TSpeedButton;
    ButtonA24: TSpeedButton;
    ButtonA25: TSpeedButton;
    ButtonA31: TSpeedButton;
    ButtonA32: TSpeedButton;
    ButtonA33: TSpeedButton;
    ButtonA34: TSpeedButton;
    ButtonA35: TSpeedButton;
    ButtonA41: TSpeedButton;
    ButtonA42: TSpeedButton;
    ButtonA43: TSpeedButton;
    ButtonA44: TSpeedButton;
    ButtonA45: TSpeedButton;
    PanelMA1: TPanel;
    PanelRA1: TPanel;
    PanelMA2: TPanel;
    PanelRA2: TPanel;
    PanelMA3: TPanel;
    PanelRA3: TPanel;
    PanelMA4: TPanel;
    PanelRA4: TPanel;
    PanelGrB: TPanel;
    LabelGrB: TLabel;
    ButtonB11: TSpeedButton;
    ButtonB12: TSpeedButton;
    ButtonB13: TSpeedButton;
    ButtonB14: TSpeedButton;
    ButtonB15: TSpeedButton;
    ButtonB21: TSpeedButton;
    ButtonB22: TSpeedButton;
    ButtonB23: TSpeedButton;
    ButtonB24: TSpeedButton;
    ButtonB25: TSpeedButton;
    ButtonB31: TSpeedButton;
    ButtonB32: TSpeedButton;
    ButtonB33: TSpeedButton;
    ButtonB34: TSpeedButton;
    ButtonB35: TSpeedButton;
    ButtonB41: TSpeedButton;
    ButtonB42: TSpeedButton;
    ButtonB43: TSpeedButton;
    ButtonB44: TSpeedButton;
    ButtonB45: TSpeedButton;
    PanelMB1: TPanel;
    PanelRB1: TPanel;
    PanelMB2: TPanel;
    PanelRB2: TPanel;
    PanelMB3: TPanel;
    PanelRB3: TPanel;
    PanelMB4: TPanel;
    PanelRB4: TPanel;
    PanelGrC: TPanel;
    LabelGrC: TLabel;
    ButtonC11: TSpeedButton;
    ButtonC12: TSpeedButton;
    ButtonC13: TSpeedButton;
    ButtonC14: TSpeedButton;
    ButtonC15: TSpeedButton;
    ButtonC21: TSpeedButton;
    ButtonC22: TSpeedButton;
    ButtonC23: TSpeedButton;
    ButtonC24: TSpeedButton;
    ButtonC25: TSpeedButton;
    ButtonC31: TSpeedButton;
    ButtonC32: TSpeedButton;
    ButtonC33: TSpeedButton;
    ButtonC34: TSpeedButton;
    ButtonC35: TSpeedButton;
    ButtonC41: TSpeedButton;
    ButtonC42: TSpeedButton;
    ButtonC43: TSpeedButton;
    ButtonC44: TSpeedButton;
    ButtonC45: TSpeedButton;
    PanelMC1: TPanel;
    PanelRC1: TPanel;
    PanelMC2: TPanel;
    PanelRC2: TPanel;
    PanelMC3: TPanel;
    PanelRC3: TPanel;
    PanelMC4: TPanel;
    PanelRC4: TPanel;
    PanelGrD: TPanel;
    LabelGrD: TLabel;
    ButtonD11: TSpeedButton;
    ButtonD12: TSpeedButton;
    ButtonD13: TSpeedButton;
    ButtonD14: TSpeedButton;
    ButtonD15: TSpeedButton;
    ButtonD21: TSpeedButton;
    ButtonD22: TSpeedButton;
    ButtonD23: TSpeedButton;
    ButtonD24: TSpeedButton;
    ButtonD25: TSpeedButton;
    ButtonD31: TSpeedButton;
    ButtonD32: TSpeedButton;
    ButtonD33: TSpeedButton;
    ButtonD34: TSpeedButton;
    ButtonD35: TSpeedButton;
    ButtonD41: TSpeedButton;
    ButtonD42: TSpeedButton;
    ButtonD43: TSpeedButton;
    ButtonD44: TSpeedButton;
    ButtonD45: TSpeedButton;
    PanelMD1: TPanel;
    PanelRD1: TPanel;
    PanelMD2: TPanel;
    PanelRD2: TPanel;
    PanelMD3: TPanel;
    PanelRD3: TPanel;
    PanelMD4: TPanel;
    PanelRD4: TPanel;
    PanelGrE: TPanel;
    LabelGrE: TLabel;
    ButtonE11: TSpeedButton;
    ButtonE12: TSpeedButton;
    ButtonE13: TSpeedButton;
    ButtonE14: TSpeedButton;
    ButtonE15: TSpeedButton;
    ButtonE21: TSpeedButton;
    ButtonE22: TSpeedButton;
    ButtonE23: TSpeedButton;
    ButtonE24: TSpeedButton;
    ButtonE25: TSpeedButton;
    ButtonE31: TSpeedButton;
    ButtonE32: TSpeedButton;
    ButtonE33: TSpeedButton;
    ButtonE34: TSpeedButton;
    ButtonE35: TSpeedButton;
    ButtonE41: TSpeedButton;
    ButtonE42: TSpeedButton;
    ButtonE43: TSpeedButton;
    ButtonE44: TSpeedButton;
    ButtonE45: TSpeedButton;
    PanelME1: TPanel;
    PanelRE1: TPanel;
    PanelME2: TPanel;
    PanelRE2: TPanel;
    PanelME3: TPanel;
    PanelRE3: TPanel;
    PanelME4: TPanel;
    PanelRE4: TPanel;
    PanelGrF: TPanel;
    LabelGrF: TLabel;
    ButtonF11: TSpeedButton;
    ButtonF12: TSpeedButton;
    ButtonF13: TSpeedButton;
    ButtonF14: TSpeedButton;
    ButtonF15: TSpeedButton;
    ButtonF21: TSpeedButton;
    ButtonF22: TSpeedButton;
    ButtonF23: TSpeedButton;
    ButtonF24: TSpeedButton;
    ButtonF25: TSpeedButton;
    ButtonF31: TSpeedButton;
    ButtonF32: TSpeedButton;
    ButtonF33: TSpeedButton;
    ButtonF34: TSpeedButton;
    ButtonF35: TSpeedButton;
    ButtonF41: TSpeedButton;
    ButtonF42: TSpeedButton;
    ButtonF43: TSpeedButton;
    ButtonF44: TSpeedButton;
    ButtonF45: TSpeedButton;
    PanelMF1: TPanel;
    PanelRF1: TPanel;
    PanelMF2: TPanel;
    PanelRF2: TPanel;
    PanelMF3: TPanel;
    PanelRF3: TPanel;
    PanelMF4: TPanel;
    PanelRF4: TPanel;
    PanelGrG: TPanel;
    LabelGrG: TLabel;
    ButtonG11: TSpeedButton;
    ButtonG12: TSpeedButton;
    ButtonG13: TSpeedButton;
    ButtonG14: TSpeedButton;
    ButtonG15: TSpeedButton;
    ButtonG21: TSpeedButton;
    ButtonG22: TSpeedButton;
    ButtonG23: TSpeedButton;
    ButtonG24: TSpeedButton;
    ButtonG25: TSpeedButton;
    ButtonG31: TSpeedButton;
    ButtonG32: TSpeedButton;
    ButtonG33: TSpeedButton;
    ButtonG34: TSpeedButton;
    ButtonG35: TSpeedButton;
    ButtonG41: TSpeedButton;
    ButtonG42: TSpeedButton;
    ButtonG43: TSpeedButton;
    ButtonG44: TSpeedButton;
    ButtonG45: TSpeedButton;
    PanelMG1: TPanel;
    PanelRG1: TPanel;
    PanelMG2: TPanel;
    PanelRG2: TPanel;
    PanelMG3: TPanel;
    PanelRG3: TPanel;
    PanelMG4: TPanel;
    PanelRG4: TPanel;
    PanelGrH: TPanel;
    LabelGrH: TLabel;
    ButtonH11: TSpeedButton;
    ButtonH12: TSpeedButton;
    ButtonH13: TSpeedButton;
    ButtonH14: TSpeedButton;
    ButtonH15: TSpeedButton;
    ButtonH22: TSpeedButton;
    ButtonH23: TSpeedButton;
    ButtonH24: TSpeedButton;
    ButtonH25: TSpeedButton;
    ButtonH31: TSpeedButton;
    ButtonH32: TSpeedButton;
    ButtonH33: TSpeedButton;
    ButtonH34: TSpeedButton;
    ButtonH35: TSpeedButton;
    ButtonH41: TSpeedButton;
    ButtonH42: TSpeedButton;
    ButtonH43: TSpeedButton;
    ButtonH44: TSpeedButton;
    ButtonH45: TSpeedButton;
    ButtonH21: TSpeedButton;
    PanelMH1: TPanel;
    PanelRH1: TPanel;
    PanelMH2: TPanel;
    PanelRH2: TPanel;
    PanelMH3: TPanel;
    PanelRH3: TPanel;
    PanelMH4: TPanel;
    PanelRH4: TPanel;
    PanelGrI: TPanel;
    LabelGrI: TLabel;
    ButtonI11: TSpeedButton;
    ButtonI12: TSpeedButton;
    ButtonI13: TSpeedButton;
    ButtonI14: TSpeedButton;
    ButtonI15: TSpeedButton;
    ButtonI21: TSpeedButton;
    ButtonI22: TSpeedButton;
    ButtonI23: TSpeedButton;
    ButtonI24: TSpeedButton;
    ButtonI25: TSpeedButton;
    ButtonI31: TSpeedButton;
    ButtonI32: TSpeedButton;
    ButtonI33: TSpeedButton;
    ButtonI34: TSpeedButton;
    ButtonI35: TSpeedButton;
    ButtonI41: TSpeedButton;
    ButtonI42: TSpeedButton;
    ButtonI43: TSpeedButton;
    ButtonI44: TSpeedButton;
    ButtonI45: TSpeedButton;
    PanelMI1: TPanel;
    PanelRI1: TPanel;
    PanelMI2: TPanel;
    PanelRI2: TPanel;
    PanelMI3: TPanel;
    PanelRI3: TPanel;
    PanelMI4: TPanel;
    PanelRI4: TPanel;
    PanelGrJ: TPanel;
    LabelGrJ: TLabel;
    ButtonJ11: TSpeedButton;
    ButtonJ12: TSpeedButton;
    ButtonJ13: TSpeedButton;
    ButtonJ14: TSpeedButton;
    ButtonJ15: TSpeedButton;
    ButtonJ21: TSpeedButton;
    ButtonJ22: TSpeedButton;
    ButtonJ23: TSpeedButton;
    ButtonJ24: TSpeedButton;
    ButtonJ25: TSpeedButton;
    ButtonJ31: TSpeedButton;
    ButtonJ32: TSpeedButton;
    ButtonJ33: TSpeedButton;
    ButtonJ34: TSpeedButton;
    ButtonJ35: TSpeedButton;
    ButtonJ41: TSpeedButton;
    ButtonJ42: TSpeedButton;
    ButtonJ43: TSpeedButton;
    ButtonJ44: TSpeedButton;
    ButtonJ45: TSpeedButton;
    PanelMJ1: TPanel;
    PanelRJ1: TPanel;
    PanelMj2: TPanel;
    PanelRJ2: TPanel;
    PanelMJ3: TPanel;
    PanelRJ3: TPanel;
    PanelMJ4: TPanel;
    PanelRJ4: TPanel;
    BoxGrSum: TGroupBox;
    LabelBet: TLabel;
    LabelRMi: TLabel;
    LabelRMa: TLabel;
    LabelMMi: TLabel;
    LabelMMa: TLabel;
    LabelGr1: TLabel;
    LabelGr2: TLabel;
    LabelGr3: TLabel;
    LabelGr4: TLabel;
    LabelGr5: TLabel;
    LabelGr6: TLabel;
    LabelGr7: TLabel;
    LabelGr8: TLabel;
    LabelGr9: TLabel;
    LabelGr0: TLabel;
    EditBe1: TSpinEdit;
    PanelRM1: TPanel;
    PanelRX1: TPanel;
    PanelWM1: TPanel;
    PanelWX1: TPanel;
    EditBe2: TSpinEdit;
    PanelRM2: TPanel;
    PanelRX2: TPanel;
    PanelWM2: TPanel;
    PanelWX2: TPanel;
    EditBe3: TSpinEdit;
    PanelRM3: TPanel;
    PanelRX3: TPanel;
    PanelWM3: TPanel;
    PanelWX3: TPanel;
    EditBe4: TSpinEdit;
    PanelRM4: TPanel;
    PanelRX4: TPanel;
    PanelWM4: TPanel;
    PanelWX4: TPanel;
    EditBe5: TSpinEdit;
    PanelRM5: TPanel;
    PanelRX5: TPanel;
    PanelWM5: TPanel;
    PanelWX5: TPanel;
    EditBe6: TSpinEdit;
    PanelRM6: TPanel;
    PanelRX6: TPanel;
    PanelWM6: TPanel;
    PanelWX6: TPanel;
    EditBe7: TSpinEdit;
    PanelRM7: TPanel;
    PanelRX7: TPanel;
    PanelWM7: TPanel;
    PanelWX7: TPanel;
    EditBe8: TSpinEdit;
    PanelRM8: TPanel;
    PanelRX8: TPanel;
    PanelWM8: TPanel;
    PanelWX8: TPanel;
    EditBe9: TSpinEdit;
    PanelRM9: TPanel;
    PanelRX9: TPanel;
    PanelWM9: TPanel;
    PanelWX9: TPanel;
    EditBe0: TSpinEdit;
    PanelRM0: TPanel;
    PanelRX0: TPanel;
    PanelWM0: TPanel;
    PanelWX0: TPanel;
    LabelMoA: TLabel;
    LabelRaA: TLabel;
    LabelWiA: TLabel;
    PanelMoA: TPanel;
    PanelRaA: TPanel;
    PanelWiA: TPanel;
    LabelTic: TLabel;
    PanelTi1: TPanel;
    PanelTi2: TPanel;
    PanelTi3: TPanel;
    PanelTi4: TPanel;
    PanelTi5: TPanel;
    PanelTi6: TPanel;
    PanelTi7: TPanel;
    PanelTi8: TPanel;
    PanelTi9: TPanel;
    PanelTi0: TPanel;
    LabelSRA: TLabel;
    LabelSRB: TLabel;
    LabelSRC: TLabel;
    LabelSRD: TLabel;
    LabelSRE: TLabel;
    LabelSRF: TLabel;
    LabelSRG: TLabel;
    LabelSRH: TLabel;
    LabelSRI: TLabel;
    LabelSRJ: TLabel;
    LabelSuR: TLabel;
    PanelSRA: TPanel;
    PanelSRB: TPanel;
    PanelSRC: TPanel;
    PanelSRD: TPanel;
    PanelSRE: TPanel;
    PanelSRF: TPanel;
    PanelSRG: TPanel;
    PanelSRH: TPanel;
    PanelSRI: TPanel;
    PanelSRJ: TPanel;
    ButtonPrev: TButton;
    ButtonNext: TButton;
    ButtonCanc: TButton;
    procedure EditIntKeyPress(Sender: TObject; var Key: Char);
    procedure EditRealKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    IsEdit: boolean;
    emConstA: array[1..40] of TPanel;
    emConstM: array[1..40] of TPanel;
    emConstR: array[1..40] of TPanel;
    emConstB: array[1..40, 1..5] of TSpeedButton;
    emGroupA: array[1..10] of TPanel;
    emGroupM: array[1..10, 1..4] of TPanel;
    emGroupR: array[1..10, 1..4] of TPanel;
    emGroupB: array[1..10, 1..4, 1..5] of TSpeedButton;
    emGrBet: array[1..10] of TSpinEdit;
    emTiNum: array[1..10] of TPanel;
    emRaMin: array[1..10] of TPanel;
    emRaMax: array[1..10] of TPanel;
    emWiMin: array[1..10] of TPanel;
    emWiMax: array[1..10] of TPanel;
    emRateG: array[1..10] of TPanel;
  public
    { Public declarations }
    procedure EnableEdit;
    procedure DisableEdit;
    procedure DisplayConst(IdxM: integer);
    procedure DisplayGroup(IdxG, IdxM: integer);
    procedure DisplayAllMatchs;
    procedure DisplayAllStatistic;
  end;

var
  FormMaxi: TFormMaxi;

procedure ShowMaxiNew(var aTicket: TTicket);
procedure EditMaxi(var aTicket: TTicket);
procedure ShowMaxi(aTicket: TTicket);

implementation

{$R *.dfm}

var
  TicketEdit: TTicket;

procedure ShowMaxiNew(var aTicket: TTicket);
var
  i,j,k: integer;
begin
  TicketEdit.TicketNumber:=0;
  for i:=1 to 40 do
  begin
    TicketEdit.tiConst[i].TipNumber:=0;
    TicketEdit.tiConst[i].TipMatchNumber:=0;
    TicketEdit.tiConst[i].Team1Number:=0;
    TicketEdit.tiConst[i].Team2Number:=0;
    for k:=1 to 5 do
    begin
      TicketEdit.tiConst[i].Tips[k]:=0;
      TicketEdit.tiConst[i].TipsValue[k]:=0;
    end;
    TicketEdit.tiConst[i].Tip:=0;
    TicketEdit.tiConst[i].IsScore:=False;
    TicketEdit.tiConst[i].ScoreMatchNumber:=0;
  end;
  for i:=1 to 10 do
    for j:=1 to 4 do
    begin
      TicketEdit.tiGroup[i,j].TipNumber:=0;
      TicketEdit.tiGroup[i,j].Team1Number:=0;
      TicketEdit.tiGroup[i,j].TipMatchNumber:=0;
      TicketEdit.tiGroup[i,j].Team2Number:=0;
      for k:=1 to 5 do
      begin
        TicketEdit.tiGroup[i,j].Tips[k]:=0;
        TicketEdit.tiGroup[i,j].TipsValue[k]:=0;
      end;
      TicketEdit.tiGroup[i,j].Tip:=0;
      TicketEdit.tiGroup[i,j].IsScore:=False;
      TicketEdit.tiGroup[i,j].ScoreMatchNumber:=0;
    end;
  FormMaxi.EnableEdit;
  if (FormMaxi.ShowModal = mrOk) then
    aTicket:=TicketEdit;
end;

procedure EditMaxi(var aTicket: TTicket);
begin
  TicketEdit:=aTicket;
  FormMaxi.EnableEdit;
  if (FormMaxi.ShowModal = mrOk) then
    aTicket:=TicketEdit;
end;

procedure ShowMaxi(aTicket: TTicket);
begin
  FormMaxi.DisableEdit;
  TicketEdit:=aTicket;
  FormMaxi.ShowModal;
end;

procedure TFormMaxi.EnableEdit;
begin
end;

procedure TFormMaxi.DisableEdit;
begin
end;

procedure TFormMaxi.DisplayConst(IdxM: integer);
var
  mNum: integer;
  mTip: integer;
begin
  mNum:=TicketEdit.tiConst[IdxM].TipMatchNumber;
  if (mNum > 0) then
  begin
    emConstM[IdxM].Caption:=IntToStr(mNum);
    emConstM[IdxM].Hint:=IntToStr(mNum);
  end
  else
  begin
    emConstM[IdxM].Caption:='';
    emConstM[IdxM].Hint:='';
  end;

  emConstB[IdxM,1].Enabled:=False;
  emConstB[IdxM,2].Enabled:=False;
  emConstB[IdxM,3].Enabled:=False;
  emConstB[IdxM,4].Enabled:=False;
  emConstB[IdxM,5].Enabled:=False;
  emConstB[IdxM,1].Down:=False;
  emConstB[IdxM,2].Down:=False;
  emConstB[IdxM,3].Down:=False;
  emConstB[IdxM,4].Down:=False;
  emConstB[IdxM,5].Down:=False;

  mTip:=TicketEdit.tiConst[IdxM].Tip;
  if (IsEdit) then
  begin
    if (TicketEdit.tiConst[IdxM].Tips[1] > 1) then emConstB[IdxM,1].Enabled:=True;
    if (TicketEdit.tiConst[IdxM].Tips[2] > 1) then emConstB[IdxM,2].Enabled:=True;
    if (TicketEdit.tiConst[IdxM].Tips[3] > 1) then emConstB[IdxM,3].Enabled:=True;
    if (TicketEdit.tiConst[IdxM].Tips[4] > 1) then emConstB[IdxM,4].Enabled:=True;
    if (TicketEdit.tiConst[IdxM].Tips[5] > 1) then emConstB[IdxM,5].Enabled:=True;

    case mTip of
      1:emConstB[IdxM,1].Down:=True;
      2:emConstB[IdxM,1].Down:=True;
      3:emConstB[IdxM,1].Down:=True;
      4:emConstB[IdxM,1].Down:=True;
      5:emConstB[IdxM,1].Down:=True;
    end;
  end;

  if (mTip > 0) and (mTip < 6) then
    emConstR[IdxM].Caption:=Format('%3.2f', [TicketEdit.tiConst[IdxM].Tips[mTip]])
  else
    emConstR[IdxM].Caption:='';
end;

procedure TFormMaxi.DisplayGroup(IdxG, IdxM: integer);
var
  mNum: integer;
  mTip: integer;
begin
  mNum:=TicketEdit.tiGroup[IdxG, IdxM].TipMatchNumber;
  if (mNum > 0) then
  begin
    emGroupM[IdxG, IdxM].Caption:=IntToStr(mNum);
    emGroupM[IdxG, IdxM].Hint:=IntToStr(mNum);
  end
  else
  begin
    emGroupM[IdxG, IdxM].Caption:='';
    emGroupM[IdxG, IdxM].Hint:='';
  end;

  emGroupB[IdxG,IdxM,1].Enabled:=False;
  emGroupB[IdxG,IdxM,2].Enabled:=False;
  emGroupB[IdxG,IdxM,3].Enabled:=False;
  emGroupB[IdxG,IdxM,4].Enabled:=False;
  emGroupB[IdxG,IdxM,5].Enabled:=False;
  emGroupB[IdxG,IdxM,1].Down:=False;
  emGroupB[IdxG,IdxM,2].Down:=False;
  emGroupB[IdxG,IdxM,3].Down:=False;
  emGroupB[IdxG,IdxM,4].Down:=False;
  emGroupB[IdxG,IdxM,5].Down:=False;

  mTip:=TicketEdit.tiGroup[IdxG,IdxM].Tip;
  if (IsEdit) then
  begin
    if (TicketEdit.tiGroup[IdxG,IdxM].Tips[1] > 1) then emGroupB[IdxG,IdxM,1].Enabled:=True;
    if (TicketEdit.tiGroup[IdxG,IdxM].Tips[2] > 1) then emGroupB[IdxG,IdxM,2].Enabled:=True;
    if (TicketEdit.tiGroup[IdxG,IdxM].Tips[3] > 1) then emGroupB[IdxG,IdxM,3].Enabled:=True;
    if (TicketEdit.tiGroup[IdxG,IdxM].Tips[4] > 1) then emGroupB[IdxG,IdxM,4].Enabled:=True;
    if (TicketEdit.tiGroup[IdxG,IdxM].Tips[5] > 1) then emGroupB[IdxG,IdxM,5].Enabled:=True;

    case mTip of
      1:emGroupB[IdxG,IdxM,1].Down:=True;
      2:emGroupB[IdxG,IdxM,1].Down:=True;
      3:emGroupB[IdxG,IdxM,1].Down:=True;
      4:emGroupB[IdxG,IdxM,1].Down:=True;
      5:emGroupB[IdxG,IdxM,1].Down:=True;
    end;
  end;

  if (mTip > 0) and (mTip < 6) then
    emGroupR[IdxG, IdxM].Caption:=Format('%3.2f', [TicketEdit.tiGroup[IdxG, IdxM].Tips[mTip]])
  else
    emGroupR[IdxG, IdxM].Caption:='';
end;

procedure TFormMaxi.DisplayAllMatchs;
var
  i,j: integer;
begin
  for i:=1 to 40 do
    DisplayConst(i);
  for i:=1 to 10 do
    for j:=1 to 4 do
      DisplayGroup(i,j);
end;

procedure TFormMaxi.DisplayAllStatistic;
var
  i,j: integer;
  GrMax: integer;
  BetMx: integer;
  CRate: double;
  GRate: array[1..10] of double;
  GRaMn: array[1..10] of double;
  GRaMx: array[1..10] of double;
  TiCnt: array[1..10] of integer;
  RaTmp: array[1..252] of double;
  XXX: array[1..10] of integer;
  ARate: double;
  AWin: double;

  function GetNextXXX(var nXXX: array of integer; k,m: integer): boolean;
  begin
    if (k > 0) then
    begin
      nXXX[k-1]:=nXXX[k-1]+1;
      if (nXXX[k-1] > m) then
      begin
        Result:=GetNextXXX(nXXX, k-1, m-1);
        if (k > 1) then nXXX[k-1]:=nXXX[k-2]+1;
      end
      else
        Result:=True;
    end
    else
      Result:=False;
  end;

begin
  GrMax:=0;
  while (TicketEdit.tiGroup[GrMax+1,1].TipMatchNumber > 0) do
    GrMax:=GrMax+1;

  BetMx:=GrMax;
  if (BetMx = 0) then BetMx:=1;
  for i:=1 to 10 do
  begin
    emGrBet[i].Value:=TicketEdit.Bets[i];
    if (i <= BetMx) then emGrBet[i].Enabled:=True
                    else emGrBet[i].Enabled:=False;
  end;

  // vypocet kurzu pro konstanty
  CRate:=0;
  for i:=1 to 40 do
  begin
    if (TicketEdit.tiConst[i].TipMatchNumber > 0) then
    begin
      if (TicketEdit.tiConst[i].Tip > 0) and (TicketEdit.tiConst[i].Tip < 6) then
      begin
        if (CRate < 1) then CRate:=1;
        CRate:=CRate*TicketEdit.tiConst[i].Tips[TicketEdit.tiConst[i].Tip];
      end;
    end;
  end;

  // vypocet kurzu pro skupiny
  ARate:=0;
  AWin:=0;
  if (GrMax > 0) then
  begin
    if (CRate = 0) then CRate:=1;

    // vypocet kurzu pro jednotlive skupiny
    for i:=1 to 10 do
      GRate[i]:=0;
    for i:=1 to GrMax do
    begin
      if (TicketEdit.tiGroup[i,1].TipMatchNumber > 0) then
      begin
        for j:=1 to 4 do
        begin
          if (TicketEdit.tiGroup[i,1].Tip > 0) and (TicketEdit.tiGroup[i,1].Tip < 6) then
          begin
            if (GRate[i] < 1) then GRate[i]:=1;
            GRate[i]:=GRate[i]*TicketEdit.tiGroup[i,1].Tips[TicketEdit.tiGroup[i,1].Tip];
          end;
        end;
        GRate[i]:=GRate[i]*CRate;
      end;
    end;

    // vypocet min a max kurzu pro x-tice
    for i:=1 to GrMax do
    begin
      GRaMn[i]:=1e100;
      GRaMx[i]:=0;
      TiCnt[i]:=0;

      // vytvoreni kurzu pro x-tice
      for j:=1 to 10 do
        if (j <= i) then XXX[j]:=j
                    else XXX[j]:=0;
      repeat
        TiCnt[i]:=TiCnt[i]+1;
        RaTmp[TiCnt[i]]:=1;
        for j:=1 to i do
          RaTmp[TiCnt[i]]:=RaTmp[TiCnt[i]]*GRate[XXX[j]];
      until not GetNextXXX(XXX, i, GrMax);

      // vypocet min a max kurzu
      for j:=1 to TiCnt[i] do
      begin
        if (RaTmp[j] < GRaMn[i]) then GRaMn[i]:=RaTmp[j];
        if (RaTmp[j] > GRaMx[i]) then GRaMx[i]:=RaTmp[j];
        ARate:=ARate+RaTmp[j];
        AWin:=AWin+(emGrBet[i].Value*RaTmp[j]);
      end;
    end;
  end;

  if (GrMax = 0) then
  begin
    for i:=1 to 10 do
      if (i <= 2) then
      begin
        emTiNum[i].Caption:='1';
        emRaMin[i].Caption:=Format('%3.2f', [CRate]);
        emRaMax[i].Caption:=Format('%3.2f', [CRate]);
        emWiMin[i].Caption:=Format('%3.2f', [round(2*emGrBet[i].Value*CRate)/2]);
        emWiMax[i].Caption:=Format('%3.2f', [round(2*emGrBet[i].Value*CRate)/2]);
        emRateG[i].Caption:='';
      end
      else
      begin
        emTiNum[i].Caption:='0';
        emRaMin[i].Caption:='';
        emRaMax[i].Caption:='';
        emWiMin[i].Caption:='';
        emWiMax[i].Caption:='';
        emRateG[i].Caption:='';
      end;

    PanelMoA.Caption:=Format('%d.00', [emGrBet[1].Value]);
    PanelRaA.Caption:=Format('%3.2f', [CRate]);
    PanelWiA.Caption:=Format('%3.2f', [round(2*emGrBet[1].Value*CRate)/2]);
  end
  else
  begin
    for i:=1 to 10 do
      if (i <= GrMax) then
      begin
        emTiNum[i].Caption:=IntToStr(TiCnt[i]);
        emRaMin[i].Caption:=Format('%3.2f', [CRate*GRaMn[i]]);
        emRaMax[i].Caption:=Format('%3.2f', [CRate*GRaMx[i]]);
        emWiMin[i].Caption:=Format('%3.2f', [round(2*emGrBet[i].Value*GRaMn[i])/2]);
        emWiMax[i].Caption:=Format('%3.2f', [round(2*emGrBet[i].Value*GRaMx[i])/2]);
        emRateG[i].Caption:=Format('%3.2f', [GRate[i]]);
      end
      else
      begin
        emTiNum[i].Caption:='0';
        emRaMin[i].Caption:='';
        emRaMax[i].Caption:='';
        emWiMin[i].Caption:='';
        emWiMax[i].Caption:='';
        emRateG[i].Caption:='';
      end;

    PanelMoA.Caption:=Format('%d.00', [emGrBet[1].Value]);
    PanelRaA.Caption:=Format('%3.2f', [ARate]);
    PanelWiA.Caption:=Format('%3.2f', [round(2*AWin)/2]);
  end;
end;

procedure TFormMaxi.FormCreate(Sender: TObject);

  procedure FillConst;
  begin
    emConstA[01]:=PanelA01;
    emConstA[02]:=PanelA02;
    emConstA[03]:=PanelA03;
    emConstA[04]:=PanelA04;
    emConstA[05]:=PanelA05;
    emConstA[06]:=PanelA06;
    emConstA[07]:=PanelA07;
    emConstA[08]:=PanelA08;
    emConstA[09]:=PanelA09;
    emConstA[10]:=PanelA10;
    emConstA[11]:=PanelA11;
    emConstA[12]:=PanelA12;
    emConstA[13]:=PanelA13;
    emConstA[14]:=PanelA14;
    emConstA[15]:=PanelA15;
    emConstA[16]:=PanelA16;
    emConstA[17]:=PanelA17;
    emConstA[18]:=PanelA18;
    emConstA[19]:=PanelA19;
    emConstA[20]:=PanelA20;
    emConstA[21]:=PanelA21;
    emConstA[22]:=PanelA22;
    emConstA[23]:=PanelA23;
    emConstA[24]:=PanelA24;
    emConstA[25]:=PanelA25;
    emConstA[26]:=PanelA26;
    emConstA[27]:=PanelA27;
    emConstA[28]:=PanelA28;
    emConstA[29]:=PanelA29;
    emConstA[30]:=PanelA30;
    emConstA[31]:=PanelA31;
    emConstA[32]:=PanelA32;
    emConstA[33]:=PanelA33;
    emConstA[34]:=PanelA34;
    emConstA[35]:=PanelA35;
    emConstA[36]:=PanelA36;
    emConstA[37]:=PanelA37;
    emConstA[38]:=PanelA38;
    emConstA[39]:=PanelA39;
    emConstA[40]:=PanelA40;

    emConstM[01]:=PanelM01;
    emConstM[02]:=PanelM02;
    emConstM[03]:=PanelM03;
    emConstM[04]:=PanelM04;
    emConstM[05]:=PanelM05;
    emConstM[06]:=PanelM06;
    emConstM[07]:=PanelM07;
    emConstM[08]:=PanelM08;
    emConstM[09]:=PanelM09;
    emConstM[10]:=PanelM10;
    emConstM[11]:=PanelM11;
    emConstM[12]:=PanelM12;
    emConstM[13]:=PanelM13;
    emConstM[14]:=PanelM14;
    emConstM[15]:=PanelM15;
    emConstM[16]:=PanelM16;
    emConstM[17]:=PanelM17;
    emConstM[18]:=PanelM18;
    emConstM[19]:=PanelM19;
    emConstM[20]:=PanelM20;
    emConstM[21]:=PanelM21;
    emConstM[22]:=PanelM22;
    emConstM[23]:=PanelM23;
    emConstM[24]:=PanelM24;
    emConstM[25]:=PanelM25;
    emConstM[26]:=PanelM26;
    emConstM[27]:=PanelM27;
    emConstM[28]:=PanelM28;
    emConstM[29]:=PanelM29;
    emConstM[30]:=PanelM30;
    emConstM[31]:=PanelM31;
    emConstM[32]:=PanelM32;
    emConstM[33]:=PanelM33;
    emConstM[34]:=PanelM34;
    emConstM[35]:=PanelM35;
    emConstM[36]:=PanelM36;
    emConstM[37]:=PanelM37;
    emConstM[38]:=PanelM38;
    emConstM[39]:=PanelM39;
    emConstM[40]:=PanelM40;

    emConstR[01]:=PanelR01;
    emConstR[02]:=PanelR02;
    emConstR[03]:=PanelR03;
    emConstR[04]:=PanelR04;
    emConstR[05]:=PanelR05;
    emConstR[06]:=PanelR06;
    emConstR[07]:=PanelR07;
    emConstR[08]:=PanelR08;
    emConstR[09]:=PanelR09;
    emConstR[10]:=PanelR10;
    emConstR[11]:=PanelR11;
    emConstR[12]:=PanelR12;
    emConstR[13]:=PanelR13;
    emConstR[14]:=PanelR14;
    emConstR[15]:=PanelR15;
    emConstR[16]:=PanelR16;
    emConstR[17]:=PanelR17;
    emConstR[18]:=PanelR18;
    emConstR[19]:=PanelR19;
    emConstR[20]:=PanelR20;
    emConstR[21]:=PanelR21;
    emConstR[22]:=PanelR22;
    emConstR[23]:=PanelR23;
    emConstR[24]:=PanelR24;
    emConstR[25]:=PanelR25;
    emConstR[26]:=PanelR26;
    emConstR[27]:=PanelR27;
    emConstR[28]:=PanelR28;
    emConstR[29]:=PanelR29;
    emConstR[30]:=PanelR30;
    emConstR[31]:=PanelR31;
    emConstR[32]:=PanelR32;
    emConstR[33]:=PanelR33;
    emConstR[34]:=PanelR34;
    emConstR[35]:=PanelR35;
    emConstR[36]:=PanelR36;
    emConstR[37]:=PanelR37;
    emConstR[38]:=PanelR38;
    emConstR[39]:=PanelR39;
    emConstR[40]:=PanelR40;

    emConstB[01,1]:=Button011;
    emConstB[02,1]:=Button021;
    emConstB[03,1]:=Button031;
    emConstB[04,1]:=Button041;
    emConstB[05,1]:=Button051;
    emConstB[06,1]:=Button061;
    emConstB[07,1]:=Button071;
    emConstB[08,1]:=Button081;
    emConstB[09,1]:=Button091;
    emConstB[10,1]:=Button101;
    emConstB[11,1]:=Button111;
    emConstB[12,1]:=Button121;
    emConstB[13,1]:=Button131;
    emConstB[14,1]:=Button141;
    emConstB[15,1]:=Button151;
    emConstB[16,1]:=Button161;
    emConstB[17,1]:=Button171;
    emConstB[18,1]:=Button181;
    emConstB[19,1]:=Button191;
    emConstB[20,1]:=Button201;
    emConstB[21,1]:=Button211;
    emConstB[22,1]:=Button221;
    emConstB[23,1]:=Button231;
    emConstB[24,1]:=Button241;
    emConstB[25,1]:=Button251;
    emConstB[26,1]:=Button261;
    emConstB[27,1]:=Button271;
    emConstB[28,1]:=Button281;
    emConstB[29,1]:=Button291;
    emConstB[30,1]:=Button301;
    emConstB[31,1]:=Button311;
    emConstB[32,1]:=Button321;
    emConstB[33,1]:=Button331;
    emConstB[34,1]:=Button341;
    emConstB[35,1]:=Button351;
    emConstB[36,1]:=Button361;
    emConstB[37,1]:=Button371;
    emConstB[38,1]:=Button381;
    emConstB[39,1]:=Button391;
    emConstB[40,1]:=Button401;

    emConstB[01,2]:=Button012;
    emConstB[02,2]:=Button022;
    emConstB[03,2]:=Button032;
    emConstB[04,2]:=Button042;
    emConstB[05,2]:=Button052;
    emConstB[06,2]:=Button062;
    emConstB[07,2]:=Button072;
    emConstB[08,2]:=Button082;
    emConstB[09,2]:=Button092;
    emConstB[10,2]:=Button102;
    emConstB[11,2]:=Button112;
    emConstB[12,2]:=Button122;
    emConstB[13,2]:=Button132;
    emConstB[14,2]:=Button142;
    emConstB[15,2]:=Button152;
    emConstB[16,2]:=Button162;
    emConstB[17,2]:=Button172;
    emConstB[18,2]:=Button182;
    emConstB[19,2]:=Button192;
    emConstB[20,2]:=Button202;
    emConstB[21,2]:=Button212;
    emConstB[22,2]:=Button222;
    emConstB[23,2]:=Button232;
    emConstB[24,2]:=Button242;
    emConstB[25,2]:=Button252;
    emConstB[26,2]:=Button262;
    emConstB[27,2]:=Button272;
    emConstB[28,2]:=Button282;
    emConstB[29,2]:=Button292;
    emConstB[30,2]:=Button302;
    emConstB[31,2]:=Button312;
    emConstB[32,2]:=Button322;
    emConstB[33,2]:=Button332;
    emConstB[34,2]:=Button342;
    emConstB[35,2]:=Button352;
    emConstB[36,2]:=Button362;
    emConstB[37,2]:=Button372;
    emConstB[38,2]:=Button382;
    emConstB[39,2]:=Button392;
    emConstB[40,2]:=Button402;

    emConstB[01,3]:=Button013;
    emConstB[02,3]:=Button023;
    emConstB[03,3]:=Button033;
    emConstB[04,3]:=Button043;
    emConstB[05,3]:=Button053;
    emConstB[06,3]:=Button063;
    emConstB[07,3]:=Button073;
    emConstB[08,3]:=Button083;
    emConstB[09,3]:=Button093;
    emConstB[10,3]:=Button103;
    emConstB[11,3]:=Button113;
    emConstB[12,3]:=Button123;
    emConstB[13,3]:=Button133;
    emConstB[14,3]:=Button143;
    emConstB[15,3]:=Button153;
    emConstB[16,3]:=Button163;
    emConstB[17,3]:=Button173;
    emConstB[18,3]:=Button183;
    emConstB[19,3]:=Button193;
    emConstB[20,3]:=Button203;
    emConstB[21,3]:=Button213;
    emConstB[22,3]:=Button223;
    emConstB[23,3]:=Button233;
    emConstB[24,3]:=Button243;
    emConstB[25,3]:=Button253;
    emConstB[26,3]:=Button263;
    emConstB[27,3]:=Button273;
    emConstB[28,3]:=Button283;
    emConstB[29,3]:=Button293;
    emConstB[30,3]:=Button303;
    emConstB[31,3]:=Button313;
    emConstB[32,3]:=Button323;
    emConstB[33,3]:=Button333;
    emConstB[34,3]:=Button343;
    emConstB[35,3]:=Button353;
    emConstB[36,3]:=Button363;
    emConstB[37,3]:=Button373;
    emConstB[38,3]:=Button383;
    emConstB[39,3]:=Button393;
    emConstB[40,3]:=Button403;

    emConstB[01,4]:=Button014;
    emConstB[02,4]:=Button024;
    emConstB[03,4]:=Button034;
    emConstB[04,4]:=Button044;
    emConstB[05,4]:=Button054;
    emConstB[06,4]:=Button064;
    emConstB[07,4]:=Button074;
    emConstB[08,4]:=Button084;
    emConstB[09,4]:=Button094;
    emConstB[10,4]:=Button104;
    emConstB[11,4]:=Button114;
    emConstB[12,4]:=Button124;
    emConstB[13,4]:=Button134;
    emConstB[14,4]:=Button144;
    emConstB[15,4]:=Button154;
    emConstB[16,4]:=Button164;
    emConstB[17,4]:=Button174;
    emConstB[18,4]:=Button184;
    emConstB[19,4]:=Button194;
    emConstB[20,4]:=Button204;
    emConstB[21,4]:=Button214;
    emConstB[22,4]:=Button224;
    emConstB[23,4]:=Button234;
    emConstB[24,4]:=Button244;
    emConstB[25,4]:=Button254;
    emConstB[26,4]:=Button264;
    emConstB[27,4]:=Button274;
    emConstB[28,4]:=Button284;
    emConstB[29,4]:=Button294;
    emConstB[30,4]:=Button304;
    emConstB[31,4]:=Button314;
    emConstB[32,4]:=Button324;
    emConstB[33,4]:=Button334;
    emConstB[34,4]:=Button344;
    emConstB[35,4]:=Button354;
    emConstB[36,4]:=Button364;
    emConstB[37,4]:=Button374;
    emConstB[38,4]:=Button384;
    emConstB[39,4]:=Button394;
    emConstB[40,4]:=Button404;

    emConstB[01,5]:=Button015;
    emConstB[02,5]:=Button025;
    emConstB[03,5]:=Button035;
    emConstB[04,5]:=Button045;
    emConstB[05,5]:=Button055;
    emConstB[06,5]:=Button065;
    emConstB[07,5]:=Button075;
    emConstB[08,5]:=Button085;
    emConstB[09,5]:=Button095;
    emConstB[10,5]:=Button105;
    emConstB[11,5]:=Button115;
    emConstB[12,5]:=Button125;
    emConstB[13,5]:=Button135;
    emConstB[14,5]:=Button145;
    emConstB[15,5]:=Button155;
    emConstB[16,5]:=Button165;
    emConstB[17,5]:=Button175;
    emConstB[18,5]:=Button185;
    emConstB[19,5]:=Button195;
    emConstB[20,5]:=Button205;
    emConstB[21,5]:=Button215;
    emConstB[22,5]:=Button225;
    emConstB[23,5]:=Button235;
    emConstB[24,5]:=Button245;
    emConstB[25,5]:=Button255;
    emConstB[26,5]:=Button265;
    emConstB[27,5]:=Button275;
    emConstB[28,5]:=Button285;
    emConstB[29,5]:=Button295;
    emConstB[30,5]:=Button305;
    emConstB[31,5]:=Button315;
    emConstB[32,5]:=Button325;
    emConstB[33,5]:=Button335;
    emConstB[34,5]:=Button345;
    emConstB[35,5]:=Button355;
    emConstB[36,5]:=Button365;
    emConstB[37,5]:=Button375;
    emConstB[38,5]:=Button385;
    emConstB[39,5]:=Button395;
    emConstB[40,5]:=Button405;
  end;

  procedure FillGroup;
  begin
    emGroupA[01]:=PanelGrA;
    emGroupA[02]:=PanelGrB;
    emGroupA[03]:=PanelGrC;
    emGroupA[04]:=PanelGrD;
    emGroupA[05]:=PanelGrE;
    emGroupA[06]:=PanelGrF;
    emGroupA[07]:=PanelGrG;
    emGroupA[08]:=PanelGrH;
    emGroupA[09]:=PanelGrI;
    emGroupA[10]:=PanelGrJ;

    emGroupM[01,1]:=PanelMA1;
    emGroupM[01,2]:=PanelMA2;
    emGroupM[01,3]:=PanelMA3;
    emGroupM[01,4]:=PanelMA4;
    emGroupM[02,1]:=PanelMB1;
    emGroupM[02,2]:=PanelMB2;
    emGroupM[02,3]:=PanelMB3;
    emGroupM[02,4]:=PanelMB4;
    emGroupM[03,1]:=PanelMC1;
    emGroupM[03,2]:=PanelMC2;
    emGroupM[03,3]:=PanelMC3;
    emGroupM[03,4]:=PanelMC4;
    emGroupM[04,1]:=PanelMD1;
    emGroupM[04,2]:=PanelMD2;
    emGroupM[04,3]:=PanelMD3;
    emGroupM[04,4]:=PanelMD4;
    emGroupM[05,1]:=PanelME1;
    emGroupM[05,2]:=PanelME2;
    emGroupM[05,3]:=PanelME3;
    emGroupM[05,4]:=PanelME4;
    emGroupM[06,1]:=PanelMF1;
    emGroupM[06,2]:=PanelMF2;
    emGroupM[06,3]:=PanelMF3;
    emGroupM[06,4]:=PanelMF4;
    emGroupM[07,1]:=PanelMG1;
    emGroupM[07,2]:=PanelMG2;
    emGroupM[07,3]:=PanelMG3;
    emGroupM[07,4]:=PanelMG4;
    emGroupM[08,1]:=PanelMH1;
    emGroupM[08,2]:=PanelMH2;
    emGroupM[08,3]:=PanelMH3;
    emGroupM[08,4]:=PanelMH4;
    emGroupM[09,1]:=PanelMI1;
    emGroupM[09,2]:=PanelMI2;
    emGroupM[09,3]:=PanelMI3;
    emGroupM[09,4]:=PanelMI4;
    emGroupM[10,1]:=PanelMJ1;
    emGroupM[10,2]:=PanelMJ2;
    emGroupM[10,3]:=PanelMJ3;
    emGroupM[10,4]:=PanelMJ4;

    emGroupR[01,1]:=PanelRA1;
    emGroupR[01,2]:=PanelRA2;
    emGroupR[01,3]:=PanelRA3;
    emGroupR[01,4]:=PanelRA4;
    emGroupR[02,1]:=PanelRB1;
    emGroupR[02,2]:=PanelRB2;
    emGroupR[02,3]:=PanelRB3;
    emGroupR[02,4]:=PanelRB4;
    emGroupR[03,1]:=PanelRC1;
    emGroupR[03,2]:=PanelRC2;
    emGroupR[03,3]:=PanelRC3;
    emGroupR[03,4]:=PanelRC4;
    emGroupR[04,1]:=PanelRD1;
    emGroupR[04,2]:=PanelRD2;
    emGroupR[04,3]:=PanelRD3;
    emGroupR[04,4]:=PanelRD4;
    emGroupR[05,1]:=PanelRE1;
    emGroupR[05,2]:=PanelRE2;
    emGroupR[05,3]:=PanelRE3;
    emGroupR[05,4]:=PanelRE4;
    emGroupR[06,1]:=PanelRF1;
    emGroupR[06,2]:=PanelRF2;
    emGroupR[06,3]:=PanelRF3;
    emGroupR[06,4]:=PanelRF4;
    emGroupR[07,1]:=PanelRG1;
    emGroupR[07,2]:=PanelRG2;
    emGroupR[07,3]:=PanelRG3;
    emGroupR[07,4]:=PanelRG4;
    emGroupR[08,1]:=PanelRH1;
    emGroupR[08,2]:=PanelRH2;
    emGroupR[08,3]:=PanelRH3;
    emGroupR[08,4]:=PanelRH4;
    emGroupR[09,1]:=PanelRI1;
    emGroupR[09,2]:=PanelRI2;
    emGroupR[09,3]:=PanelRI3;
    emGroupR[09,4]:=PanelRI4;
    emGroupR[10,1]:=PanelRJ1;
    emGroupR[10,2]:=PanelRJ2;
    emGroupR[10,3]:=PanelRJ3;
    emGroupR[10,4]:=PanelRJ4;

    emGroupB[01,1,1]:=ButtonA11;
    emGroupB[01,2,1]:=ButtonA21;
    emGroupB[01,3,1]:=ButtonA31;
    emGroupB[01,4,1]:=ButtonA41;
    emGroupB[02,1,1]:=ButtonB11;
    emGroupB[02,2,1]:=ButtonB21;
    emGroupB[02,3,1]:=ButtonB31;
    emGroupB[02,4,1]:=ButtonB41;
    emGroupB[03,1,1]:=ButtonC11;
    emGroupB[03,2,1]:=ButtonC21;
    emGroupB[03,3,1]:=ButtonC31;
    emGroupB[03,4,1]:=ButtonC41;
    emGroupB[04,1,1]:=ButtonD11;
    emGroupB[04,2,1]:=ButtonD21;
    emGroupB[04,3,1]:=ButtonD31;
    emGroupB[04,4,1]:=ButtonD41;
    emGroupB[05,1,1]:=ButtonE11;
    emGroupB[05,2,1]:=ButtonE21;
    emGroupB[05,3,1]:=ButtonE31;
    emGroupB[05,4,1]:=ButtonE41;
    emGroupB[06,1,1]:=ButtonF11;
    emGroupB[06,2,1]:=ButtonF21;
    emGroupB[06,3,1]:=ButtonF31;
    emGroupB[06,4,1]:=ButtonF41;
    emGroupB[07,1,1]:=ButtonG11;
    emGroupB[07,2,1]:=ButtonG21;
    emGroupB[07,3,1]:=ButtonG31;
    emGroupB[07,4,1]:=ButtonG41;
    emGroupB[08,1,1]:=ButtonH11;
    emGroupB[08,2,1]:=ButtonH21;
    emGroupB[08,3,1]:=ButtonH31;
    emGroupB[08,4,1]:=ButtonH41;
    emGroupB[09,1,1]:=ButtonI11;
    emGroupB[09,2,1]:=ButtonI21;
    emGroupB[09,3,1]:=ButtonI31;
    emGroupB[09,4,1]:=ButtonI41;
    emGroupB[10,1,1]:=ButtonJ11;
    emGroupB[10,2,1]:=ButtonJ21;
    emGroupB[10,3,1]:=ButtonJ31;
    emGroupB[10,4,1]:=ButtonJ41;

    emGroupB[01,1,2]:=ButtonA12;
    emGroupB[01,2,2]:=ButtonA22;
    emGroupB[01,3,2]:=ButtonA32;
    emGroupB[01,4,2]:=ButtonA42;
    emGroupB[02,1,2]:=ButtonB12;
    emGroupB[02,2,2]:=ButtonB22;
    emGroupB[02,3,2]:=ButtonB32;
    emGroupB[02,4,2]:=ButtonB42;
    emGroupB[03,1,2]:=ButtonC12;
    emGroupB[03,2,2]:=ButtonC22;
    emGroupB[03,3,2]:=ButtonC32;
    emGroupB[03,4,2]:=ButtonC42;
    emGroupB[04,1,2]:=ButtonD12;
    emGroupB[04,2,2]:=ButtonD22;
    emGroupB[04,3,2]:=ButtonD32;
    emGroupB[04,4,2]:=ButtonD42;
    emGroupB[05,1,2]:=ButtonE12;
    emGroupB[05,2,2]:=ButtonE22;
    emGroupB[05,3,2]:=ButtonE32;
    emGroupB[05,4,2]:=ButtonE42;
    emGroupB[06,1,2]:=ButtonF12;
    emGroupB[06,2,2]:=ButtonF22;
    emGroupB[06,3,2]:=ButtonF32;
    emGroupB[06,4,2]:=ButtonF42;
    emGroupB[07,1,2]:=ButtonG12;
    emGroupB[07,2,2]:=ButtonG22;
    emGroupB[07,3,2]:=ButtonG32;
    emGroupB[07,4,2]:=ButtonG42;
    emGroupB[08,1,2]:=ButtonH12;
    emGroupB[08,2,2]:=ButtonH22;
    emGroupB[08,3,2]:=ButtonH32;
    emGroupB[08,4,2]:=ButtonH42;
    emGroupB[09,1,2]:=ButtonI12;
    emGroupB[09,2,2]:=ButtonI22;
    emGroupB[09,3,2]:=ButtonI32;
    emGroupB[09,4,2]:=ButtonI42;
    emGroupB[10,1,2]:=ButtonJ12;
    emGroupB[10,2,2]:=ButtonJ22;
    emGroupB[10,3,2]:=ButtonJ32;
    emGroupB[10,4,2]:=ButtonJ42;

    emGroupB[01,1,3]:=ButtonA13;
    emGroupB[01,2,3]:=ButtonA23;
    emGroupB[01,3,3]:=ButtonA33;
    emGroupB[01,4,3]:=ButtonA43;
    emGroupB[02,1,3]:=ButtonB13;
    emGroupB[02,2,3]:=ButtonB23;
    emGroupB[02,3,3]:=ButtonB33;
    emGroupB[02,4,3]:=ButtonB43;
    emGroupB[03,1,3]:=ButtonC13;
    emGroupB[03,2,3]:=ButtonC23;
    emGroupB[03,3,3]:=ButtonC33;
    emGroupB[03,4,3]:=ButtonC43;
    emGroupB[04,1,3]:=ButtonD13;
    emGroupB[04,2,3]:=ButtonD23;
    emGroupB[04,3,3]:=ButtonD33;
    emGroupB[04,4,3]:=ButtonD43;
    emGroupB[05,1,3]:=ButtonE13;
    emGroupB[05,2,3]:=ButtonE23;
    emGroupB[05,3,3]:=ButtonE33;
    emGroupB[05,4,3]:=ButtonE43;
    emGroupB[06,1,3]:=ButtonF13;
    emGroupB[06,2,3]:=ButtonF23;
    emGroupB[06,3,3]:=ButtonF33;
    emGroupB[06,4,3]:=ButtonF43;
    emGroupB[07,1,3]:=ButtonG13;
    emGroupB[07,2,3]:=ButtonG23;
    emGroupB[07,3,3]:=ButtonG33;
    emGroupB[07,4,3]:=ButtonG43;
    emGroupB[08,1,3]:=ButtonH13;
    emGroupB[08,2,3]:=ButtonH23;
    emGroupB[08,3,3]:=ButtonH33;
    emGroupB[08,4,3]:=ButtonH43;
    emGroupB[09,1,3]:=ButtonI13;
    emGroupB[09,2,3]:=ButtonI23;
    emGroupB[09,3,3]:=ButtonI33;
    emGroupB[09,4,3]:=ButtonI43;
    emGroupB[10,1,3]:=ButtonJ13;
    emGroupB[10,2,3]:=ButtonJ23;
    emGroupB[10,3,3]:=ButtonJ33;
    emGroupB[10,4,3]:=ButtonJ43;

    emGroupB[01,1,4]:=ButtonA14;
    emGroupB[01,2,4]:=ButtonA24;
    emGroupB[01,3,4]:=ButtonA34;
    emGroupB[01,4,4]:=ButtonA44;
    emGroupB[02,1,4]:=ButtonB14;
    emGroupB[02,2,4]:=ButtonB24;
    emGroupB[02,3,4]:=ButtonB34;
    emGroupB[02,4,4]:=ButtonB44;
    emGroupB[03,1,4]:=ButtonC14;
    emGroupB[03,2,4]:=ButtonC24;
    emGroupB[03,3,4]:=ButtonC34;
    emGroupB[03,4,4]:=ButtonC44;
    emGroupB[04,1,4]:=ButtonD14;
    emGroupB[04,2,4]:=ButtonD24;
    emGroupB[04,3,4]:=ButtonD34;
    emGroupB[04,4,4]:=ButtonD44;
    emGroupB[05,1,4]:=ButtonE14;
    emGroupB[05,2,4]:=ButtonE24;
    emGroupB[05,3,4]:=ButtonE34;
    emGroupB[05,4,4]:=ButtonE44;
    emGroupB[06,1,4]:=ButtonF14;
    emGroupB[06,2,4]:=ButtonF24;
    emGroupB[06,3,4]:=ButtonF34;
    emGroupB[06,4,4]:=ButtonF44;
    emGroupB[07,1,4]:=ButtonG14;
    emGroupB[07,2,4]:=ButtonG24;
    emGroupB[07,3,4]:=ButtonG34;
    emGroupB[07,4,4]:=ButtonG44;
    emGroupB[08,1,4]:=ButtonH14;
    emGroupB[08,2,4]:=ButtonH24;
    emGroupB[08,3,4]:=ButtonH34;
    emGroupB[08,4,4]:=ButtonH44;
    emGroupB[09,1,4]:=ButtonI14;
    emGroupB[09,2,4]:=ButtonI24;
    emGroupB[09,3,4]:=ButtonI34;
    emGroupB[09,4,4]:=ButtonI44;
    emGroupB[10,1,4]:=ButtonJ14;
    emGroupB[10,2,4]:=ButtonJ24;
    emGroupB[10,3,4]:=ButtonJ34;
    emGroupB[10,4,4]:=ButtonJ44;

    emGroupB[01,1,5]:=ButtonA15;
    emGroupB[01,2,5]:=ButtonA25;
    emGroupB[01,3,5]:=ButtonA35;
    emGroupB[01,4,5]:=ButtonA45;
    emGroupB[02,1,5]:=ButtonB15;
    emGroupB[02,2,5]:=ButtonB25;
    emGroupB[02,3,5]:=ButtonB35;
    emGroupB[02,4,5]:=ButtonB45;
    emGroupB[03,1,5]:=ButtonC15;
    emGroupB[03,2,5]:=ButtonC25;
    emGroupB[03,3,5]:=ButtonC35;
    emGroupB[03,4,5]:=ButtonC45;
    emGroupB[04,1,5]:=ButtonD15;
    emGroupB[04,2,5]:=ButtonD25;
    emGroupB[04,3,5]:=ButtonD35;
    emGroupB[04,4,5]:=ButtonD45;
    emGroupB[05,1,5]:=ButtonE15;
    emGroupB[05,2,5]:=ButtonE25;
    emGroupB[05,3,5]:=ButtonE35;
    emGroupB[05,4,5]:=ButtonE45;
    emGroupB[06,1,5]:=ButtonF15;
    emGroupB[06,2,5]:=ButtonF25;
    emGroupB[06,3,5]:=ButtonF35;
    emGroupB[06,4,5]:=ButtonF45;
    emGroupB[07,1,5]:=ButtonG15;
    emGroupB[07,2,5]:=ButtonG25;
    emGroupB[07,3,5]:=ButtonG35;
    emGroupB[07,4,5]:=ButtonG45;
    emGroupB[08,1,5]:=ButtonH15;
    emGroupB[08,2,5]:=ButtonH25;
    emGroupB[08,3,5]:=ButtonH35;
    emGroupB[08,4,5]:=ButtonH45;
    emGroupB[09,1,5]:=ButtonI15;
    emGroupB[09,2,5]:=ButtonI25;
    emGroupB[09,3,5]:=ButtonI35;
    emGroupB[09,4,5]:=ButtonI45;
    emGroupB[10,1,5]:=ButtonJ15;
    emGroupB[10,2,5]:=ButtonJ25;
    emGroupB[10,3,5]:=ButtonJ35;
    emGroupB[10,4,5]:=ButtonJ45;
  end;

  procedure FillOther;
  begin
    emGrBet[01]:=EditBe1;
    emGrBet[02]:=EditBe2;
    emGrBet[03]:=EditBe3;
    emGrBet[04]:=EditBe4;
    emGrBet[05]:=EditBe5;
    emGrBet[06]:=EditBe6;
    emGrBet[07]:=EditBe7;
    emGrBet[08]:=EditBe8;
    emGrBet[09]:=EditBe9;
    emGrBet[10]:=EditBe0;

    emTiNum[01]:=PanelTi1;
    emTiNum[02]:=PanelTi2;
    emTiNum[03]:=PanelTi3;
    emTiNum[04]:=PanelTi4;
    emTiNum[05]:=PanelTi5;
    emTiNum[06]:=PanelTi6;
    emTiNum[07]:=PanelTi7;
    emTiNum[08]:=PanelTi8;
    emTiNum[09]:=PanelTi9;
    emTiNum[10]:=PanelTi0;

    emRaMin[01]:=PanelRM1;
    emRaMin[02]:=PanelRM2;
    emRaMin[03]:=PanelRM3;
    emRaMin[04]:=PanelRM4;
    emRaMin[05]:=PanelRM5;
    emRaMin[06]:=PanelRM6;
    emRaMin[07]:=PanelRM7;
    emRaMin[08]:=PanelRM8;
    emRaMin[09]:=PanelRM9;
    emRaMin[10]:=PanelRM0;

    emRaMax[01]:=PanelRX1;
    emRaMax[02]:=PanelRX2;
    emRaMax[03]:=PanelRX3;
    emRaMax[04]:=PanelRX4;
    emRaMax[05]:=PanelRX5;
    emRaMax[06]:=PanelRX6;
    emRaMax[07]:=PanelRX7;
    emRaMax[08]:=PanelRX8;
    emRaMax[09]:=PanelRX9;
    emRaMax[10]:=PanelRX0;

    emWiMin[01]:=PanelWM1;
    emWiMin[02]:=PanelWM2;
    emWiMin[03]:=PanelWM3;
    emWiMin[04]:=PanelWM4;
    emWiMin[05]:=PanelWM5;
    emWiMin[06]:=PanelWM6;
    emWiMin[07]:=PanelWM7;
    emWiMin[08]:=PanelWM8;
    emWiMin[09]:=PanelWM9;
    emWiMin[10]:=PanelWM0;

    emWiMax[01]:=PanelWX1;
    emWiMax[02]:=PanelWX2;
    emWiMax[03]:=PanelWX3;
    emWiMax[04]:=PanelWX4;
    emWiMax[05]:=PanelWX5;
    emWiMax[06]:=PanelWX6;
    emWiMax[07]:=PanelWX7;
    emWiMax[08]:=PanelWX8;
    emWiMax[09]:=PanelWX9;
    emWiMax[10]:=PanelWX0;

    emRateG[01]:=PanelSRA;
    emRateG[02]:=PanelSRB;
    emRateG[03]:=PanelSRC;
    emRateG[04]:=PanelSRD;
    emRateG[05]:=PanelSRE;
    emRateG[06]:=PanelSRF;
    emRateG[07]:=PanelSRG;
    emRateG[08]:=PanelSRH;
    emRateG[09]:=PanelSRI;
    emRateG[10]:=PanelSRJ;
  end;

begin
  FillConst;
  FillGroup;
  FillOther;
end;

procedure TFormMaxi.FormShow(Sender: TObject);
begin
  DisplayAllMatchs;
  DisplayAllStatistic;
end;

procedure TFormMaxi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//
end;

procedure TFormMaxi.EditIntKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Key < '0') or (Key > '9')) and (Key <> #8) and (Key <> #13) then Key:=#0;
end;

procedure TFormMaxi.EditRealKeyPress(Sender: TObject; var Key: Char);
begin
  if ((Key < '0') or (Key > '9')) and (Key <> '.') and (Key <> #8) and (Key <> #13) then Key:=#0;
end;

end.
