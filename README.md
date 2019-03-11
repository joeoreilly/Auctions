#  Auctions 

## Shortcuts taken

- I've not added tests for anything that touches the network but I've added a protocol `Networking` to simplify mocking out `Network` later
- I've used a really simple approach for Dependancy Injection with a globally scoped instance of a `Dependancies` struct
- I've implemented a `UISplitViewController` but there are some nuiances with rotation in compact horizontal environments where the detail view gets presented without a `UINavigationController` and the display mode button isn't visible. 
