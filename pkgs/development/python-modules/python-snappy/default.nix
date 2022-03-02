{ lib
, buildPythonPackage
, fetchPypi
, isPyPy
, snappy
, cffi
, nose
}:

buildPythonPackage rec {
  pname = "python-snappy";
  version = "0.6.1";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-tqEHqwYgasxTWdTFYyvZsi1EhwKnmzFpsMYuD7gIuyo=";
  };

  buildInputs = [ snappy ];

  propagatedBuildInputs = lib.optional isPyPy cffi;

  checkInputs = [ nose ];

  checkPhase = ''
    rm -r snappy # prevent local snappy from being picked up
    nosetests test_snappy.py
  '' + lib.optionalString isPyPy ''
    nosetests test_snappy_cffi.py
  '';

  meta = with lib; {
    description = "Python library for the snappy compression library from Google";
    homepage = "https://github.com/andrix/python-snappy";
    license = licenses.bsd3;
    maintainers = [ maintainers.costrouc ];
  };
}
