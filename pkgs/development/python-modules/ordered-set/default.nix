{ buildPythonPackage, fetchPypi, lib, isPy27, pytest }:

buildPythonPackage rec {
  pname = "ordered-set";
  version = "4.1.0";
  disabled = isPy27;

  checkInputs = [ pytest ];

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-aUqORMh2V8WSku3nKJHrkdNBMfZTFGOqswCRkcdzZKg=";
  };

  checkPhase = ''
    py.test test.py
  '';

  meta = {
    description = "A MutableSet that remembers its order, so that every entry has an index.";
    license = lib.licenses.mit;
    maintainers = [ lib.maintainers.MostAwesomeDude ];
  };
}
