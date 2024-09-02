{
  cmake,
  jrl-cmakemodules,
  lib,
  stdenv,
}:

stdenv.mkDerivation {
  pname = "gerard-bauzil";
  version = "unstable-2024-09-02";

  src = lib.fileset.toSource {
    root = ./.;
    fileset = lib.fileset.unions [
      ./CMakeLists.txt
      ./data
      ./launch
      ./maps
      ./meshes
      ./package.xml
      ./scripts
      ./srdf
      ./urdf
      ./xacro
    ];
  };

  nativeBuildInputs = [
    cmake
    jrl-cmakemodules
  ];

  meta = {
    description = "3D model of the Gerard Bauzil experimental room";
    homepage = "https://github.com/gepetto/gerard-bauzil";
    license = lib.licenses.bsd2;
    maintainers = with lib.maintainers; [ nim65s ];
  };
}
