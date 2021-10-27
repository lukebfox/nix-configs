final: prev:
{
  # ncppcpp with batteries included.
  ncmpcpp = prev.ncmpcpp.override {
    visualizerSupport = true;
    clockSupport = true;
  };
}
