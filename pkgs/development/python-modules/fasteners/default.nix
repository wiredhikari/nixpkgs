{ lib
, buildPythonPackage
, fetchPypi
, six
, monotonic
, diskcache
, more-itertools
, testtools
, isPy3k
, nose
, futures ? null
}:

buildPythonPackage rec {
  pname = "fasteners";
  version = "0.17.3";

  src = fetchPypi {
    inherit pname version;
    sha256 = "sha256-qaQqIIVz1AdMd9BBRHM2z048E4miVv0+ET71nPKbeYA=";
  };

  propagatedBuildInputs = [
    six
    monotonic
  ];

  checkInputs = [
    diskcache
    more-itertools
    testtools
    nose
  ] ++ lib.optionals (!isPy3k) [
    futures
  ];

  checkPhase = ''
    nosetests
  '';

  meta = with lib; {
    description = "A python package that provides useful locks";
    homepage = "https://github.com/harlowja/fasteners";
    license = licenses.asl20;
  };

}
