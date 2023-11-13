{ stdenv }:
stdenv.mkDerivation rec {
  name = "hello-overlay";
  phases = [ "installPhase" ];
  installPhase = ''
    mkdir -p $out/bin/
    touch $out/bin/${name}
    echo "echo 'Hello ${name}'" >> $out/bin/${name}
    chmod +x $out/bin/${name}
  '';
}
