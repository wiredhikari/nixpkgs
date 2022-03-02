{ lib
, fetchPypi
, buildPythonPackage
, six
, nose
}:
buildPythonPackage rec {
  pname = "intbitset";
  version = "3.0.0";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-tDG3CAlTZvz9Pi2pLq0TEPhl3DyYuWQS1N6VNNNokEE=";
  };

  patches = [
    # fixes compilation on aarch64 and determinism (uses -march=core2 and
    # -mtune=native)
    ./remove-impure-tuning.patch
  ];

  propagatedBuildInputs = [
    six
  ];

  checkInputs = [
    nose
  ];

  checkPhase = ''
    nosetests
  '';

  pythonImportsCheck = [
    "intbitset"
  ];

  meta = with lib; {
    description = "C-based extension implementing fast integer bit sets";
    homepage = "https://github.com/inveniosoftware/intbitset";
    license = licenses.lgpl3Only;
    maintainers = teams.determinatesystems.members;
  };
}
