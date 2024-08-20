{
  config,
  lib,
  dream2nix,
  ...
}: let
  pyproject = lib.importTOML (config.mkDerivation.src + /pyproject.toml);
in {
  imports = [
    dream2nix.modules.dream2nix.pip
    dream2nix.modules.dream2nix.flags
  ];

  deps = {
    nixpkgs,
    self,
    ...
  }: {
    stdenv = nixpkgs.stdenv;
    python = nixpkgs.python312;
    pythonPackages = nixpkgs.python312Packages;
  };

  flagsOffered = {
    groupDev = "include dependencies for optional [dev] pip group";
  };

  flags = {
    groupDev = lib.mkDefault false;
  };

  inherit (pyproject.project) name version;

  mkDerivation = {
    src = ./.;
    buildInputs = [
      config.deps.python
    ];
  };

  buildPythonPackage = {
    format = lib.mkForce "pyproject";
  };

  pip = {
    requirementsList =
      pyproject.build-system.requires
      or []
      ++ pyproject.project.dependencies
      ++ lib.optionals (config.flags.groupDev) pyproject.project.optional-dependencies.dev;
    flattenDependencies = true;
    overrideAll.deps.python = lib.mkForce config.deps.python;
    overrides = {
    };
  };
}
