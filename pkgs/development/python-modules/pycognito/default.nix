{ lib
, boto3
, buildPythonPackage
, envs
, fetchFromGitHub
, isPy27
, mock
, pytestCheckHook
, python-jose
, requests
}:

buildPythonPackage rec {
  pname = "pycognito";
  version = "2022.02.1";
  disabled = isPy27;

  src = fetchFromGitHub {
    owner = "pvizeli";
    repo = pname;
    rev = version;
    sha256 = "sha256-0PqeZ8yy2MzvIi1xQNosR7V2Ma3tMT0Q/v4OIv7f1Kg=";
  };

  propagatedBuildInputs = [
    boto3
    envs
    python-jose
    requests
  ];

  checkInputs = [
    mock
    pytestCheckHook
  ];

  postPatch = ''
    substituteInPlace setup.py \
      --replace 'python-jose[cryptography]' 'python-jose'
  '';

  pytestFlagsArray = [ "tests.py" ];

  pythonImportsCheck = [ "pycognito" ];

  meta = with lib; {
    description = "Python class to integrate Boto3's Cognito client so it is easy to login users. With SRP support";
    homepage = "https://github.com/pvizeli/pycognito";
    license = licenses.asl20;
    maintainers = with maintainers; [ mic92 ];
  };
}
