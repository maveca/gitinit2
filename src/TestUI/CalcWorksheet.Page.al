/// <summary>
/// Page Calc Worksheet (ID 50100).
/// </summary>
page 50000 "Calc Worksheet"
{
    Caption = 'Calc Worksheet 123';
    PageType = Card;
    UsageCategory = Tasks;
    ApplicationArea = All;
    layout
    {
        area(content)
        {
            group(General)
            {
                ShowCaption = false;

                group(Calculation)
                {
                    Caption = 'Calculation';
                    ShowCaption = false;
                    field(InputControl; Input)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Input field.';
                        Caption = 'Input';
                        MultiLine = true;
                    }
                    field(OutputControl; Output)
                    {
                        ApplicationArea = All;
                        ToolTip = 'Specifies the value of the Output field.';
                        Caption = 'Output';
                        Editable = false;
                        MultiLine = true;
                    }
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(RunCalculate)
            {
                ApplicationArea = All;
                Caption = 'Calculate';
                ToolTip = 'Executes the RunCalculate action.';
                Image = Calculate;
                InFooterBar = true;
                ShortcutKey = 'F9';

                trigger OnAction()
                begin
                    Calculate();
                end;
            }

            action(JsonTree)
            {
                ApplicationArea = All;
                Caption = 'Json Tree';
                ToolTip = 'Shows Json Tree interpretation of Input.';
                Image = XMLFile;

                trigger OnAction()
                begin
                    JsonExpression();
                end;
            }

            action(TestAction)
            {
                ApplicationArea = All;
                Caption = 'Test';
                ToolTip = 'Gives simple test option.';
                Image = TaxSetup;

                trigger OnAction()
                begin
                    Test();
                end;
            }

        }
    }
    var
        Input: Text;
        Output: Text;

    trigger OnInit()
    begin
        Input := '3+4';
    end;

    local procedure Calculate()
    var
        Formula: Codeunit Formula;
    begin
        Output := format(Formula.Parse(Input).Calculate());
    end;

    local procedure JsonExpression()
    var
        Formula: Codeunit Formula;
    begin
        Formula.Parse(Input).AsJson().WriteTo(Output);
    end;

    local procedure Test()
    var
        IOperationManagement: Codeunit IOperationManagement;
    begin
        Message('%1', IOperationManagement.New('+').GetSymbol());
    end;
}
