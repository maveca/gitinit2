// Welcome to your new AL extension.
// Remember that object names and IDs should be unique across all extensions.
// AL snippets start with t*, like tpageext - give them a try and happy coding!

pageextension 50100 CustomerListExt extends "Customer List"
{
    trigger OnOpenPage();
    begin
<<<<<<< HEAD:HelloWorld123.al
        Message('App published: Hello world');
=======
        Message('App published: Hello world - 123');
>>>>>>> parent of 8cb8a32 (Add message to HelloWorld):HelloWorld.al
    end;
}