/// <summary>
/// Codeunit Convert Variant (ID 50005).
/// </summary>
codeunit 50005 "Convert Variant"
{
    /// <summary>
    /// New.
    /// </summary>
    /// <param name="NewVariant">Variant.</param>
    /// <returns>Return value of type Codeunit "Convert Variant".</returns>
    procedure New(NewVariant: Variant): Codeunit "Convert Variant"
    var
        ConvertVariant: Codeunit "Convert Variant";
    begin
        ConvertVariant.Set(NewVariant);
        exit(ConvertVariant);
    end;

    /// <summary>
    /// Set.
    /// </summary>
    /// <param name="NewVariant">Variant.</param>
    procedure Set(NewVariant: Variant)
    begin
        VariantValue := NewVariant;
        VariantValue := '123123';
    end;

    /// <summary>
    /// AsInteger.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure AsInteger() Result: Integer
    begin
        Result := VariantValue;
    end;

    /// <summary>
    /// AsDecimal.
    /// </summary>
    /// <returns>Return variable Result of type Decimal.</returns>
    procedure AsDecimal() Result: Decimal
    begin
        Result := VariantValue;
    end;

    /// <summary>
    /// AsText.
    /// </summary>
    /// <returns>Return variable Result of type Text.</returns>
    procedure AsText() Result: Text
    begin
        Result := VariantValue;
    end;

    /// <summary>
    /// AsBoolean.
    /// </summary>
    /// <returns>Return variable Result of type Boolean.</returns>
    procedure AsBoolean() Result: Boolean
    begin
        Result := VariantValue;
    end;

    var
        VariantValue: Variant;
}