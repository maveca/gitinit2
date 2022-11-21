/// <summary>
/// Codeunit OperationMinus (ID 50001) implements Interface IOperation.
/// </summary>
codeunit 50011 "Operation-Equality" implements IOperation
{
    /// <summary>
    /// Calculate.
    /// </summary>
    /// <returns>Return value of type Variant.</returns>
    procedure Calculate(): Variant;
    var
        ConvertVariant: Codeunit "Convert Variant";
        OperationConstant: Codeunit OperationConstant;
        LeftVariant, RightVariant : Variant;
        TypeErr: Label 'Cannot make operation %3 on type %1 over %2.', Comment = '%1: left operand, %2: right operand, %3: operation';
    begin
        LeftVariant := LeftAtom.Calculate();
        RightVariant := RightAtom.Calculate();
        case true of
            LeftVariant.IsBoolean() and RightVariant.IsBoolean():
                exit(ConvertVariant.New(LeftVariant).AsBoolean() = ConvertVariant.New(RightVariant).AsBoolean());
            LeftVariant.IsInteger() and RightVariant.IsInteger():
                exit(ConvertVariant.New(LeftVariant).AsInteger() = ConvertVariant.New(RightVariant).AsInteger());
            LeftVariant.IsInteger() and RightVariant.IsDecimal():
                exit(ConvertVariant.New(LeftVariant).AsInteger() = ConvertVariant.New(RightVariant).AsDecimal());
            LeftVariant.IsDecimal() and RightVariant.IsInteger():
                exit(ConvertVariant.New(LeftVariant).AsDecimal() = ConvertVariant.New(RightVariant).AsInteger());
            LeftVariant.IsDecimal() and RightVariant.IsDecimal():
                exit(ConvertVariant.New(LeftVariant).AsDecimal() = ConvertVariant.New(RightVariant).AsDecimal());
            else
                Error(TypeErr, OperationConstant.New(LeftVariant).GetType(), OperationConstant.New(RightVariant).GetType(), GetSymbol());
        end;
    end;

    /// <summary>
    /// GetSymbol.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetSymbol(): Text;
    begin
        exit('=');
    end;

    /// <summary>
    /// GetPriority.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetPriority(): Integer;
    begin
        exit(1);
    end;

    /// <summary>
    /// AsJson.
    /// </summary>
    /// <returns>Return value of type JsonToken.</returns>
    procedure AsJson(): JsonToken;
    var
        JsonObject: JsonObject;
    begin
        JsonObject.Add('operation', GetSymbol());
        JsonObject.Add('leftAtom', LeftAtom.AsJson());
        JsonObject.Add('rightAtom', RightAtom.AsJson());
        exit(JsonObject.AsToken());
    end;

    /// <summary>
    /// SetLeftAtom.
    /// </summary>
    /// <param name="NewAtom">interface IOperation.</param>
    procedure SetLeft(NewAtom: interface IOperation)
    begin
        LeftAtom := NewAtom;
    end;

    /// <summary>
    /// SetRightAtom.
    /// </summary>
    /// <param name="NewAtom">interface IOperation.</param>
    procedure SetRight(NewAtom: interface IOperation)
    begin
        RightAtom := NewAtom;
    end;

    /// <summary>
    /// IsNull.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsNull(): Boolean;
    begin
        exit(false);
    end;

    var
        LeftAtom: interface IOperation;
        RightAtom: interface IOperation;
}
