/// <summary>
/// Enum OperationInterface (ID 50000).
/// </summary>
/// <steps>Steps to add new operation
/// <step No="1">Add new enum with Caption.</step>
/// <step No="2">Implement new codeunit from IOperation.</step>
/// <step No="3">Be sure GetSymbol is returning correct symbol.</step>
/// </steps>

enum 50000 "IOperationInterface" implements IOperation
{
    Extensible = true;
    UnknownValueImplementation = IOperation = "Operation-Addition";

    value(0; Unassigned)
    {
        Caption = ' ';
        Implementation = IOperation = "Operation-Unassigned";
    }
    value(1; Constant)
    {
        Caption = 'Constant';
        Implementation = IOperation = OperationConstant;
    }
    value(2; Addition)
    {
        Caption = 'Addition';
        Implementation = IOperation = "Operation-Addition";
    }
    value(3; Subtraction)
    {
        Caption = 'Subtraction';
        Implementation = IOperation = "Operation-Subtraction";
    }
    value(4; Multiplication)
    {
        Caption = 'Multiplication';
        Implementation = IOperation = "Operation-Multiplication";
    }
    value(5; Division)
    {
        Caption = 'Division';
        Implementation = IOperation = "Operation-Division";
    }
    value(6; Exponentiation)
    {
        Caption = 'Exponentiation';
        Implementation = IOperation = "Operation-Exponentiation";
    }
    value(7; Equality)
    {
        Caption = 'Equality';
        Implementation = IOperation = "Operation-Equality";
    }
}
