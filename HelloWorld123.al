// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    begin
        Message('App published: Test  111 999999');
        // This is my new change.
        // Change from remote.
    end;

    trigger OnAfterGetRecord();
    begin
        Message('Changed.');
        // This is my new change.
    end;
}
