
/// <summary>
/// Codeunit Operation-"Constant" (ID 50004) implements Interface IOperation.
/// </summary>
codeunit 50004 "OperationConstant" implements IOperation
{
    /// <summary>
    /// New.
    /// </summary>
    /// <param name="NewVariant">Variant.</param>
    /// <returns>Return value of type Codeunit Constant.</returns>
    procedure New(NewVariant: Variant): Codeunit OperationConstant;
    var
        OperationConstant: Codeunit OperationConstant;
        ResultVariant: Variant;
        Success: Boolean;
    begin
        If NewVariant.IsText() then begin
            Success := false;
            if not Success then
                ResultVariant := AsInteger(NewVariant, Success);
            if not Success then
                ResultVariant := AsDecimal(NewVariant, Success);
            if not Success then
                ResultVariant := AsBoolean(NewVariant, Success);
            if not Success then
                Error('Cannot validate name %1.', NewVariant);
        end;
        OperationConstant.Set(ResultVariant);
        exit(OperationConstant);
    end;
    /// <summary>
    /// Calculate.
    /// </summary>
    /// <returns>Return value of type Variant.</returns>
    procedure Calculate(): Variant;
    begin
        exit(ConstantVariant);
    end;

    /// <summary>
    /// GetSymbol.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetSymbol(): Text;
    begin
        exit(format(ConstantVariant));
    end;

    /// <summary>
    /// GetPriority.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetPriority(): Integer;
    begin
        exit(0);
    end;

    /// <summary>
    /// AsJson.
    /// </summary>
    /// <returns>Return value of type JsonToken.</returns>
    procedure AsJson(): JsonToken;
    var
        JsonObject: JsonObject;
    begin
        JsonObject.Add('constant', format(GetType()));
        JsonObject.Add('value', format(ConstantVariant, 0, 9));
        exit(JsonObject.AsToken());
    end;

    /// <summary>
    /// SetLeftAtom.
    /// </summary>
    /// <param name="NewAtom">interface IOperation.</param>
    procedure SetLeft(NewAtom: interface IOperation)
    begin
        Error('Constants should not have atoms.');
    end;

    /// <summary>
    /// SetRightAtom.
    /// </summary>
    /// <param name="NewAtom">interface IOperation.</param>
    procedure SetRight(NewAtom: interface IOperation)
    begin
        Error('Constants should not have atoms.');
    end;

    /// <summary>
    /// SetConstant.
    /// </summary>
    /// <param name="NewVariant">Variant.</param>
    procedure Set(NewVariant: Variant)
    begin
        ConstantVariant := NewVariant;
    end;

    /// <summary>
    /// GetType.
    /// </summary>
    /// <returns>Return value of type FieldType.</returns>
    procedure GetType(): Text
    begin
        case true of
            ConstantVariant.IsInteger():
                exit('Integer');
            ConstantVariant.IsDecimal():
                exit('Decimal');
            ConstantVariant.IsText():
                exit('Text');
            ConstantVariant.IsBoolean():
                exit('Boolean');
            ConstantVariant.IsDate():
                exit('Date');
            ConstantVariant.IsTime():
                exit('Time');
            ConstantVariant.IsDateTime():
                exit('Date Time');

            ConstantVariant.IsBigInteger():
                exit('Big Integer');
            ConstantVariant.IsBinary():
                exit('Binary');
            ConstantVariant.IsByte():
                exit('Byte');
            ConstantVariant.IsChar():
                exit('Char');
            ConstantVariant.IsCode():
                exit('Code');
            ConstantVariant.IsDateFormula():
                exit('Date Formula');
            ConstantVariant.IsDotNet():
                exit('Dot Net');
            ConstantVariant.IsDuration():
                exit('Duration');
            ConstantVariant.IsGuid():
                exit('Guid');
            ConstantVariant.IsOption():
                exit('Option');
            ConstantVariant.IsWideChar:
                exit('Wide Char');
        end;
    end;

    /// <summary>
    /// IsNull.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsNull(): Boolean;
    begin
        exit(false);
    end;

    local procedure AsInteger(VariantValue: Variant; var Success: Boolean) Result: Integer
    begin
        Success := Evaluate(Result, VariantValue);
    end;

    local procedure AsDecimal(VariantValue: Variant; var Success: Boolean) Result: Decimal
    begin
        Success := Evaluate(Result, VariantValue);
    end;

    local procedure AsBoolean(VariantValue: Variant; var Success: Boolean) Result: Boolean
    begin
        Success := Evaluate(Result, VariantValue);
    end;

    var
        ConstantVariant: Variant;
}
