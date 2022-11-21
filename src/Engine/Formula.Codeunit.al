/// <summary>
/// Codeunit Formula helps create a tree relations between operators and operands or constants.
/// </summary>
codeunit 50000 "Formula"
{
    /// <summary>
    /// Parse: Use this function to build a tree from expression. Use IOperation.Calculate() to return value of expression or IOperation.
    /// </summary>
    /// <param name="TextExpression">Text: Expression to evaluate from.</param>
    /// <returns>Return value is of IOperation represents a first node from mathematical tree of expression.</returns>
    procedure Parse(TextExpression: Text) Result: Interface IOperation
    var
        OperationUnassigned: Codeunit "Operation-Unassigned";
    begin
        Expression := Expression.New(TextExpression);
        if not TryParse(Result) then
            Result := OperationUnassigned.New(GetLastErrorText());
    end;

    [TryFunction]
    local procedure TryParse(var Result: Interface IOperation)
    begin
        Result := Parse(ParsePrimary(), 0);
    end;

    local procedure ParsePrimary(): Interface IOperation
    var
        OperationConstant: Codeunit OperationConstant;
        LookAhead, Operator : Text;
        LeftAtom, RightAtom : Interface IOperation;
    begin
        LeftAtom := ParseParenthesis(IOperationInterface::Unassigned);
        if not LeftAtom.IsNull() then
            exit(LeftAtom);
        LookAhead := Expression.GetNextToken();
        if Expression.IsNotEmpty(LookAhead) and (Expression.Priority(LookAhead) > 0) then begin
            Operator := LookAhead;
            Expression.AdvanceToNextToken(LookAhead);
            RightAtom := ParsePrimary();
            LeftAtom := CreateOperation(Operator, OperationConstant.New(0), RightAtom);
        end else begin
            LeftAtom := OperationConstant.New(LookAhead);
            Expression.AdvanceToNextToken(LookAhead);
        end;
        exit(LeftAtom);
    end;

    local procedure Parse(LeftAtom: Interface IOperation; MinPrecedence: Integer): Interface IOperation
    var
        LookAhead, Operator : Text;
        RightAtom: Interface IOperation;
    begin
        LeftAtom := ParseParenthesis(LeftAtom);
        LookAhead := Expression.GetNextToken();
        while Expression.IsNotEmpty(LookAhead) and (Expression.Priority(LookAhead) >= MinPrecedence) do begin
            Operator := LookAhead;
            If Expression.IsClosingParenthesis(Operator) then
                exit(LeftAtom);
            Expression.AdvanceToNextToken(LookAhead);
            RightAtom := ParsePrimary();
            LookAhead := Expression.GetNextToken();
            while Expression.IsNotEmpty(LookAhead) and (Expression.Priority(Operator) < Expression.Priority(LookAhead)) do begin
                RightAtom := Parse(RightAtom, Expression.Priority(Operator));
                LookAhead := Expression.GetNextToken();
            end;
            LeftAtom := CreateOperation(Operator, LeftAtom, RightAtom);
        end;
        exit(LeftAtom);
    end;

    local procedure ParseParenthesis(LeftAtom: Interface IOperation): Interface IOperation
    var
        LookAhead, ExpectedClosingToken : Text;
        RightAtom: Interface IOperation;
        ClosingErr: Label 'Expecting %1 closing bracket.', Comment = '%1 closing bracket sign.';
    begin
        LookAhead := Expression.GetNextToken();
        If Expression.IsParenthesis(LookAhead) <> '' then begin
            ExpectedClosingToken := Expression.IsParenthesis(LookAhead);
            Expression.AdvanceToNextToken(LookAhead);
            RightAtom := Parse(ParsePrimary(), 0);
            LookAhead := Expression.GetNextToken();
            while LookAhead = ',' do begin
                Expression.AdvanceToNextToken(LookAhead);
                //RightAtom := RightAtom + ',' + Parse(ParsePrimary(), 0); //We need function implementation
                LookAhead := Expression.GetNextToken();
            end;
            if LookAhead <> ExpectedClosingToken then
                Error(Expression.GetErrorMessage(StrSubstNo(ClosingErr, ExpectedClosingToken)));
            Expression.AdvanceToNextToken(LookAhead);
            if (LeftAtom.IsNull()) then
                exit(RightAtom);
            //if (LeftAtom.IsFunction()) then //We need function implementation
            //    exit(LeftAtom + '(' + RightAtom + ')') //We need function implementation
            // else //We need function implementation
            exit(CreateOperation('*', LeftAtom, RightAtom));
        end;
        exit(LeftAtom);
    end;

    local procedure CreateOperation(Operator: Text; LeftValue: Interface IOperation; RightValue: Interface IOperation): Interface IOperation
    var
        IOperationManagement: Codeunit IOperationManagement;
        IOperation: Interface IOperation;
        NotImplementedErr: Label 'Operation %1 is not implemented.', Comment = '%1: label';
    begin
        IOperation := IOperationManagement.New(Operator);
        if IOperation.GetSymbol() = 'ERROR' then
            Error(Expression.GetErrorMessage(StrSubstNo(NotImplementedErr, Operator)));
        IOperation.SetLeft(LeftValue);
        IOperation.SetRight(RightValue);
        exit(IOperation);
    end;

    var
        Expression: Codeunit Expression;
}
