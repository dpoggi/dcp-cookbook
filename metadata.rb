name             'dcp'
maintainer       'Dan Poggi'
maintainer_email 'dan.poggi@gmail.com'
license          'MIT'
description      'Installs/configures dotfiles and other configuration standards'
version          '0.1.5'

recipe 'dcp', 'Installs/configures dotfiles and other configuration standards'

depends 'git'
depends 'zsh'
depends 'users'

supports 'ubuntu'
