{
  security.pki.certificates = [
    "../certs/amentumrootca2022.cer"
    "../certs/proxy_services.cer"
    "../certs/amentum_decryption.cer"
  ];

  environment.variables = {
    SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
    NIX_SSL_CERT_FILE = "/etc/ssl/certs/ca-bundle.crt";
  };
}
