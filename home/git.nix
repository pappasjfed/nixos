{
    programs.git = {
    enable = true;

    settings = {
      user = {
        name = "John Pappas";
        email = "john.pappas.ctr@amentum.com";
      };
      credential.helper = "";
    };
  };

  programs.gh = {
    enable = true;

    settings = {
      git_protocol = "https";
    };
  };
  
}
