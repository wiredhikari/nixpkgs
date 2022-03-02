{ lib, buildPythonPackage, fetchPypi
, setuptools-scm, pytest, pytest-freezegun, freezegun, backports_unittest-mock
, six, pytz, jaraco_functools, pythonOlder
, pytest-flake8, pytest-cov, pytest-black, pytest-mypy
}:

buildPythonPackage rec {
  pname = "tempora";
  version = "5.0.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-y6Dxl6ZIg78+c2V++8AyTVvxcXnndpsThbTXXSbNkSc=";
  };

  disabled = pythonOlder "3.2";

  nativeBuildInputs = [ setuptools-scm ];

  propagatedBuildInputs = [ six pytz jaraco_functools ];

  checkInputs = [
    pytest-freezegun pytest freezegun backports_unittest-mock
    pytest-flake8 pytest-cov pytest-black pytest-mypy
  ];

  checkPhase = ''
    pytest
  '';

  meta = with lib; {
    description = "Objects and routines pertaining to date and time";
    homepage = "https://github.com/jaraco/tempora";
    license = licenses.mit;
  };
}
