{ lib
, buildPythonPackage
, fetchPypi
, configparser
, pytest
, isPy3k
}:

buildPythonPackage rec {
  pname = "entrypoints";
  version = "0.4";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-twbt2qkhihnrzWe1aBjwW7J1ibHKno15e3Sv+tTMrNQ=";
  };

  checkInputs = [ pytest ];

  propagatedBuildInputs = lib.optional (!isPy3k) configparser;

  checkPhase = ''
    py.test tests
  '';

  meta = {
    description = "Discover and load entry points from installed packages";
    homepage = "https://github.com/takluyver/entrypoints";
    license = lib.licenses.mit;
  };
}
