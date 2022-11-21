/// <summary>
/// Codeunit Expression helps parsing expression into atoms and operations.
/// </summary>
codeunit 50007 "Expression"
{
    /// <summary>
    /// Creates new instance of Expression codeunit and sets the internal variable to NewExpression.
    /// </summary>
    /// <param name="NewExpression">Text.</param>
    /// <returns>Return variable Result of type Codeunit Expression.</returns>
    procedure New(NewExpression: Text) Result: Codeunit Expression
    begin
        Result.SetExpression(NewExpression);
    end;

    /// <summary>
    /// SetExpression sets Expression to new value.
    /// </summary>
    /// <param name="NewExpression">Text.</param>
    procedure SetExpression(NewExpression: Text)
    begin
        Expression := NewExpression;
        CompleteExpression := NewExpression;
        Position := 1;
    end;

    /// <summary>
    /// GetNextToken calculates next token in expression.
    /// </summary>
    /// <returns>Return variable Token of type Text.</returns>
    procedure GetNextToken() Token: Text
    var
        i: Integer;
        IsAtom: Boolean;
        LastOperation: Text;
    begin
        i := 0;
        if Expression <> '' then begin
            IsAtom := IsAlfaNumeric(Expression[1]);
            while i < StrLen(Expression) do begin
                if IsAtom <> IsAlfaNumeric(Expression[i + 1]) then begin
                    if not IsAtom then begin
                        If LastOperation <> '' then
                            Token := LastOperation
                    end else
                        Token := CopyStr(Expression, 1, i);
                    exit;
                end;
                if not IsAtom then begin
                    Token := CopyStr(Expression, 1, i + 1);
                    if Priority(Token) <> 0 then
                        LastOperation := Token;
                end;
                i += 1;
            end;
        end;
        if not IsAtom then
            Token := LastOperation
        else
            Token := CopyStr(Expression, 1, i);
        exit;
    end;

    /// <summary>
    /// AdvanceToNextToken skips to next token part of Expression.
    /// </summary>
    /// <param name="Token">Text.</param>
    procedure AdvanceToNextToken(Token: Text)
    var
        TokenLen: Integer;
    begin
        TokenLen := StrLen(Token);
        Expression := CopyStr(Expression, TokenLen + 1);
        Position += TokenLen;
    end;

    /// <summary>
    /// GetErrorMessage.
    /// </summary>
    /// <param name="PassingErrorText">Text.</param>
    /// <returns>Return value of type Text.</returns>
    procedure GetErrorMessage(PassingErrorText: Text): Text
    var
        ErrorMsg: Label 'Expression: "%1" has error at position %2.\Error: %3', Comment = '%1: expression, %2: position, %3: error message.';
    begin
        exit(StrSubstNo(ErrorMsg, CompleteExpression, Position, PassingErrorText));
    end;

    /// <summary>
    /// IsAlfa.
    /// </summary>
    /// <param name="char">Char.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsAlfa(char: Char): Boolean
    begin
        exit(
            ((char >= 'a') and (char <= 'z')) // lower alfa
            or ((char >= 'A') and (char <= 'Z')) // upper alfa
        );
    end;

    local procedure IsAlfaNumeric(char: Char): Boolean
    begin
        exit(
            ((char >= '0') and (char <= '9')) // numeric
            or ((char >= 'a') and (char <= 'z')) // lower alfa
            or ((char >= 'A') and (char <= 'Z')) // upper alfa
            or (char in ['.', ':']) // constant delimiters
        );
    end;

    /// <summary>
    /// IsParenthesis.
    /// </summary>
    /// <param name="Token">Text.</param>
    /// <returns>Return value of type Text.</returns>
    procedure IsParenthesis(Token: Text): Text
    begin
        case Token of
            '(':
                exit(')');
            '[':
                exit(']');
            '{':
                exit('}');
        end;
        exit('');
    end;

    /// <summary>
    /// IsClosingParenthesis.
    /// </summary>
    /// <param name="Token">Text.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsClosingParenthesis(Token: Text): Boolean
    begin
        exit(Token in [')', ']', '}']);
    end;

    /// <summary>
    /// Priority.
    /// </summary>
    /// <param name="Token">Text.</param>
    /// <returns>Return value of type Integer.</returns>
    procedure Priority(Token: Text): Integer
    var
        IOperationManagement: Codeunit IOperationManagement;
        Result: Integer;
    begin
        Result := IOperationManagement.GetPriority(Token);
        if Result > 0 then
            exit(Result);
        case Token of
            '(':
                exit(5);
            ')', ',':
                exit(-1);
            else
                exit(0);
        end;
    end;

    /// <summary>
    /// IsNotEmpty.
    /// </summary>
    /// <param name="Token">Text.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsNotEmpty(Token: Text): Boolean
    begin
        exit(Token <> '');
    end;

    /// <summary>
    /// IsFunction.
    /// </summary>
    /// <param name="FunctionName">Text.</param>
    /// <returns>Return value of type Boolean.</returns>
    procedure IsFunction(FunctionName: Text): Boolean
    begin
        if FunctionName = '' then
            exit(false);
        exit(IsAlfa(FunctionName[1]));
    end;

    var
        Expression: Text;
        CompleteExpression: Text;
        Position: Integer;
}
