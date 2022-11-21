/// <summary>
/// Codeunit OperationMinus (ID 50001) implements Interface IOperation.
/// </summary>
codeunit 50003 "Operation-Unassigned" implements IOperation
{
    /// <summary>
    /// New.
    /// </summary>
    /// <param name="NewError">Text.</param>
    /// <returns>Return variable Result of type codeunit "Operation-Unassigned".</returns>
    procedure New(NewError: Text) Result: codeunit "Operation-Unassigned";
    begin
        Result.SetError(NewError);
    end;

    /// <summary>
    /// SetError.
    /// </summary>
    /// <param name="NewError">Text.</param>
    procedure SetError(NewError: Text)
    begin
        LastError := NewError;
    end;
    /// <summary>
    /// Calculate.
    /// </summary>
    /// <returns>Return value of type Variant.</returns>
    procedure Calculate(): Variant;
    begin
        IF LastError <> '' then
            Error(LastError)
        else
            Error('Value or operation is not assigned.');
    end;

    /// <summary>
    /// GetSymbol.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetSymbol(): Text;
    begin
        exit('ERROR');
    end;

    /// <summary>
    /// GetPriority.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetPriority(): Integer;
    begin
        exit(-1);
    end;



    /// <summary>
    /// SetLeftAtom.
    /// </summary>
    /// <param name="NewAtom">interface IOperation.</param>
    procedure SetLeft(NewAtom: interface IOperation)
    begin
        Error('Value or operation is not assigned.');
    end;

    /// <summary>
    /// SetRightAtom.
    /// </summary>
    /// <param name="NewAtom">interface IOperation.</param>
    procedure SetRight(NewAtom: interface IOperation)
    begin
        Error('Value or operation is not assigned.');
    end;

    /// <summary>
    /// GetType.
    /// </summary>
    /// <returns>Return value of type FieldType.</returns>
    procedure GetType(): Text;
    begin
        Error('Value or operation is not assigned.');
    end;

    /// <summary>
    /// IsNull.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsNull(): Boolean;
    begin
        exit(true);
    end;

    /// <summary>
    /// AsJson.
    /// </summary>
    /// <returns>Return value of type JsonToken.</returns>
    procedure AsJson(): JsonToken
    var
        JsonObject: JsonObject;
    begin
        JsonObject.Add('Error', LastError);
        exit(JsonObject.AsToken());
    end;

    var
        LastError: Text;
}
