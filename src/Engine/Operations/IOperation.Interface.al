/// <summary>
/// Interface IOperation.
/// </summary>
interface "IOperation"
{
    /// <summary>
    /// Calculate.
    /// </summary>
    /// <returns>Return value of type Variant.</returns>
    procedure Calculate(): Variant;

    /// <summary>
    /// GetMethodName.
    /// </summary>
    /// <returns>Return value of type Text.</returns>
    procedure GetSymbol(): Text;

    /// <summary>
    /// GetPriority.
    /// </summary>
    /// <returns>Return value of type Integer.</returns>
    procedure GetPriority(): Integer;

    /// <summary>
    /// AsJson.
    /// </summary>
    /// <returns>Return value of type JsonToken.</returns>
    procedure AsJson(): JsonToken;

    /// <summary>
    /// SetLeftAtom.
    /// </summary>
    /// <param name="NewAtom">interface IOperation.</param>
    procedure SetLeft(NewAtom: interface IOperation)

    /// <summary>
    /// SetRightAtom.
    /// </summary>
    /// <param name="NewAtom">interface IOperation.</param>
    procedure SetRight(NewAtom: interface IOperation)

    /// <summary>
    /// IsNull.
    /// </summary>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsNull(): Boolean;
}