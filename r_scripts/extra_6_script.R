# load pack
pacman::p_load(
  rsthemes
)


(1*(((2+3)*4)+6))+7

# download extra themes
rsthemes::install_rsthemes(include_base16 = TRUE)

# list installed themes
rsthemes::list_rsthemes()

# Try all themes
rsthemes::try_rsthemes()

#------#
# Where does R store packages?
.libPaths()

# open terminal:
# mac shift+option+r
# win: (not sure) shift+alt+t

# lets see the files:
# cmd: open /Library/Frameworks/R.framework/Versions/4.1/Resources/library

# edit theme:
# cmd: open /Library/Frameworks/R.framework/Versions/4.1/Resources/library/rsthemes/themes/a11y-dark.rstheme
