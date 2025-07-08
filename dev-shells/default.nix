rec {
  default = {
    path = ./empty;
    description = "Empty development environment";
  };
  csharp = {
    path = ./csharp;
    description = "C# development environment";
  };
  empty = {
    path = ./empty;
    description = "Empty dev template that you can customize at will";
  };
  nix = {
    path = ./nix;
    description = "Nix development environment";
  };
  node = {
    path = ./node;
    description = "Node.js development environment";
  };
  python = {
    path = ./python;
    description = "Python development environment";
  };
}
