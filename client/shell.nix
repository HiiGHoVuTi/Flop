
with import (fetchTarball "https://github.com/knarkzel/nixpkgs/archive/043de04db8a6b0391b3fefaaade160514d866946.tar.gz") {};

mkShell {
  buildInputs = [ flutter dart ];
}
