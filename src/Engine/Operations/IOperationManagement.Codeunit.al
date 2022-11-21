/// <summary>
/// Codeunit IOperationManagement (ID 50010).
/// </summary>
codeunit 50010 IOperationManagement
{

    /// <summary>
    /// Constructor for IOperation Interface.
    /// </summary>
    /// <param name="Operation">Text.</param>
    /// <returns>Return value of type Interface IOperation.</returns>
    procedure New(Operation: Text): Interface IOperation
    var
        i: Integer;
        IOperation: Interface IOperation;
        IOperationInterface: Enum IOperationInterface;
    begin
        foreach i in IOperationInterface.Ordinals() do begin
            IOperation := Enum::IOperationInterface.FromInteger(i);
            if IOperation.GetSymbol() = Operation then
                exit(IOperation);
        end;
        exit(IOperationInterface::Unassigned);
    end;

    /// <summary>
    /// GetPriority.
    /// </summary>
    /// <param name="Operation">Text.</param>
    /// <returns>Return value of type Integer.</returns>
    procedure GetPriority(Operation: Text): Integer
    var
        i: Integer;
        IOperation: Interface IOperation;
        IOperationInterface: Enum IOperationInterface;
    begin
        foreach i in IOperationInterface.Ordinals() do begin
            IOperation := Enum::IOperationInterface.FromInteger(i);
            if IOperation.GetSymbol() = Operation then
                exit(IOperation.GetPriority());
        end;
        exit(0);
    end;

}
