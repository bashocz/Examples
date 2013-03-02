unit CompilerUnits;

interface


uses
  Windows, SysUtils, Variants, Classes, Controls,
  Dialogs, ComCtrls;



type
  TDDPEL_UnitVector = array of Word;
  TDDPEL_UnitCommand = array of Word;



  TDDPEL_CommandFrame = class (TObject)
  end;


  TDDPEL_PAtternFrame = class(TObject)
  end;

  TDDPEL_TimesetFrame = class(TObject)
  end;


  TDDPEL_Pattern  = class(TObject)
  private
    FCommandList    :TList;
    FDataList       :TList;


  public

  end;

implementation

end.
