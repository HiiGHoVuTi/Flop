
with import <nixpkgs> {};

mkShell {
  buildInputs = [
    postgresql_jdbc
    clojure clojure-lsp leiningen
  ];
}
