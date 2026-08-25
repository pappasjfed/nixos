{
  security.pki.certificates = [
    (builtins.readFile ../../certs/amentum_decryption.cer)
    (builtins.readFile ../../certs/amentumrootca2022.cer)
    (builtins.readFile ../../certs/proxy_services.cer)
  ];

  environment.variables = {
    SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
    NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
  };
}